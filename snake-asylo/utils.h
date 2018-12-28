#include "snake-asylo/snake.h"
#include "snake-asylo/snake.pb.h"

direction_t getSnakeDirection(guide::asylo::Snake_direction_t dir);
guide::asylo::Snake_direction_t getSnakeAsyloDirection(direction_t dir);
void createAsyloSnake(snake_t* snake, guide::asylo::Snake* snake_in);
void createAsyloScreen(screen_t* screen, guide::asylo::Screen* screen_in);
void createSnake(snake_t* snake, const guide::asylo::Snake* snake_out);
void createScreen(screen_t* screen, const guide::asylo::Screen* screen_out);

