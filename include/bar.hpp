#ifndef BAR_HPP
#define BAR_HPP

#include <result.hpp>

#include <FL/Fl_Window.H>
#include <FL/platform.H>

enum BarPosition {
  BAR_POSITION_TOP,
  BAR_POSITION_BOTTOM,
};

class Bar {
public:
  Bar(size_t default_height, BarPosition position);
  ~Bar(void);

  Result init(int argc, char* argv[]);

private:
  Fl_Window* window = nullptr;
  BarPosition position = BAR_POSITION_TOP;
  size_t default_height = 30;
};

#endif
