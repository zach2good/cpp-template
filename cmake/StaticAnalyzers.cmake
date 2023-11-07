
find_program(CLANGTIDY clang-tidy)
if(CLANGTIDY)
    set(CMAKE_CXX_CLANG_TIDY ${CLANGTIDY} -extra-arg=-Wno-unknown-warning-option)
endif()

find_program(CPPCHECK cppcheck)
if(CPPCHECK)
    set(CMAKE_CXX_CPPCHECK ${CPPCHECK} --suppress=missingInclude --enable=all
                            --inline-suppr --inconclusive)
endif()

message(STATUS "CLANGTIDY: ${CLANGTIDY}")
message(STATUS "CPPCHECK: ${CPPCHECK}")
