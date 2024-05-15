#
# IDE compatibility
#
# Can be added optionally in the QtC as a 'Additional CMake options:' on the
# Project configuration page like:
#   `-DCMAKE_PROJECT_INCLUDE=%{ActiveProject:NativePath}/qtc-other-files.cmake`
# Note, CMAKE_PROJECT_INCLUDE_BEFORE internally used by the QtC itself.
#
# Second way, configure is Kit-aware. See README.md for details.
#
# Third way are based on https://www.qt.io/blog/qt-creator-cmake-package-manager-auto-setup.
# Just create at top-level project QtCreatorPackageManager.cmake and add:
# ```
# include(qtc-other-files.cmake)
# ```
# and re-run CMake
#
# Maybe used with other IDEs in the same way, but untessted.
#
# TBD: file addition work ugly yet: target_sources() will be added into top CMakeLists.txt
#
if (NOT TARGET other_files)
#add_custom_target(other_files echo) # work with QtC for a read only, has no way to add files via interface
add_library(other_files STATIC EXCLUDE_FROM_ALL qtc-other-files.cmake)
set_target_properties(other_files PROPERTIES LINKER_LANGUAGE CXX) # just a hack
target_sources(other_files
  PRIVATE
    qtc-other-files.cmake
)
endif()
