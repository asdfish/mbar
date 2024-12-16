CXX ?= c++

BUILDCXXFLAGS := -std=c++17 $\
								 -Iinclude $\
								 -Wall -Wextra -Wpedantic

# uncomment/comment to enable/disable
PROCESS_HEADER_FILES := yes
PROCESSED_HEADER_FILES := $(if ${PROCESS_HEADER_FILES},$\
														$(subst .hpp,$\
															$(if $(findstring clang,${CXX}),$\
																.hpp.pch,$\
																.hpp.gch),$\
															$(shell find include -name '*.hpp' -type f)))

OBJECT_FILES := $(patsubst src/%.cpp,$\
									build/%.o,$\
									$(shell find src -name '*.cpp' -type f))

MBAR_REQUIREMENTS := protocols/libwayland_protocols.a ${PROCESSED_HEADER_FILES} ${OBJECT_FILES}

define COMPILE
${CXX} -c $(1) ${BUILDCXXFLAGS} $(shell ./deps/fltk/fltk-config --cxxflags) -o $(2)

endef
define REMOVE
$(if $(wildcard $(1)),$\
	rm $(1))

endef
define REMOVE_LIBRARY
$(if $(wildcard $(1)),$\
	$(MAKE) -C $(dir $(1)) clean)

endef
define REMOVE_LIST
$(foreach ITEM,$\
	$(1),$\
	$(if $(findstring .a,${ITEM}),$\
		$(call REMOVE_LIBRARY,${ITEM}),
		$(call REMOVE,${ITEM})))
endef

all: mbar

mbar: deps/fltk/lib/libfltk.a ${MBAR_REQUIREMENTS}
	${CXX} ${OBJECT_FILES} ${BUILDCXXFLAGS} $(shell ./deps/fltk/fltk-config --ldflags) -o $@

build/%.o: src/%.cpp
	$(call COMPILE,$<,$@)
%.gch: %
	$(call COMPILE,$<,$@)
%.pch: %
	$(call COMPILE,$<,$@)

%.a:
	$(MAKE) -C $(dir $@)

clean:
	$(call REMOVE_LIST,${MBAR_REQUIREMENTS})
	$(call REMOVE,mbar)

distclean: clean
	$(MAKE) -C deps/fltk distclean

deps/fltk/lib/libfltk.a:
	$(MAKE) -C deps/fltk

.PHONY: all clean install uninstall
