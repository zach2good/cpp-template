message(STATUS "=== Configuring Tests ===")

# TODO: Use CTest?

add_executable(test tests.cpp)
target_include_directories(test PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(test Catch2::Catch2WithMain)

# add_test(NAME basic_tests COMMAND "test [basic_tests]")
