#include <openenclave/enclave.h>
#include "sgx_t.h"
#include <stdio.h>

extern void setup_level(screen_t* screen, snake_t* snake, int level);
extern void move(snake_t* snake, char keys[], char key);
extern int collide_object(snake_t* snake, screen_t* screen, char object);
extern int collision(snake_t* snake, screen_t* screen);
extern int eat_gold(snake_t* snake, screen_t* screen);

// add to handled lib calls
//int puts(char* __s) { 
//   int return_val;
//oe_result_t oe_result = puts_app(&return_val, __s);
//if (oe_result != OE_OK) {
//fprintf(stderr, "Failed to invoke ocall puts");
//}
//return return_val;
//}
//

void show_score(screen_t* screen) { 
	oe_result_t oe_result = show_score_app(screen);
	if (oe_result != OE_OK) {
		fprintf(stderr, "Failed to invoke ocall show_score");
	}
}

void draw_line(int col, int row) { 
	oe_result_t oe_result = draw_line_app(col, row);
	if (oe_result != OE_OK) {
		fprintf(stderr, "Failed to invoke ocall draw_line");
	}
}

void setup_level_protected(screen_t* screen, snake_t* snake, int level) { 
	setup_level(screen, snake, level);
}

void move_protected(snake_t* snake, char keys[], char key) { 
	move(snake, keys, key);
}

int collide_object_protected(snake_t* snake, screen_t* screen, char object) { 
	return collide_object(snake, screen, object);
}

int collision_protected(snake_t* snake, screen_t* screen) { 
	return collision(snake, screen);
}

int eat_gold_protected(snake_t* snake, screen_t* screen) { 
	return eat_gold(snake, screen);
}

//static oe_enclave_t* enclave = NULL;
