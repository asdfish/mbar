#include <bar.hpp>

#include <FL/Fl.H>

Bar::Bar(size_t default_height, BarPosition position) {
  this->default_height = default_height;
  this->position = position;
}
Bar::~Bar(void) {
  if(window)
    delete window;
}

Result Bar::init(int argc, char* argv[]) {
  window = new Fl_Window(Fl::w(), default_height);
  window->show(argc, argv);

  wld_window* window_id = nullptr;
  if(!(window_id = fl_wl_xid(window)))
    return RESULT_ERR_WAYLAND;

  wl_surface* surface = nullptr;
  if(!(surface = fl_wl_surface(window_id)))
    return RESULT_ERR_WAYLAND;

  return RESULT_OK;
}
