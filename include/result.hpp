#ifndef RESULT_HPP
#define RESULT_HPP

enum Result {
  RESULT_OK,

  RESULT_ERR_INVALID_CONFIG,
  RESULT_ERR_WAYLAND,
};

extern void result_print(Result result);

#endif
