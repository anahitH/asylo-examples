#include "snake_server.h"

#include "absl/strings/ascii.h"
#include "absl/strings/str_cat.h"
#include "include/grpcpp/grpcpp.h"
#include "utils.h"

extern int eat_gold(snake_t* snake, screen_t* screen);
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
  eat_gold(&m_snake, &m_screen);

  auto* snake_out = output->mutable_snake_out();
  createAsyloSnake(&m_snake, snake_out);
  auto* score_out = output->mutable_screen_out();
  createAsyloScreen(&m_screen, score_out);
  auto* ret = output->mutable_ret();
  ret->set_eat_gold(m_screen.gold);
  std::cout << "Gold Left " << m_screen.gold << "\n";
  printf("blah\n");
  return ::grpc::Status::OK;
}

}  // namespace grpc_server
}  // namespace examples
