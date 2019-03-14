#include "interface_selectors.h"

#include <iostream>
#include <string>

#include "gflags/gflags.h"
#include "asylo/platform/primitives/extent.h"
#include "asylo/platform/primitives/sim/untrusted_sim.h"
#include "asylo/platform/primitives/untrusted_primitives.h"
#include "asylo/platform/primitives/util/dispatch_table.h"
#include "asylo/util/status_macros.h"

#include "snake.h"

DEFINE_string(enclave_path, "",
              "Path to the Simulated enclave binary (snake.so)");

namespace asylo {
namespace primitives {

std::shared_ptr<EnclaveClient> client;

Status print(std::shared_ptr<EnclaveClient> client_, void *context, UntrustedParameterStack *params) {
  std::cout << params->Pop()->As<std::string>() << "\n";
  return Status::OkStatus();
}

Status eat_gold(snake_t *snake, screen_t *screen, int* returnVal) {
  UntrustedParameterStack params;
  *params.PushAlloc<snake_t>() = *snake;
  *params.PushAlloc<screen_t>() = *screen;
  auto status = client->EnclaveCall(keat_goldEnclaveSelector, &params);
  *snake = params.Pop<snake_t>();
  *screen = params.Pop<screen_t>();
  *returnVal = params.Pop<int>();

  return Status::OkStatus();
}

Status registerOCalls()
{
  ASYLO_ASSIGN_OR_RETURN(
      client, LoadEnclave<SimBackend>(FLAGS_enclave_path,
                                      absl::make_unique<DispatchTable>()));

  auto status = client->exit_call_provider()->RegisterExitHandler(
      kprintOcallHandler, ExitHandler{print});
  return Status::OkStatus();
}


}  // namespace primitives
}  // namespace asylo

int eat_gold (snake_t *snake, screen_t *screen) {
  int returnVal = 0;
  asylo::primitives::eat_gold(snake, screen, &returnVal);
  return returnVal;
}

extern int app_main(void);
int main(int argc, char *argv[]) {
  google::ParseCommandLineFlags(&argc, &argv, /*remove_flags=*/true);
  asylo::primitives::registerOCalls();
  app_main();
  return 0;
}

