
# *******************************************************************************************
#/ <summary>
#/ CMakeLists.txt
#/ QMLApp
#/ created by Mehrdad Soleimanimajd on 18.09.2019
#/ </summary>
#/ <created>ʆϒʅ, 18.09.2019</created>
#/ <changed>ʆϒʅ, 27.06.2023</changed>
# *******************************************************************************************

cmake_minimum_required(VERSION 3.5)

set(TARGET_NAME QMLApp)

set(RELEASE_FLAG OFF)

set(PROJECT_NAME ${TARGET_NAME})

project(${PROJECT_NAME}
    VERSION 0.1.0.0
    DESCRIPTION "QML notes and examples"
    HOMEPAGE_URL "https://github.com/s-mehrdad/QMLApp"
    LANGUAGES CXX
    )

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(Qt6 COMPONENTS
    Core
    Gui
    Qml
    Quick
    QuickControls2
    REQUIRED)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

#if(MSVC)
#  list(APPEND RESOURCES
#    ${TARGET_NAME}.rc
#    resource.h
#    )
#endif(MSVC)

list(APPEND HEADER_FILES
    settings.h
    )

list(APPEND SOURCE_FILES
    main.cpp
    settings.cpp
    )

list(APPEND QRC_FILES
    qml.qrc
    )

if(WIN32)
    list(APPEND SOURCE_FILES ${HEADER_FILES})
    list(APPEND SOURCE_FILES ${QRC_FILES})
endif(WIN32)

if(ANDROID)
    add_library(${TARGET_NAME} SHARED
        ${SOURCE_FILES}
        ${HEADER_FILES}
        ${QRC_FILES}
        ${RESOURCES}
        )

elseif(WIN32)
    add_executable(${TARGET_NAME} WIN32
        ${SOURCE_FILES}
        ${RESOURCES}
        )

else(WIN32)
    add_executable(${TARGET_NAME}
        ${SOURCE_FILES}
        ${HEADER_FILES}
        ${QRC_FILES}
        ${RESOURCES}
        )
endif(ANDROID)

#target_compile_definitions(${TARGET_NAME}
#PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(${TARGET_NAME}
    PUBLIC Qt6::Core
    PUBLIC Qt6::Gui
    PUBLIC Qt6::Qml
    PUBLIC Qt6::Quick
    PUBLIC Qt6::QuickControls2
    )

# QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check http://doc.qt.io/qt-5/deployment-android.html for more information.
# These variables must use CACHE, otherwise QtCreator won't see them.

#if(ANDROID)
#  set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android" CACHE INTERNAL "")
#  if (ANDROID_ABI STREQUAL "armeabi-v7a")
#    set(ANDROID_EXTRA_LIBS ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so CACHE INTERNAL "")
#  endif()
#endif()

add_custom_command(TARGET ${TARGET_NAME} PRE_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
    ${CMAKE_CURRENT_SOURCE_DIR}/settings.xml
    ${CMAKE_CURRENT_BINARY_DIR}
    VERBATIM)
message(${CMAKE_CURRENT_SOURCE_DIR}/settings.xml)

install(FILES settings.xml
    DESTINATION ${CMAKE_CURRENT_BINARY_DIR}
    )

if(RELEASE_FLAG)
    if(MINGW)
        add_custom_command(TARGET ${TARGET_NAME} PRE_BUILD
            COMMAND cmake -E copy_if_different
            ${QT_BINARIES}/libgcc_s_seh-1.dll
            ${QT_BINARIES}/libstdc++-6.dll
            ${QT_BINARIES}/libwinpthread-1.dll
            ${QT_BINARIES}/Qt6Core.dll
            ${QT_BINARIES}/Qt6Cored.dll
            ${QT_BINARIES}/Qt6Gui.dll
            ${QT_BINARIES}/Qt6Guid.dll
            ${QT_BINARIES}/Qt6Network.dll
            ${QT_BINARIES}/Qt6Networkd.dll
            ${QT_BINARIES}/Qt6Qml.dll
            ${QT_BINARIES}/Qt6Qmld.dll
            ${QT_BINARIES}/Qt6Quick.dll
            ${QT_BINARIES}/Qt6Quickd.dll
            ${QT_BINARIES}/Qt6QuickControls2.dll
            ${QT_BINARIES}/Qt6QuickControls2d.dll
            ${QT_BINARIES}/Qt6QuickTemplates2.dll
            ${QT_BINARIES}/Qt6QuickTemplates2d.dll
            ${QT_BINARIES}/Qt6QuickWidgets.dll
            ${QT_BINARIES}/Qt6QuickWidgetsd.dll
            ${QT_BINARIES}/Qt6Widgets.dll
            ${QT_BINARIES}/Qt6Widgetsd.dll
            $<TARGET_FILE_DIR:${TARGET_NAME}>
            )
    endif(MINGW)
endif(RELEASE_FLAG)

#if(GNUCXX)
#
#endif(GNUCXX)
