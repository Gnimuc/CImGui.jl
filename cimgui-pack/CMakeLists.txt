cmake_minimum_required(VERSION 3.8.0)

project(cimguipack)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(target cimgui)

add_library(${target} SHARED)

# cimgui and the backends
target_sources(${target} PRIVATE ./cimgui/imgui/imgui.cpp)
target_sources(${target} PRIVATE ./cimgui/imgui/imgui_demo.cpp)
target_sources(${target} PRIVATE ./cimgui/imgui/imgui_draw.cpp)
target_sources(${target} PRIVATE ./cimgui/imgui/imgui_tables.cpp)
target_sources(${target} PRIVATE ./cimgui/imgui/imgui_widgets.cpp)
target_sources(${target} PRIVATE ./cimgui/imgui/backends/imgui_impl_glfw.cpp)
target_sources(${target} PRIVATE ./cimgui/imgui/backends/imgui_impl_opengl3.cpp)
target_sources(${target} PRIVATE ./cimgui/cimgui.cpp)

# imgui_test_engine
set(TE_DIR "test_engine/imgui_test_engine/imgui_test_engine")
set(WRAPPER_DIR "test_engine/src")
target_sources(${target} PRIVATE
  # Wrapper sources
  ${WRAPPER_DIR}/JlGlobals.cxx
  ${WRAPPER_DIR}/JlImBuildInfo.cxx
  ${WRAPPER_DIR}/JlImGuiCaptureArgs.cxx
  ${WRAPPER_DIR}/JlImGuiCaptureContext.cxx
  ${WRAPPER_DIR}/JlImGuiCaptureToolUI.cxx
  ${WRAPPER_DIR}/JlImGuiContext.cxx
  ${WRAPPER_DIR}/JlImGuiCsvParser.cxx
  ${WRAPPER_DIR}/JlImGuiPerfTool.cxx
  ${WRAPPER_DIR}/JlImGuiPerfToolBatch.cxx
  ${WRAPPER_DIR}/JlImGuiPerfToolEntry.cxx
  ${WRAPPER_DIR}/JlImGuiTest.cxx
  ${WRAPPER_DIR}/JlImGuiTestActionFilter.cxx
  ${WRAPPER_DIR}/JlImGuiTestContext.cxx
  ${WRAPPER_DIR}/JlImGuiTestCoroutineInterface.cxx
  ${WRAPPER_DIR}/JlImGuiTestEngine.cxx
  ${WRAPPER_DIR}/JlImGuiTestEngineIO.cxx
  ${WRAPPER_DIR}/JlImGuiTestFindByLabelTask.cxx
  ${WRAPPER_DIR}/JlImGuiTestGatherTask.cxx
  ${WRAPPER_DIR}/JlImGuiTestGenericItemStatus.cxx
  ${WRAPPER_DIR}/JlImGuiTestGenericVars.cxx
  ${WRAPPER_DIR}/JlImGuiTestInfoTask.cxx
  ${WRAPPER_DIR}/JlImGuiTestInput.cxx
  ${WRAPPER_DIR}/JlImGuiTestInputs.cxx
  ${WRAPPER_DIR}/JlImGuiTestItemInfo.cxx
  ${WRAPPER_DIR}/JlImGuiTestItemList.cxx
  ${WRAPPER_DIR}/JlImGuiTestLog.cxx
  ${WRAPPER_DIR}/JlImGuiTestLogLineInfo.cxx
  ${WRAPPER_DIR}/JlImGuiTestOutput.cxx
  ${WRAPPER_DIR}/JlImGuiTestRef.cxx
  ${WRAPPER_DIR}/JlImGuiTestRefDesc.cxx
  ${WRAPPER_DIR}/JlImGuiTestRunTask.cxx
  ${WRAPPER_DIR}/JlImMovingAverage.cxx
  ${WRAPPER_DIR}/JlImVec2.cxx
  ${WRAPPER_DIR}/JlImVec4.cxx
  ${WRAPPER_DIR}/JlStr.cxx
  ${WRAPPER_DIR}/jlImGuiTestEngine.cxx

  # Test engine sources
  ${TE_DIR}/imgui_te_context.cpp
  ${TE_DIR}/imgui_te_coroutine.cpp
  ${TE_DIR}/imgui_te_engine.cpp
  ${TE_DIR}/imgui_te_perftool.cpp
  ${TE_DIR}/imgui_te_ui.cpp
  ${TE_DIR}/imgui_te_utils.cpp
  ${TE_DIR}/imgui_capture_tool.cpp
  ${TE_DIR}/imgui_te_exporters.cpp
)

# cimplot
target_sources(${target} PRIVATE ./cimplot/implot/implot.cpp)
target_sources(${target} PRIVATE ./cimplot/implot/implot_items.cpp)
target_sources(${target} PRIVATE ./cimplot/implot/implot_demo.cpp)
target_sources(${target} PRIVATE ./cimplot/cimplot.cpp)

# cimnodes
target_sources(${target} PRIVATE ./cimnodes/imnodes/imnodes.cpp)
target_sources(${target} PRIVATE ./cimnodes/cimnodes.cpp)

target_compile_definitions(${target} PRIVATE
  IMGUI_DISABLE_OBSOLETE_FUNCTIONS=1
  IMNODES_NAMESPACE=imnodes
  IMGUI_ENABLE_TEST_ENGINE
  IMGUI_TEST_ENGINE_ENABLE_COROUTINE_STDTHREAD_IMPL=0)

# Find GLFW
if (NOT DEFINED GLFW_LIBRARY)
  find_package(glfw3 3.1 REQUIRED)
  set(GLFW_LIBRARY "glfw")
endif()
target_link_libraries(${target} "${GLFW_LIBRARY}")

if (WIN32)
  add_definitions("-DIMGUI_IMPL_API=extern \"C\" __declspec\(dllexport\)")
  target_link_libraries(${target} imm32 opengl32)
elseif(APPLE)
  add_definitions("-DIMGUI_IMPL_API=extern \"C\" ")
  target_link_libraries(${target} "-framework OpenGL")
else()
  add_definitions("-DIMGUI_IMPL_API=extern \"C\" ")
  target_link_libraries(${target} GL)
endif()

# Linking for cxxwrap
find_package(JlCxx)
get_target_property(JlCxx_location JlCxx::cxxwrap_julia LOCATION)
get_filename_component(JlCxx_location ${JlCxx_location} DIRECTORY)
set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib;${JlCxx_location}")
message(STATUS "Found JlCxx at ${JlCxx_location}")
target_link_libraries(${target} JlCxx::cxxwrap_julia)

target_include_directories(${target} PUBLIC
                           $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/cimgui>
                           $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/cimgui/imgui>
                           $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/cimplot>
                           $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/cimplot/implot>
                           $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/cimnodes>
                           $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/cimnodes/imnodes>
                           $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/test_engine/imgui_test_engine/imgui_test_engine>
                           $<INSTALL_INTERFACE:include>)

target_compile_features(${target} PRIVATE cxx_std_11)

set(hdrs ${CMAKE_CURRENT_SOURCE_DIR}/cimgui/imgui/imgui.h
         ${CMAKE_CURRENT_SOURCE_DIR}/cimgui/imgui/imgui_internal.h
         ${CMAKE_CURRENT_SOURCE_DIR}/cimgui/imgui/imconfig.h
         ${CMAKE_CURRENT_SOURCE_DIR}/cimgui/imgui/imstb_rectpack.h
         ${CMAKE_CURRENT_SOURCE_DIR}/cimgui/imgui/imstb_textedit.h
         ${CMAKE_CURRENT_SOURCE_DIR}/cimgui/imgui/imstb_truetype.h
         ${CMAKE_CURRENT_SOURCE_DIR}/cimgui/generator/output/cimgui_impl.h
         ${CMAKE_CURRENT_SOURCE_DIR}/cimgui/cimgui.h
         ${CMAKE_CURRENT_SOURCE_DIR}/cimplot/implot/implot.h
         ${CMAKE_CURRENT_SOURCE_DIR}/cimplot/implot/implot_internal.h
         ${CMAKE_CURRENT_SOURCE_DIR}/cimplot/cimplot.h
         ${CMAKE_CURRENT_SOURCE_DIR}/cimnodes/imnodes/imnodes.h
         ${CMAKE_CURRENT_SOURCE_DIR}/cimnodes/cimnodes.h)
         
set_target_properties(${target} PROPERTIES PUBLIC_HEADER "${hdrs}")

install(TARGETS ${target}
        EXPORT ${target}Targets
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        PUBLIC_HEADER DESTINATION include)

install(EXPORT ${target}Targets
        NAMESPACE ${target}::
        FILE ${target}-config.cmake
        DESTINATION lib/cmake/${target})

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/compile_commands.json DESTINATION share)
