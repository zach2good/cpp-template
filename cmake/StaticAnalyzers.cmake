find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
    set(CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE_PROGRAM})
    set(CMAKE_C_COMPILER_LAUNCHER ${CCACHE_PROGRAM})
endif()

find_program(CLANGFORMAT clang-format)
if(CLANGFORMAT)
    set(CMAKE_CXX_CLANG_FORMAT ${CLANGFORMAT} -i)
endif()

find_program(CLANGTIDY clang-tidy)
if(CLANGTIDY)
    set(CMAKE_CXX_CLANG_TIDY ${CLANGTIDY} -extra-arg=-Wno-unknown-warning-option)
endif()

find_program(CPPCHECK cppcheck)
if(CPPCHECK)
    set(CMAKE_CXX_CPPCHECK ${CPPCHECK} --suppress=missingInclude --enable=all
                            --inline-suppr --inconclusive)
endif()

message(STATUS "CCACHE_PROGRAM: ${CCACHE_PROGRAM}")
message(STATUS "CLANGFORMAT: ${CLANGFORMAT}")
message(STATUS "CLANGTIDY: ${CLANGTIDY}")
message(STATUS "CPPCHECK: ${CPPCHECK}")
