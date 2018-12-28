#include <string>

#include "absl/strings/escaping.h"
#include "absl/strings/str_cat.h"
#include "asylo/crypto/aes_gcm_siv.h"
#include "asylo/trusted_application.h"
#include "asylo/util/cleansing_types.h"
#include "asylo/util/status_macros.h"
#include "asylo/util/statusor.h"
#include "snake-asylo/snake.pb.h"
#include "snake-asylo/snake.h"
#include "snake-asylo/conio.h"
#include "snake-asylo/utils.h"

namespace asylo {

class EatGoldEnclave : public TrustedApplication {
private:
  snake_t m_snake;
  screen_t m_screen;

public:
  EatGoldEnclave() = default;

  Status Run(const EnclaveInput &input, EnclaveOutput *output) {
    ParseSnakeFromInput(input);
    ParseScreenFromInput(input);

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

    SetEnclaveOutputSnake(output);
    SetEnclaveOutputScreen(output);
    SetEnclaveOutputReturn(output);

    return Status::OkStatus();
  }

  void SetEnclaveOutputReturn(EnclaveOutput* enclave_output) {
    guide::asylo::ReturnValue *output =
	    enclave_output->MutableExtension(guide::asylo::ret);
    output->set_eat_gold(m_screen.gold);
  }

  void SetEnclaveOutputScreen(EnclaveOutput* enclave_output) {
    guide::asylo::Screen *output =
	    enclave_output->MutableExtension(guide::asylo::screen_out);
    createAsyloScreen(&m_screen, output);
  }

  void SetEnclaveOutputSnake(EnclaveOutput* enclave_output) {
    guide::asylo::Snake *output =
        enclave_output->MutableExtension(guide::asylo::snake_out);
    createAsyloSnake(&m_snake, output);
  }


  void ParseScreenFromInput(const EnclaveInput& input) {
    auto* screen_in = &input.GetExtension(guide::asylo::screen_in);
    createScreen(&m_screen, screen_in);
  }

  void ParseSnakeFromInput(const EnclaveInput& input) {
    auto* snake_input = &input.GetExtension(guide::asylo::snake_in);
    createSnake(&m_snake, snake_input);
  }
};

TrustedApplication *BuildTrustedApplication() { return new EatGoldEnclave; }

}  // namespace asylo
