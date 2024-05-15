# Qt Creator CMake: display additional files in the source tree

Just an WA to use with latest Qt Creator version with ability to add files.


## Intro

It just a hack. Main idea: create fake target with `echo` command (sound like exists on the any platform) and collect any needed files here.

To avoid CMakeLists.txt modification, use `CMAKE_PROJECT_INCLUDE` to point helper file with the target definition.


## Per project configuration

Just drop **qtc-other-files.cmake** into project dir and point "Additional CMake options:":

```sh
-DCMAKE_PROJECT_INCLUDE=%{ActiveProject:NativePath}/qtc-other-files.cmake
```

Note, `CMAKE_PROJECT_INCLUDE_BEFORE` are used by the Qt Creator internally for the Package managers (like vcpkg and conan) configuration.


## Per Kit configuration

Go to Edit → Preferences → Kits and select appropriate Kit. Next, find the "CMake Configuration:" field and press Change... After that add next line and press Ok:

```sh
-DCMAKE_PROJECT_INCLUDE=/full/path/to/qtc-other-files-helper.cmake
```

Be careful: you must point `qtc-other-files-helper.cmake` here.

Finally, drop `qtc-other-files.cmake` (not a helper!) to the project directory and open it at the QtC. If project was opened before, try to reconfigure it with initial parameters.

## Per-project configuration without any IDE impact

Based on the https://www.qt.io/blog/qt-creator-cmake-package-manager-auto-setup.

Just create file **QtCreatorPackageManager.cmake** with next content:
```
include(qtc-other-files.cmake)
```

and drop `qtc-other-files.cmake` to the project directory. After that just re-run CMake in the QtC.


## Create new CMake projects with qtc-other-files.cmake

Good addition to the previous field. Drop `qtc-other-files.cmake` into `QTC_INSTALL_DIR/share/qtcreator/templates/wizards/projects/plaincpp` and/or `QTC_INSTALL_DIR/share/qtcreator/templates/wizards/projects/plaincpp` and modify `wizard.json` (in both locations): add into "generators" section something like:
```json
                {
                    "source": "qtc-other-files.cmake",
                    "openInEditor": true,
                    "condition": "%{JS: '%{BuildSystem}' === 'cmake'}"
                },
```


## Known issues

1. When files added to the target `other_files` from the GUI, Qt Creator crates new `target_sources()` at the top level CMakeLists.txt file instead of `qtc-other-files.cmake`. I has no ideas how to WA it. Just manually cut new entry and put them into proper location.
2. Possible conflicts with `CMAKE_PROJECT_INCLUDE`. Should be solved in the custom way.
3. `qtc-other-files.cmake` must contain reference to itself to display at the tree
4. If some file from the `other_files` target was gone, cmake configuration will fails. Be careful.


