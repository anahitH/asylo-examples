/* Micro Snake, based on a simple simple snake game by Simon Huggins
 *
 * Copyright (c) 2003, 2004  Simon Huggins <webmaster@simonhuggins.com>
 * Copyright (c) 2009  Joachim Nilsson <troglobit@gmail.com>
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 * Original Borland Builder C/C++ snake code available at Simon's home page
 * http://www.simonhuggins.com/courses/cbasics/course_notes/snake.htm
 */

#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <time.h>

#include "conio.h"
#include "snake.h"

#include <errno.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>

#define RB_MODE_RD 0
#define RB_MODE_WR 1

char TMP_DIRECTORY_CONF[] = "/tmp/ipc_conf";
char TMP_DIRECTORY_RUN[] = "/tmp/ipc_run";
char TMP_FILE_NUMBER_FMT[] =  "/pipe_";
int NAME_BUF_SIZE = 256;


#ifdef DEBUG
#define DBG(fmt, args...) fprintf (stderr, fmt, ##args)
#else
#define DBG(fmt, args...)
#endif

/* Default 0.2 sec between snake movement. */
unsigned int usec_delay = DEFAULT_DELAY;

int fd_ea = -1;
int fd_ae = -1;

void setup_pipe()
{
	printf("aaaa\n");
    char port_enc_to_app[NAME_BUF_SIZE];
    char port_app_to_enc[NAME_BUF_SIZE];
    strcpy(port_enc_to_app, "33333");
    strcpy(port_app_to_enc, "33335");

    if(pipe_init(0) < 0) {
        perror("Error in pipe_init");
        exit(1);
    }
	printf("bbbb\n");

    if((fd_ea = pipe_open(port_enc_to_app, RB_MODE_RD, 0)) < 0) {
        perror("Error in pipe_open");
        exit(1);
    }

    if((fd_ae = pipe_open(port_app_to_enc, RB_MODE_WR, 0)) < 0) {
        perror("Error in pipe_open");
        exit(1);
    }
}

int pipe_init(int flag_dir)
{
printf("pipe init\n");
	int ret;

	if(flag_dir == 0)
		ret = mkdir(TMP_DIRECTORY_CONF, 0770);
	else if(flag_dir == 1)
		ret = mkdir(TMP_DIRECTORY_RUN, 0770);

	if(ret == -1)
	{
		if(errno != EEXIST) {
                puts("Fail to mkdir");
                return -1;
        }
	}
	return 0;
}

int pipe_open(char *unique_id, int is_write, int flag_dir)
{
	char name_buf[NAME_BUF_SIZE];

    if (flag_dir == 0) {
        strcpy(name_buf, TMP_DIRECTORY_CONF);
        strcpy(name_buf+strlen(name_buf), TMP_FILE_NUMBER_FMT);
        strcpy(name_buf+strlen(name_buf), unique_id);
    }
    else if (flag_dir == 1) {
        strcpy(name_buf, TMP_DIRECTORY_RUN);
        strcpy(name_buf+strlen(name_buf), TMP_FILE_NUMBER_FMT);
        strcpy(name_buf+strlen(name_buf), unique_id);
    }

	int ret = mknod(name_buf, S_IFIFO | 0770, 0);
	if(ret == -1)
	{
        if(errno != EEXIST) {
            puts("Fail to mknod");
            return -1;
        }
	}

	int flag = O_ASYNC;
	if(is_write)
		flag |= O_WRONLY;
	else
		flag |= O_RDONLY;

	int fd = open(name_buf, flag);

    if(fd == -1)
    {
        puts("Fail to open");
        return -1;
    }

    return fd;
}


int sigsetup (int signo, void (*callback)(int))
{
   struct sigaction action;

   sigemptyset(&action.sa_mask);
   //sigaddset(&action.sa_mask, signo);
   action.sa_flags = 0;
   action.sa_handler = callback;
   if (SIGALRM == signo)
   {
#ifdef SA_INTERRUPT
      action.sa_flags |= SA_INTERRUPT; /* SunOS 4.x */
#endif
   }
   else
   {
#ifdef SA_RESTART
      action.sa_flags |= SA_RESTART; /* SVR4, 4.4BSD */
#endif
   }

   return sigaction (signo, &action, NULL);
}

void sig_handler (int signal __attribute__ ((unused)))
{
   clrscr ();
   DBG("Received signal %d\n", signal);
   exit (WEXITSTATUS(system ("stty sane")));
}

void alarm_handler (int signal __attribute__ ((unused)))
{
   static struct itimerval val;

   if (!signal)
   {
      sigsetup (SIGALRM, alarm_handler);
   }

   val.it_value.tv_sec  = 0;
   val.it_value.tv_usec = usec_delay;

   setitimer (ITIMER_REAL, &val, NULL);
}

void show_score (screen_t *screen)
{
   textcolor (LIGHTCYAN);
   gotoxy (3, MAXROW + 2);
   printf ("Level: %05d", screen->level);

   textcolor (YELLOW);
   gotoxy (21, MAXROW + 2);
   printf ("Gold Left: %05d", screen->gold);

   textcolor (LIGHTGREEN);
   gotoxy (43, MAXROW + 2);
   printf ("Score: %05d", screen->score);

   textcolor (LIGHTMAGENTA);
   gotoxy (61, MAXROW + 2);
   printf ("High Score: %05d", screen->high_score);
}

void draw_line (int col, int row)
{
   int i;

   gotoxy (col, row);
   textbackground (LIGHTBLUE);
   textcolor (LIGHTBLUE);

   for (i = 0; i < MAXCOL + 2; i++)
   {
      if (i == 0 || i == MAXCOL + 1)
         printf ("+");
      else
         printf ("-");
   }

   textattr (RESETATTR);
}

/* If level==0 then just move on to the next level
 * if level==1 restart game
 * Otherwise start game at that level. */
void setup_level (screen_t *screen, snake_t *snake, int level)
{
   int i, row, col;

   srand ((unsigned int)time (NULL));

   /* Initialize on (re)start */
   if (1 == level)
   {
      screen->score = 0;
      screen->obstacles = 4;
      screen->level = 1;
      snake->speed = 14;
      snake->dir = RIGHT;
   }
   else
   {
      screen->score += screen->level * 1000;
      screen->obstacles += 2;
      screen->level++;          /* add to obstacles */

      if ((screen->level % 5 == 0) && (snake->speed > 1))
      {
         snake->speed--;        /* increase snake->speed every 5 levels */
      }
   }

   /* Set up global variables for new level */
   screen->gold = 0;
   snake->len = level + 4;
   usec_delay = DEFAULT_DELAY - level * 10000;

   /* Fill grid with blanks */
   for (row = 0; row < MAXROW; row++)
   {
      for (col = 0; col < MAXCOL; col++)
      {
         screen->grid[row][col] = ' ';
      }
   }

   /* Fill grid with objects */
   for (i = 0; i < screen->obstacles * 2; i++)
   {
      /* Find free space to place an object on. */
      do
      {
         row = rand () % MAXROW;
         col = rand () % MAXCOL;
      }
      while (screen->grid[row][col] != ' ');

      if (i < screen->obstacles)
      {
         screen->grid[row][col] = CACTUS;
      }
      else
      {
         screen->gold++;
         screen->grid[row][col] = GOLD;
      }
   }

   /* Create snake array of length snake->len */
   for (i = 0; i < snake->len; i++)
   {
      snake->body[i].row = START_ROW;
      snake->body[i].col = snake->dir == LEFT ? START_COL - i : START_COL + i;
   }

   /* Draw playing board */
   clrscr();
   draw_line (1, 1);

   for (row = 0; row < MAXROW; row++)
   {
      gotoxy (1, row + 2);

      textcolor (LIGHTBLUE);
      textbackground (LIGHTBLUE);
      printf ("|");
      textattr (RESETATTR);

      textcolor (WHITE);
      for (col = 0; col < MAXCOL; col++)
      {
         printf ("%c", screen->grid[row][col]);
      }

      textcolor (LIGHTBLUE);
      textbackground (LIGHTBLUE);
      printf ("|");
      textattr (RESETATTR);
   }

   draw_line (1, MAXROW + 2);

   show_score (screen);

   textcolor (LIGHTRED);
   //gotoxy (3, 1);
   //printf ("h:Help");
   gotoxy (30, 1);
}

void move (snake_t *snake, char keys[], char key)
{
   int i;
   direction_t prev = snake->dir;

   if (key == keys[RIGHT])
   {
      snake->dir = RIGHT;
   }
   else if (key == keys[LEFT])
   {
      snake->dir = LEFT;
   }
   else if (key == keys[UP])
   {
      snake->dir = UP;
   }
   else if (key == keys[DOWN])
   {
      snake->dir = DOWN;
   }
   else if (key == keys[LEFT_TURN])
   {
      switch (prev)
      {
         case LEFT:
            snake->dir = DOWN;
            break;

         case RIGHT:
            snake->dir = UP;
            break;

         case UP:
            snake->dir = LEFT;
            break;

         case DOWN:
            snake->dir = RIGHT;
            break;

         default:
            break;
      }
   }
   else if (key == keys[RIGHT_TURN])
   {
      switch (prev)
      {
         case LEFT:
            snake->dir = UP;
            break;

         case RIGHT:
            snake->dir = DOWN;
            break;

         case UP:
            snake->dir = RIGHT;
            break;

         case DOWN:
            snake->dir = LEFT;
            break;

         default:
            break;
      }
   }

   switch (snake->dir)
   {
      case LEFT:
         snake->body[snake->len].row = snake->body[snake->len - 1].row;
         snake->body[snake->len].col = snake->body[snake->len - 1].col - 1;
         break;

      case RIGHT:
         snake->body[snake->len].row = snake->body[snake->len - 1].row;
         snake->body[snake->len].col = snake->body[snake->len - 1].col + 1;
         break;

      case UP:
         snake->body[snake->len].row = snake->body[snake->len - 1].row - 1;
         snake->body[snake->len].col = snake->body[snake->len - 1].col;
         break;

      case DOWN:
         snake->body[snake->len].row = snake->body[snake->len - 1].row + 1;
         snake->body[snake->len].col = snake->body[snake->len - 1].col;
         break;

      default:
         /* NOP */
         break;
   }

   /* Blank last segment of snake */
   textattr (RESETATTR);
   gotoxy (snake->body[0].col + 1, snake->body[0].row + 1);
   puts (" ");

   /* ... and remove it from the array */
   for (i = 1; i <= snake->len; i++)
   {
      snake->body[i - 1] = snake->body[i];
   }

   /* Display snake in yellow */
   textbackground (YELLOW);
   for (i = 0; i < snake->len; i++)
   {
      gotoxy (snake->body[i].col + 1, snake->body[i].row + 1);
      puts (" ");
   }
   textattr (RESETATTR);
#ifdef DEBUG
   gotoxy (71, 1);
   printf ("(%02d,%02d)", snake->body[snake->len - 1].col, snake->body[snake->len - 1].row);
#endif
}

int collide_walls (snake_t *snake)
{
   snake_segment_t *head = &snake->body[snake->len - 1];

   if ((head->row > MAXROW) || (head->row < 1) ||
       (head->col > MAXCOL) || (head->col < 1))
   {
      DBG("Wall collision.\n");
      return 1;
   }

   return 0;
}

int collide_object (snake_t *snake, screen_t *screen, char object)
{
   snake_segment_t *head = &snake->body[snake->len - 1];

   if (screen->grid[head->row - 1][head->col - 1] == object)
   {
      DBG("Object '%c' collision.\n", object);
      return 1;
   }

   return 0;
}

int collide_self (snake_t *snake)
{
   int i;
   snake_segment_t *head = &snake->body[snake->len - 1];

   for (i = 0; i < snake->len - 1; i++)
   {
      snake_segment_t *body = &snake->body[i];

      if (head->row == body->row && head->col == body->col)
      {
         DBG("Self collision.\n");
         return 1;
      }
   }

   return 0;
}

int collision (snake_t *snake, screen_t *screen)
{
   return collide_walls (snake) ||
      collide_object (snake, screen, CACTUS) ||
      collide_self (snake);
}

int eat_gold (snake_t *snake, screen_t *screen)
{
    int len;
    len = strlen("Hey there");
    write(fd_ae, &len, sizeof(int));
    write(fd_ae, "Hey There", len+1);

   snake_segment_t *head = &snake->body[snake->len - 1];

   /* We're called after collide_object() so we know it's
    * a piece of gold at this position.  Eat it up! */
   screen->grid[head->row - 1][head->col - 1] = ' ';

   screen->gold--;
   screen->score += snake->len * screen->obstacles;
   snake->len++;

   if (screen->score > screen->high_score)
   {
      screen->high_score = screen->score; /* New high score! */
   }

   return screen->gold;
}

int main (void)
{
   setup_pipe();
   char keypress;
   snake_t snake;
   screen_t screen;
   char keys[NUM_KEYS] = DEFAULT_KEYS;

   if (WEXITSTATUS(system ("stty cbreak -echo stop u")))
   {
      fprintf (stderr, "Failed setting up the screen, is 'stty' missing?\n");
      return 1;
   }

   /* Call it once to initialize the timer. */
   alarm_handler (0);

   sigsetup (SIGINT, sig_handler);
   sigsetup (SIGHUP, sig_handler);
   sigsetup (SIGTERM, sig_handler);

   do
   {
      setup_level (&screen, &snake, 1);

      do
      {
         keypress = (char)getchar ();

         /* Move the snake one position. */
         move (&snake, keys, keypress);

         /* keeps cursor flashing in one place instead of following snake */
         gotoxy (1, 1);

         if (collision (&snake, &screen))
         {
            keypress = keys[QUIT];
            break;
         }
         else if (collide_object (&snake, &screen, GOLD))
         {
            /* If no gold left after consuming this one... */
            if (!eat_gold (&snake, &screen))
            {
               /* ... then go to next level. */
               setup_level (&screen, &snake, 0);
            }

            show_score (&screen);
         }
      }
      while (keypress != keys[QUIT]);

      show_score (&screen);

      gotoxy (32, 6);
      textcolor (LIGHTRED);
      printf ("-G A M E  O V E R-");

      gotoxy (32, 9);
      textcolor (YELLOW);
      printf ("Another Game (y/n)? ");

      do
      {
         keypress = getchar ();
      }
      while ((keypress != 'y') && (keypress != 'n'));
   }
   while (keypress == 'y');

   clrscr ();

   return WEXITSTATUS(system ("stty sane"));
}


/**
 * Local Variables:
 *  version-control: t
 *  c-file-style: "ellemtel"
 * End:
 */