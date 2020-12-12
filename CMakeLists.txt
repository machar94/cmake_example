cmake_minimum_required(VERSION 3.10.2)

set(APP "myapp")

message( STATUS ${APP})

project(cmake_example)

add_executable(${APP} main.cpp)

# Download all submodules
find_package(Git QUIET)
if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
# Update submodules as needed
    option(GIT_SUBMODULE "Check submodules during build" ON)
    if(GIT_SUBMODULE)
        message(STATUS "Submodule update")
        execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
                        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                        RESULT_VARIABLE GIT_SUBMOD_RESULT)
        if(NOT GIT_SUBMOD_RESULT EQUAL "0")
            message(FATAL_ERROR "git submodule update --init failed with ${GIT_SUBMOD_RESULT}, please checkout submodules")
        endif()
    endif()
endif()

# Check for all submodules
if(NOT EXISTS "${PROJECT_SOURCE_DIR}/external/glfw/CMakeLists.txt")
    message(FATAL_ERROR "The glfw submodules was not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
endif()

# For finding headers when making a target
target_include_directories(
    ${APP}
    PRIVATE
    adder
    extern/glfw/include
)

# For finding libraries in the build folder
link_directories(
    ${APP}
    PRIVATE
    adder
    extern/glfw/src
)

# Calls the directories CMakeLists.txt
add_subdirectory(adder)
add_subdirectory(extern/glfw)

target_link_libraries(${APP} adder glfw)
