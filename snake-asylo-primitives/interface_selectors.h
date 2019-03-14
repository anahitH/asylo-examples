#pragma once

#include <cstdint>

#include "asylo/platform/primitives/primitives.h"

namespace asylo {
namespace primitives {

// Entry call selectors: must be distinct from each other
static constexpr uint64_t kAbortEnclaveSelector = kSelectorUser + 1;
static constexpr uint64_t keat_goldEnclaveSelector = kSelectorUser + 2;

static constexpr uint64_t kprintOcallHandler = kSelectorUser + 1;

} // namespace primitives
} // namespace asylo


