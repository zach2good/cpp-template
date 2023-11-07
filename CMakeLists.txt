cmake_minimum_required(VERSION 3.22) # TODO: What version do I actually need/want?

# TODO: Unify ccache, clang-tidy, and cpp-check to be in the same place and style
find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CCACHE_PROGRAM}")
endif()

set(PROJECT_NAME cpptemplate)
project(${PROJECT_NAME} CXX)

set(CMAKE_CXX_STANDARD 20) # TODO: Can I have 23 yet?
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_LINKER_LANGUAGE CXX)
set(USE_FOLDERS ON)

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(cmake/CPM.cmake)
include(cmake/CompilerWarnings.cmake)
include(cmake/StaticAnalyzers.cmake)

message(STATUS "CMAKE_VERSION: ${CMAKE_VERSION}")
message(STATUS "CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")
message(STATUS "CMAKE_C_COMPILER: ${CMAKE_C_COMPILER}")
message(STATUS "CMAKE_CXX_COMPILER: ${CMAKE_CXX_COMPILER}")
message(STATUS "CMAKE_CXX_COMPILER_ID: ${CMAKE_CXX_COMPILER_ID}")
message(STATUS "CMAKE_CXX_COMPILER_VERSION: ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "CMAKE_CXX_STANDARD: ${CMAKE_CXX_STANDARD}")
message(STATUS "CMAKE_CXX_FLAGS: ${CMAKE_CXX_FLAGS}")
message(STATUS "CMAKE_GENERATOR: ${CMAKE_GENERATOR}")
message(STATUS "CMAKE_GENERATOR_PLATFORM: ${CMAKE_GENERATOR_PLATFORM}")
message(STATUS "CMAKE_SOURCE_DIR: ${CMAKE_SOURCE_DIR}")
message(STATUS "CCACHE_PROGRAM: ${CCACHE_PROGRAM}")

message(STATUS "CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")
string(TOUPPER "${CMAKE_BUILD_TYPE}" CMAKE_BUILD_TYPE_UPPER)
if ("${CMAKE_BUILD_TYPE_UPPER}" STREQUAL "")
    message(WARNING "${CMAKE_BUILD_TYPE} not specified, using DEBUG.")
    set(CMAKE_BUILD_TYPE "Debug")
    set(CMAKE_BUILD_TYPE_UPPER "DEBUG")
endif()

message(STATUS "CMAKE_CXX_FLAGS: ${CMAKE_CXX_FLAGS}")
if ("${CMAKE_BUILD_TYPE_UPPER}" STREQUAL "DEBUG")
    message(STATUS "CMAKE_CXX_FLAGS_DEBUG: ${CMAKE_CXX_FLAGS_DEBUG}")
elseif ("${CMAKE_BUILD_TYPE_UPPER}" STREQUAL "MINSIZEREL")
    message(STATUS "CMAKE_CXX_FLAGS_MINSIZEREL: ${CMAKE_CXX_FLAGS_MINSIZEREL}")
elseif ("${CMAKE_BUILD_TYPE_UPPER}" STREQUAL "RELEASE")
    message(STATUS "CMAKE_CXX_FLAGS_RELEASE: ${CMAKE_CXX_FLAGS_RELEASE}")
elseif ("${CMAKE_BUILD_TYPE_UPPER}" STREQUAL "RELWITHDEBINFO")
    message(STATUS "CMAKE_CXX_FLAGS_RELWITHDEBINFO: ${CMAKE_CXX_FLAGS_RELWITHDEBINFO}")
else()
    message(FATAL_ERROR "Did not recognise CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")
endif()

set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_subdirectory(ext)
add_subdirectory(src)

if(NOT DISABLE_TESTS)
    add_subdirectory(test)
endif()

# TODO: Clean all of this up and move into a module
message(STATUS "=== Available CMake targets ===")
function(print_all_targets DIR)
    get_property(TGTS DIRECTORY "${DIR}" PROPERTY BUILDSYSTEM_TARGETS)
    foreach(TGT IN LISTS TGTS)
        message(STATUS "Target: ${TGT}")
    endforeach()

    get_property(SUBDIRS DIRECTORY "${DIR}" PROPERTY SUBDIRECTORIES)
    foreach(SUBDIR IN LISTS SUBDIRS)
        print_all_targets("${SUBDIR}")
    endforeach()
endfunction()

print_all_targets(src)
print_all_targets(test)
