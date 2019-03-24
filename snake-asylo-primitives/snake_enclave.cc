#include "interface_selectors.h"

#include "asylo/platform/primitives/extent.h"
#include "asylo/platform/primitives/primitive_status.h"
#include "asylo/platform/primitives/trusted_primitives.h"
#include "asylo/util/status_macros.h"

#include "snake.h"
#include "enclave_conio.h"

// TODO: this should not be here
#include <stdio.h>
#include <stdarg.h>

extern int eat_gold(snake_t* snake, screen_t* screen);
extern void setup_level(screen_t* screen, snake_t* snake, int level);
extern void show_score(screen_t* screen);
extern int collide_object(snake_t* snake, screen_t* screen, char object);
extern int collision (snake_t *snake, screen_t *screen);
extern void move (snake_t *snake, char keys[], char key);

namespace asylo {
namespace primitives {

namespace {

PrimitiveStatus puts(const char* str, int* returnVal)
{
  TrustedParameterStack params;
  params.Push(Extent(str, strlen(str)));
  ASYLO_RETURN_IF_ERROR(TrustedPrimitives::UntrustedCall(kputsOcallHandler,
                                                         &params));
  *returnVal = params.Pop<int>();
  return PrimitiveStatus::OkStatus();
}

PrimitiveStatus draw_line(int col, int row)
{
  TrustedParameterStack params;
  *params.PushAlloc<int>() = col;
  *params.PushAlloc<int>() = row;
  ASYLO_RETURN_IF_ERROR(TrustedPrimitives::UntrustedCall(kdraw_lineOcallHandler,
                                                         &params));
  col = params.Pop<int>();
  row = params.Pop<int>();
  return PrimitiveStatus::OkStatus();
}

PrimitiveStatus time (time_t* timer, time_t* returnVal)
{
  TrustedParameterStack params;
//  std::string msg = "In time \n";
//  params.Push(Extent(msg.c_str(), msg.length()));
//  ASYLO_RETURN_IF_ERROR(TrustedPrimitives::UntrustedCall(kprintOcallHandler,
//                                                         &params));
//
  if (!timer) {
     params.Push(Extent(NULL, sizeof(NULL)));
  } else {
     *params.PushAlloc<time_t>() = *timer;
  }
  ASYLO_RETURN_IF_ERROR(TrustedPrimitives::UntrustedCall(ktimeOcallHandler,
                                                         &params));

  *returnVal = params.Pop<time_t>();
//  if (!returnVal) {
//    msg = "Ups\n";
//  } else {
//    msg = ":)\n";
//  }
//  params.Push(Extent(msg.c_str(), msg.length()));
//  ASYLO_RETURN_IF_ERROR(TrustedPrimitives::UntrustedCall(kprintOcallHandler,
//			  &params));
//
  return PrimitiveStatus::OkStatus();
}

PrimitiveStatus srand (unsigned int seed)
{
  TrustedParameterStack params;
//  std::string msg = "In srand " + std::to_string(seed) + " \n";
//  params.Push(Extent(msg.c_str(), msg.length()));
//  ASYLO_RETURN_IF_ERROR(TrustedPrimitives::UntrustedCall(kprintOcallHandler,
//                                                         &params));
//

  *params.PushAlloc<int>() = seed;
  ASYLO_RETURN_IF_ERROR(TrustedPrimitives::UntrustedCall(ksrandOcallHandler,
                                                         &params));
  return PrimitiveStatus::OkStatus();
}

PrimitiveStatus rand(int* returnVal)
{
  TrustedParameterStack params;
//  std::string msg = "In rand\n";
//  params.Push(Extent(msg.c_str(), msg.length()));
//  ASYLO_RETURN_IF_ERROR(TrustedPrimitives::UntrustedCall(kprintOcallHandler,
//                                                         &params));
//
  ASYLO_RETURN_IF_ERROR(TrustedPrimitives::UntrustedCall(krandOcallHandler,
                                                         &params));
  *returnVal = params.Pop<int>();
  return PrimitiveStatus::OkStatus();
}

// Message handler that aborts the enclave.
PrimitiveStatus Abort(void *context, TrustedParameterStack *params) {
  TrustedPrimitives::BestEffortAbort("Aborting enclave");
  return PrimitiveStatus::OkStatus();
}

// Message handler that says hello
PrimitiveStatus secure_eat_gold(void *context, TrustedParameterStack *params) {

  screen_t screen = params->Pop<screen_t>();
  snake_t snake = params->Pop<snake_t>();

  int returnVal = eat_gold(&snake, &screen);

  *params->PushAlloc<int>() = returnVal;
  *params->PushAlloc<screen_t>() = screen;
  *params->PushAlloc<snake_t>() = snake;
  return PrimitiveStatus::OkStatus();
}

PrimitiveStatus secure_setup_level(void* context, TrustedParameterStack* params)
{
  int level = params->Pop<int>();
  snake_t snake = params->Pop<snake_t>();
  screen_t screen = params->Pop<screen_t>();
  // actual call
  setup_level(&screen, &snake, level);
  *params->PushAlloc<int>() = level;
  *params->PushAlloc<snake_t>() = snake;
  *params->PushAlloc<screen_t>() = screen;
  return PrimitiveStatus::OkStatus();
}

PrimitiveStatus secure_show_score(void* context, TrustedParameterStack* params)
{
  screen_t screen = params->Pop<screen_t>();
  show_score(&screen);
  *params->PushAlloc<screen_t>() = screen;
  return PrimitiveStatus::OkStatus();
}

PrimitiveStatus secure_collide_object(void* context, TrustedParameterStack* params)
{
  char object = params->Pop<char>();
  screen_t screen = params->Pop<screen_t>();
  snake_t snake = params->Pop<snake_t>();
  int returnValue = collide_object(&snake, &screen, object);
  *params->PushAlloc<int>() = returnValue;
  *params->PushAlloc<char>() = object;
  *params->PushAlloc<screen_t>() = screen;
  *params->PushAlloc<snake_t>() = snake;
  return PrimitiveStatus::OkStatus();
}

PrimitiveStatus secure_collision(void* context, TrustedParameterStack* params)
{
  screen_t screen = params->Pop<screen_t>();
  snake_t snake = params->Pop<snake_t>();
  int returnValue = collision(&snake, &screen);
  *params->PushAlloc<int>() = returnValue;
  *params->PushAlloc<screen_t>() = screen;
  *params->PushAlloc<snake_t>() = snake;
  return PrimitiveStatus::OkStatus();
}

PrimitiveStatus secure_move(void* context, TrustedParameterStack* params)
{
  char key = params->Pop<char>();
  auto keys_ext = params->Pop();
  char *keys = reinterpret_cast<char*>(keys_ext->data());
  snake_t snake = params->Pop<snake_t>();

  *params->PushAlloc<int>() = 12;

  move(&snake, keys, key);
  *params->PushAlloc<char>() = key;
  auto return_keys_ext = params->PushAlloc(strlen(keys));
  memcpy(return_keys_ext.As<char>(), keys, strlen(keys));
  *params->PushAlloc<snake_t>() = snake;
  return PrimitiveStatus::OkStatus();
}

}  // namespace

extern "C" PrimitiveStatus asylo_enclave_init() {
  ASYLO_RETURN_IF_ERROR(TrustedPrimitives::RegisterEntryHandler(
      kAbortEnclaveSelector, EntryHandler{Abort}));
  ASYLO_RETURN_IF_ERROR(TrustedPrimitives::RegisterEntryHandler(
      keat_goldEnclaveSelector, EntryHandler{secure_eat_gold}));
  ASYLO_RETURN_IF_ERROR(TrustedPrimitives::RegisterEntryHandler(
      ksetup_levelEnclaveSelector, EntryHandler{secure_setup_level}));
  ASYLO_RETURN_IF_ERROR(TrustedPrimitives::RegisterEntryHandler(
      kshow_scorelEnclaveSelector, EntryHandler{secure_show_score}));
  ASYLO_RETURN_IF_ERROR(TrustedPrimitives::RegisterEntryHandler(
      kcollide_objectEnclaveSelector, EntryHandler{secure_collide_object}));
  ASYLO_RETURN_IF_ERROR(TrustedPrimitives::RegisterEntryHandler(
      kcollisionEnclaveSelector, EntryHandler{secure_collision}));
  ASYLO_RETURN_IF_ERROR(TrustedPrimitives::RegisterEntryHandler(
      kmoveEnclaveSelector, EntryHandler{secure_move}));
  return PrimitiveStatus::OkStatus();
}

extern "C" PrimitiveStatus asylo_enclave_fini() {
  return PrimitiveStatus::OkStatus();
}

}  // namespace primitives
}  // namespace asylo

void draw_line (int col, int row)
{
  asylo::primitives::draw_line(col, row);
}

time_t insecure_time(time_t* timer)
{
  time_t returnVal;
  asylo::primitives::time(timer, &returnVal);
  return returnVal;
}

void insecure_srand (unsigned int seed)
{
  asylo::primitives::srand(seed);
}

int insecure_rand (void)
{
  int returnVal = 0;
  asylo::primitives::rand(&returnVal);
  return returnVal;
}

int insecure_puts (const char* str)
{
  int returnVal = 0;
  asylo::primitives::puts(str, &returnVal);
  return returnVal;
}

int insecure_printf(const char* fmt, ...)
{
  va_list arguments;
  va_start(arguments, fmt);
  int ret = vprintf(fmt, arguments);
  va_end(arguments);
  return ret;
}

int insecure_fprintf(FILE* file, const char* fmt, ...)
{
  va_list arguments;
  va_start(arguments, fmt);
  int ret = vfprintf(file, fmt, arguments);
  va_end(arguments);
  return ret;
}


