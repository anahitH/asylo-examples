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

#include <time.h>

DEFINE_string(enclave_path, "",
              "Path to the Simulated enclave binary (snake.so)");

extern void draw_line(int col, int row);

namespace asylo {
namespace primitives {

std::shared_ptr<EnclaveClient> client;

Status insecure_puts(std::shared_ptr<EnclaveClient> client_, void *context, UntrustedParameterStack *params)
{
  //std::cout << "In puts\n";
  auto extent = params->Pop();
  char *str = extent->As<char>();
  int returnValue = puts(str);
  *params->PushAlloc<int>() = returnValue;
  return Status::OkStatus();
}

Status insecure_time (std::shared_ptr<EnclaveClient> client_, void *context, UntrustedParameterStack *params)
{
  auto timeExt = params->Pop();
  time_t returnVal;
  if (timeExt->data() == NULL) {
     returnVal = time(NULL);
  } else {
     time_t timer = params->Pop<time_t>();
     returnVal = time(&timer);
  }
  printf("%s\n", asctime(gmtime(&returnVal)));
  *params->PushAlloc<time_t>() = returnVal;
  return Status::OkStatus();
}

Status insecure_srand (std::shared_ptr<EnclaveClient> client_, void *context, UntrustedParameterStack *params)
{
  //std::cout << "In app srand\n";
  int seed = params->Pop<int>();
  srand(seed);
  return Status::OkStatus();
}

Status insecure_rand (std::shared_ptr<EnclaveClient> client_, void *context, UntrustedParameterStack *params)
{
  //std::cout << "In rand\n";
  int returnVal = rand();
  *params->PushAlloc<int>() = returnVal;
  return Status::OkStatus();
}

Status insecure_draw_line(std::shared_ptr<EnclaveClient> client_, void *context, UntrustedParameterStack *params)
{
  //std::cout << "in draw line\n";
  int row = params->Pop<int>();
  int col = params->Pop<int>();
  draw_line(col, row);
  *params->PushAlloc<int>() = row;
  *params->PushAlloc<int>() = col;
  return Status::OkStatus();
}

Status print(std::shared_ptr<EnclaveClient> client_, void *context, UntrustedParameterStack *params) {
  auto extent = params->Pop();
  char *str = extent->As<char>();
  printf("From enclave %s", str);
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

Status setup_level(screen_t* screen, snake_t* snake, int level) {
  //std::cout << "setup_level\n";
  UntrustedParameterStack params;
  *params.PushAlloc<screen_t>() = *screen;
  *params.PushAlloc<snake_t>() = *snake;
  *params.PushAlloc<int>() = level;
  //std::cout << "calling setup_level\n";
  auto status = client->EnclaveCall(ksetup_levelEnclaveSelector, &params);
  //std::cout << "called setup_level\n";
  *screen = params.Pop<screen_t>();
  *snake = params.Pop<snake_t>();
  level = params.Pop<int>();

  return Status::OkStatus();
}

Status show_score(screen_t* screen) {
  UntrustedParameterStack params;
  *params.PushAlloc<screen_t>() = *screen;
  auto status = client->EnclaveCall(kshow_scorelEnclaveSelector, &params);
  *screen = params.Pop<screen_t>();
  return Status::OkStatus();
}

Status collide_object(snake_t* snake, screen_t* screen, char object, int* returnValue)
{
  UntrustedParameterStack params;
  *params.PushAlloc<snake_t>() = *snake;
  *params.PushAlloc<screen_t>() = *screen;
  *params.PushAlloc<char>() = object;
  auto status = client->EnclaveCall(kcollide_objectEnclaveSelector, &params);
  *snake = params.Pop<snake_t>();
  *screen = params.Pop<screen_t>();
  object = params.Pop<char>();
  *returnValue = params.Pop<int>();
  return Status::OkStatus();
}

Status collision(snake_t* snake, screen_t* screen, int* returnValue)
{
  UntrustedParameterStack params;
  *params.PushAlloc<snake_t>() = *snake;
  *params.PushAlloc<screen_t>() = *screen;
  auto status = client->EnclaveCall(kcollisionEnclaveSelector, &params);
  *snake = params.Pop<snake_t>();
  *screen = params.Pop<screen_t>();
  *returnValue = params.Pop<int>();
  return Status::OkStatus();
}

Status move(snake_t* snake, char keys[], char key)
{
  UntrustedParameterStack params;
  *params.PushAlloc<snake_t>() = *snake;
  auto keys_ext = params.PushAlloc(strlen(keys));
  memcpy(keys_ext.As<char>(), keys, strlen(keys));
  *params.PushAlloc<char>() = key;

  auto status = client->EnclaveCall(kmoveEnclaveSelector, &params);

  *snake = params.Pop<snake_t>();
  auto return_keys_ext = params.Pop();
  keys = reinterpret_cast<char*>(return_keys_ext->data());
  key = params.Pop<char>();

  return Status::OkStatus();
}

Status registerOCalls()
{
  ASYLO_ASSIGN_OR_RETURN(
      client, LoadEnclave<SimBackend>(FLAGS_enclave_path,
                                      absl::make_unique<DispatchTable>()));

  auto status = client->exit_call_provider()->RegisterExitHandler(
      kprintOcallHandler, ExitHandler{print});
  status = client->exit_call_provider()->RegisterExitHandler(
      kdraw_lineOcallHandler, ExitHandler{insecure_draw_line});
  status = client->exit_call_provider()->RegisterExitHandler(
      ktimeOcallHandler, ExitHandler{insecure_time});
  status = client->exit_call_provider()->RegisterExitHandler(
      ksrandOcallHandler, ExitHandler{insecure_srand});
  status = client->exit_call_provider()->RegisterExitHandler(
      krandOcallHandler, ExitHandler{insecure_rand});
  status = client->exit_call_provider()->RegisterExitHandler(
      kputsOcallHandler, ExitHandler{insecure_puts});

  return Status::OkStatus();
}


}  // namespace primitives
}  // namespace asylo

int eat_gold (snake_t *snake, screen_t *screen) {
  int returnVal = 0;
  asylo::primitives::eat_gold(snake, screen, &returnVal);
  return returnVal;
}

void setup_level(screen_t* screen, snake_t* snake, int level)
{
  asylo::primitives::setup_level(screen, snake, level);
}

void show_score (screen_t *screen)
{
  asylo::primitives::show_score(screen);
}

int collide_object (snake_t *snake, screen_t *screen, char object)
{
  int returnValue = 0;
  asylo::primitives::collide_object(snake, screen, object, &returnValue);
  return returnValue;
}

int collision (snake_t *snake, screen_t *screen)
{
  int returnValue = 0;
  asylo::primitives::collision(snake, screen, &returnValue);
  return returnValue;
}

void move (snake_t *snake, char keys[], char key)
{
  asylo::primitives::move(snake, keys, key);
}

extern int app_main(void);
int main(int argc, char *argv[]) {
  google::ParseCommandLineFlags(&argc, &argv, /*remove_flags=*/true);
  asylo::primitives::registerOCalls();
  app_main();
  return 0;
}

