PROTOCOLS := $(shell ls | grep '.xml')

HEADER_FILES := $(patsubst %.xml,$\
									include/%.h,$\
									${PROTOCOLS})
SOURCE_FILES := $(patsubst %.xml,$\
									src/%.c,$\
									${PROTOCOLS})
OBJECT_FILES := $(patsubst %.xml,$\
									build/%.o,$\
									${PROTOCOLS})

define COMPILE
${CC} -c $(1) ${CFLAGS} -o $(2)
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

all: libwayland_protocols.a

libwayland_protocols.a: ${OBJECT_FILES} ${HEADER_FILES}
	ar rcs $@ ${OBJECT_FILES}

build/%.o: src/%.c
	$(call COMPILE,$<,$@)

src/%.c: %.xml
	wayland-scanner private-code $< $@

include/%.h: %.xml
	wayland-scanner client-header $< $@

clean:
	$(call REMOVE,libwayland_protocols.a)
	$(call REMOVE_LIST,${OBJECT_FILES})
	$(call REMOVE_LIST,${SOURCE_FILES})
	$(call REMOVE_LIST,${HEADER_FILES})
