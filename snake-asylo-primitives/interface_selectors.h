#pragma once

#include <cstdint>

#include "asylo/platform/primitives/primitives.h"

namespace asylo {
namespace primitives {

// Entry call selectors: must be distinct from each other
static constexpr uint64_t kAbortEnclaveSelector = kSelectorUser + 1;
static constexpr uint64_t keat_goldEnclaveSelector = kSelectorUser + 2;
static constexpr uint64_t ksetup_levelEnclaveSelector = kSelectorUser + 3;
static constexpr uint64_t kshow_scorelEnclaveSelector = kSelectorUser + 4;
static constexpr uint64_t kcollide_objectEnclaveSelector = kSelectorUser + 5;
static constexpr uint64_t kcollisionEnclaveSelector = kSelectorUser + 6;
static constexpr uint64_t kmoveEnclaveSelector = kSelectorUser + 7;

static constexpr uint64_t kprintOcallHandler = kSelectorUser + 1;
static constexpr uint64_t kdraw_lineOcallHandler = kSelectorUser + 2;
static constexpr uint64_t ktimeOcallHandler = kSelectorUser + 3;
static constexpr uint64_t ksrandOcallHandler = kSelectorUser + 4;
static constexpr uint64_t krandOcallHandler = kSelectorUser + 5;
static constexpr uint64_t kputsOcallHandler = kSelectorUser + 6;

} // namespace primitives
} // namespace asylo


