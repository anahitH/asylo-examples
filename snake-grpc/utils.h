#include "snake.h"
#include "snake_server.pb.h"

direction_t getSnakeDirection(examples::grpc_server::Snake_direction_t dir);
examples::grpc_server::Snake_direction_t getSnakeAsyloDirection(direction_t dir);
void createAsyloSnake(snake_t* snake, examples::grpc_server::Snake* snake_in);
void createAsyloScreen(screen_t* screen, examples::grpc_server::Screen* screen_in);
void createSnake(snake_t* snake, const examples::grpc_server::Snake* snake_out);
void createScreen(screen_t* screen, const examples::grpc_server::Screen* screen_out);

