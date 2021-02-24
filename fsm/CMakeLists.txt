
cmake_minimum_required(VERSION 3.16)

set(FSM_VERSION 0.1.0)

project(fsm VERSION ${FSM_VERSION} LANGUAGES CXX)
include(../graph/cmake/StandardProjectSettings.cmake)

add_library(fsm INTERFACE)
