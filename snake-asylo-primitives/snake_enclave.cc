#include "interface_selectors.h"

#include "asylo/platform/primitives/extent.h"
#include "asylo/platform/primitives/primitive_status.h"
#include "asylo/platform/primitives/trusted_primitives.h"
#include "asylo/util/status_macros.h"

#include "snake.h"
#include "conio.h"

extern int eat_gold(snake_t* snake, screen_t* screen);

namespace asylo {
namespace primitives {

namespace {

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

}  // namespace

extern "C" PrimitiveStatus asylo_enclave_init() {
  ASYLO_RETURN_IF_ERROR(TrustedPrimitives::RegisterEntryHandler(
      kAbortEnclaveSelector, EntryHandler{Abort}));
  ASYLO_RETURN_IF_ERROR(TrustedPrimitives::RegisterEntryHandler(
      keat_goldEnclaveSelector, EntryHandler{secure_eat_gold}));
  return PrimitiveStatus::OkStatus();
}

extern "C" PrimitiveStatus asylo_enclave_fini() {
  return PrimitiveStatus::OkStatus();
}

}  // namespace primitives
}  // namespace asylo
