#include "snake-grpc/snake_server.h"

#include "absl/strings/ascii.h"
#include "absl/strings/str_cat.h"
#include "include/grpcpp/grpcpp.h"
#include "snake-grpc/utils.h"

namespace examples {
namespace grpc_server {

SnakeServer::SnakeServer()
    : Service()
{}

::grpc::Status SnakeServer::EatGold(::grpc::ServerContext *context,
                         const EnclaveInput *input,
                         EnclaveOutput *output)
{
	std::cout << "EatGold\n";
  createSnake(&m_snake, &input->snake_in());
  createScreen(&m_screen, &input->screen_in());
  eat_gold();

  auto* snake_out = output->mutable_snake_out();
  createAsyloSnake(&m_snake, snake_out);
  auto* score_out = output->mutable_screen_out();
  createAsyloScreen(&m_screen, score_out);
  auto* ret = output->mutable_ret();
  ret->set_eat_gold(m_screen.gold);
  std::cout << "Gold Left " << m_screen.gold << "\n";
  return ::grpc::Status::OK;
}

void SnakeServer::eat_gold()
{
   snake_segment_t *head = &m_snake.body[m_snake.len - 1];

   /* We're called after collide_object() so we know it's
    * a piece of gold at this position.  Eat it up! */
   m_screen.grid[head->row - 1][head->col - 1] = ' ';

   m_screen.gold--;
   m_screen.score += m_snake.len * m_screen.obstacles;
   m_snake.len++;

   if (m_screen.score > m_screen.high_score)
   {
      m_screen.high_score = m_screen.score; /* New high score! */
   }
}

}  // namespace grpc_server
}  // namespace examples
