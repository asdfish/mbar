CXX ?= c++
CXXFLAGS ?= -O2 -march=native -pipe
LDFLAGS ?=

# uncomment/comment to enable/disable
# PROCESS_HEADER_FILES := yes
PROCESSED_HEADER_FILES := $(if ${PROCESS_HEADER_FILES},$\
														$(subst .hpp,$\
															$(if $(findstring clang,${CXX}),$\
																.hpp.pch,$\
																.hpp.gch),$\
															$(shell find include -name '*.hpp' -type f)))

OBJECT_FILES := $(patsubst src/%.cpp,$\
									build/%.o,$\
									$(shell find src -name '*.cpp' -type f))

MBAR_REQUIREMENTS := ${PROCESSED_HEADER_FILES} ${OBJECT_FILES}

define COMPILE
${CXX} -c $(1) ${CXXFLAGS} $(shell ./deps/fltk/fltk-config --cxxflags) -o $(2)

endef
define REMOVE
$(if $(wildcard $(1)),$\
	rm $(1))

endef
define REMOVE_LIST
$(foreach ITEM,$\
	$(1),$\
	$(call REMOVE,${ITEM}))
endef

all: mbar

mbar: deps/fltk/lib/libfltk.a ${MBAR_REQUIREMENTS}
	${CXX} ${OBJECT_FILES} ${CXXFLAGS} ${LDFLAGS} $(shell ./deps/fltk/fltk-config --ldflags) -o $@

build/%.o: src/%.cpp
	$(call COMPILE,$<,$@)
%.gch: %
	$(call COMPILE,$<,$@)
%.pch: %
	$(call COMPILE,$<,$@)

clean:
	$(call REMOVE_LIST,${MBAR_REQUIREMENTS})
	$(call REMOVE,mbar)

distclean: clean
	$(MAKE) -C deps/fltk distclean

deps/fltk/lib/libfltk.a:
	$(MAKE) -C deps/fltk

.PHONY: all clean install uninstall