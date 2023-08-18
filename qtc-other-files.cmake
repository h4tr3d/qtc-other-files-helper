#
# IDE compatibility
#
# Can be added optionally in the QtC as a 'Additional CMake options:' on the
# Project configuration page like:
#   `-DCMAKE_PROJECT_INCLUDE=%{ActiveProject:NativePath}/qtc-other-files.cmake`
# Note, CMAKE_PROJECT_INCLUDE_BEFORE internally used by the QtC itself.
#
# Another way, configure is Kit-aware. See README.md for details.
#
# Maybe used with other IDEs in the same way, but untessted.
#
# TBD: file addition work ugly yet: target_sources() will be added into top CMakeLists.txt
#
if (NOT TARGET other_files)
add_custom_target(other_files echo)
target_sources(other_files
  PRIVATE
    qtc-other-files.cmake
)
endif()
