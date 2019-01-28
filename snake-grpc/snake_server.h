
#ifndef ASYLO_EXAMPLES_GRPC_SERVER_TRANSLATOR_SERVER_H_
#define ASYLO_EXAMPLES_GRPC_SERVER_TRANSLATOR_SERVER_H_

#include <string>

#include "absl/container/flat_hash_map.h"
#include "snake_server.grpc.pb.h"
#include "include/grpcpp/grpcpp.h"
#include "include/grpcpp/server.h"
#include "snake.h"
//#include "snake-grpc/snake.h"

namespace examples {
namespace grpc_server {

class SnakeServer final : public SnakeService::Service {
public:
  SnakeServer();

private:
  ::grpc::Status EatGold(::grpc::ServerContext *context,
                         const EnclaveInput *input,
                         EnclaveOutput *output) override;
private:
  snake_t m_snake;
  screen_t m_screen;
};

}  // namespace grpc_server
}  // namespace examples

#endif  // ASYLO_EXAMPLES_GRPC_SERVER_TRANSLATOR_SERVER_H_
