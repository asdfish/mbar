#ifndef BAR_HPP
#define BAR_HPP

namespace bar {

enum Position {
  POSITION_TOP,
  POSITION_BOTTOM,
};

class Bar {
public:
  Position position = POSITION_TOP;

  Bar();
  Bar(Position position);
};

};

#endif
