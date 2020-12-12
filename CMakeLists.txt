cmake_minimum_required(VERSION 3.10.2)

set(APP "myapp")

message( STATUS ${APP})

project(cmake_example)

add_executable(${APP} main.cpp)

# For finding headers when making a target
target_include_directories(
    ${APP}
    PRIVATE
    adder
)

# For finding libraries in the build folder
link_directories(
    ${APP}
    PRIVATE
    adder
)
`
add_subdirectory(adder)

target_link_libraries(${APP} adder)
