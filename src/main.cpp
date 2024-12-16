#include <config.hpp>
#include <result.hpp>

#include <FL/Fl.H>
#include <FL/Fl_Window.H>
#include <FL/platform.H>

#define CHECK_RESULT(FUNCTION, RESULT_HOLDER, CLEANUP) \
  if((RESULT_HOLDER = FUNCTION) != RESULT_OK) {\
    result_print(RESULT_HOLDER); \
    goto CLEANUP; \
  }

int main(int argc, char* argv[]) {
  Result result = RESULT_OK;

  Bar bar = create_bar();
  CHECK_RESULT(bar.init(argc, argv), result, exit);

  return Fl::run();

exit:
  return result;
}
