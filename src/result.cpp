#include <result.hpp>

#include <iostream>

static const char* result_strings[] = {
  [RESULT_OK] = nullptr,

  [RESULT_ERR_INVALID_CONFIG] = "Invalid config",
  [RESULT_ERR_WAYLAND] = "Wayland error",
};

void result_print(Result result) {
  std::cerr << result_strings[result] << '\n';
}
