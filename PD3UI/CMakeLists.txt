cmake_minimum_required(VERSION 3.20)

project(PD3UI VERSION 1.0)
# set(CMAKE_PREFIX_PATH "D:\\Work\\QT\\6.6.3\\msvc2019_64")


find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core)

add_subdirectory(FluentUI)
add_subdirectory(src)
