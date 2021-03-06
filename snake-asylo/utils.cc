#include "utils.h"

direction_t getSnakeDirection(guide::asylo::Snake_direction_t dir)
{
    switch (dir)
    {
     case LEFT:
	     return direction_t::LEFT;
     case RIGHT:
	     return direction_t::RIGHT;
     case UP:
	     return direction_t::UP;
     case DOWN:
	     return direction_t::DOWN;
     case LEFT_TURN:
	     return direction_t::LEFT_TURN;
     case RIGHT_TURN:
	     return direction_t::RIGHT_TURN;
     case QUIT:
	     return direction_t::QUIT;
     case NUM_KEYS:
	     return direction_t::NUM_KEYS;
     default:
	     return direction_t::NUM_KEYS;
    }
    return direction_t::NUM_KEYS;
}

guide::asylo::Snake_direction_t getSnakeAsyloDirection(direction_t dir)
{
    switch (dir)
    {
     case direction_t::LEFT:
	     return guide::asylo::Snake::LEFT;
     case RIGHT:
             return guide::asylo::Snake::RIGHT;
     case UP:
             return guide::asylo::Snake::UP;
     case DOWN:
             return guide::asylo::Snake::DOWN;
     case LEFT_TURN:
             return guide::asylo::Snake::LEFT_TURN;
     case RIGHT_TURN:
             return guide::asylo::Snake::RIGHT_TURN;
     case QUIT:
             return guide::asylo::Snake::QUIT;
     case NUM_KEYS:
	     return guide::asylo::Snake::NUM_KEYS;
     default:
	     return guide::asylo::Snake::NUM_KEYS;
    }
    return guide::asylo::Snake::NUM_KEYS;
}

void SetSnakeBody(snake_segment_t body[],
	          google::protobuf::RepeatedPtrField<guide::asylo::SnakeSegment>* snake_body)
{
   assert(snake_body);
   snake_body->Reserve(100);
    for (int i = 0; i < 100; ++i) {
	guide::asylo::SnakeSegment segment;
	segment.set_row(body[i].row);
	segment.set_col(body[i].col);
	if (i >= snake_body->size()) {
	    auto* seg = snake_body->Add();
	    *seg = segment;
	} else {
	    (*snake_body)[i] = segment;
	}
    }
}

void createAsyloSnake(snake_t* snake, guide::asylo::Snake* snake_input)
{
   snake_input->set_speed(snake->speed);
   snake_input->set_direction(getSnakeAsyloDirection(snake->dir));
   snake_input->set_len(snake->len);
   SetSnakeBody(snake->body, snake_input->mutable_body());
}

void createAsyloScreen(screen_t* screen, guide::asylo::Screen* screen_input)
{
   screen_input->set_level(screen->level);
   screen_input->set_score(screen->score);
   screen_input->set_highscore(screen->high_score);
   screen_input->set_gold(screen->gold);
   screen_input->set_obstacles(screen->obstacles);
   //auto* grid = screen_input->mutable_grid();
   for (int i = 0; i < MAXROW; ++i) {
	guide::asylo::Screen_cell* mutable_row;
	if (i >= screen_input->grid_size()) {
	   mutable_row = screen_input->add_grid();
	} else {
	   mutable_row = screen_input->mutable_grid(i);
	}
	for (int j = 0; j < MAXCOL; ++j) {
	   if (j >= mutable_row->cell_size()) {
		mutable_row->add_cell(screen->grid[i][j]);
	   } else {
		mutable_row->set_cell(j, screen->grid[i][j]);
	   }
	}
	//(*grid)[i] = row;
   }
}

void createSnake(snake_t* snake, const guide::asylo::Snake* snake_out)
{
    snake->speed = snake_out->speed();
    snake->dir = getSnakeDirection(snake_out->direction());
    snake->len = snake_out->len();
    const auto& body_pb = snake_out->body();
    for (int i = 0; i < body_pb.size(); ++i) {
	auto snake_seg = body_pb.Get(i);
	snake->body[i].row = snake_seg.row();
	snake->body[i].col = snake_seg.col();
    }
}

void createScreen(screen_t* screen, const guide::asylo::Screen* screen_out)
{
    screen->level = screen_out->level();
    screen->score = screen_out->score();
    screen->high_score = screen_out->highscore();
    screen->gold = screen_out->gold();
    screen->obstacles = screen_out->obstacles();
    const auto& grid = screen_out->grid();
    for (int i = 0; i < MAXROW; ++i) {
	const auto& row = grid.Get(i);
	for (int j = 0; j < MAXCOL; ++j) {
	    screen->grid[i][j] = row.cell(j);
	}
    }
}

