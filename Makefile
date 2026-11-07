
CXX     := clang++
AR      := ar
WIN_CXX := x86_64-w64-mingw32-g++
WIN_AR  := x86_64-w64-mingw32-ar

JOLT_ROOT := ../JoltPhysics

JOLTC_SRC := $(firstword $(wildcard JoltC/JoltC.cpp JoltCImpl/JoltC.cpp))

CXXFLAGS := -std=c++17 -g -O0 -msse4.2 -I. -I$(JOLT_ROOT) \
            -DJPH_ENABLE_ASSERTS \
            -DJPH_OBJECT_STREAM \
            -DJPH_DEBUG_RENDERER \
            -DJPH_PROFILE_ENABLED

all: libJoltC.a libJoltC_win.a

libJoltC.a: $(JOLTC_SRC)
	$(CXX) $(CXXFLAGS) -c $< -o JoltC.linux.o
	$(AR) rcs $@ JoltC.linux.o

libJoltC_win.a: $(JOLTC_SRC)
	$(WIN_CXX) $(CXXFLAGS) -c $< -o JoltC.win.o
	$(WIN_AR) rcs $@ JoltC.win.o

clean:
	rm -f *.o *.a
