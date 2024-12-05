# download CPM.cmake
file(
  DOWNLOAD
  https://github.com/cpm-cmake/CPM.cmake/releases/download/v0.40.2/CPM.cmake
  ${CMAKE_CURRENT_BINARY_DIR}/CPM.cmake
)
include(${CMAKE_CURRENT_BINARY_DIR}/CPM.cmake)
