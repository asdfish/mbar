# mbar
modifiable bar

# Building
~~~sh
git clone https://github.com/asdfish/mbar --depth 1 --recursive
cd mbar
sudo make install
~~~

## Build errors
~~~sh
make -j
~~~
will break the build. If you want to speed up the compilation of fltk, run
~~~sh
make -j
make
~~~
