#! /bin/sh

# Many cmake options are the option add a -D (sometimes
# also seen with a space but prefer without) i.e. in this
# case the option is GLFW_BUILD_DOCS which is an option
# that is specified with the option(...) command in the 
# CMakeLists.txt underneath extern/glfw
mkdir -p build && cd build && cmake -DGLFW_BUILD_DOCS=OFF ..

