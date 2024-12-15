#include <FL/Fl.H>
#include <FL/Fl_Window.H>
#include <FL/platform.H>

#include <iostream>

int main(int argc, char* argv[]) {
  Fl_Window window = Fl_Window(10, 10);

  window.show(argc, argv);

  wld_window* window_id = nullptr;
  if(!(window_id = fl_wl_xid(&window))) {
    std::cerr << "Failed to get window id\n";
    return -1;
  }
  wl_surface* surface = nullptr;
  if(!(surface = fl_wl_surface(window_id))) {
    std::cerr << "Failed to get wayland surface\n";
    return -2;
  }

  return Fl::run();
}
