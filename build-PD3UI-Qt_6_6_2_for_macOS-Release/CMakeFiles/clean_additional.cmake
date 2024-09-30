# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Release")
  file(REMOVE_RECURSE
  "FluentUI/CMakeFiles/fluentuiplugin_autogen.dir/AutogenUsed.txt"
  "FluentUI/CMakeFiles/fluentuiplugin_autogen.dir/ParseCache.txt"
  "FluentUI/fluentuiplugin_autogen"
  "src/CMakeFiles/PD3UI_autogen.dir/AutogenUsed.txt"
  "src/CMakeFiles/PD3UI_autogen.dir/ParseCache.txt"
  "src/PD3UI_autogen"
  )
endif()
