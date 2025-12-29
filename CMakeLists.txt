cmake_minimum_required(VERSION 3.16)

project(dashhh VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Core)
find_package(Qt6 REQUIRED COMPONENTS SerialPort)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appdashhh
    main.cpp
)

qt_add_qml_module(appdashhh
    URI dashhh
    VERSION 1.0
    QML_FILES
        Main.qml
        SOURCES serial.h serial.cpp
        SOURCES parse.h parse.cpp

        RESOURCES
        assets/images/logo.jpg
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appdashhh PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appdashhh
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appdashhh
    PRIVATE Qt6::Quick
)
target_link_libraries(appdashhh PRIVATE Qt6::Core)
target_link_libraries(appdashhh PRIVATE Qt6::SerialPort)


include(GNUInstallDirs)
install(TARGETS appdashhh
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
