# Install script for directory: /home/dewe/ros_ws/src/drl_project

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/drl_project/srv" TYPE FILE FILES
    "/home/dewe/ros_ws/src/drl_project/srv/AddTwoInts.srv"
    "/home/dewe/ros_ws/src/drl_project/srv/GetObs.srv"
    "/home/dewe/ros_ws/src/drl_project/srv/DeleteGazeboModels.srv"
    "/home/dewe/ros_ws/src/drl_project/srv/LoadGazeboModels.srv"
    "/home/dewe/ros_ws/src/drl_project/srv/DeleteGazeboModelsWithTarget.srv"
    "/home/dewe/ros_ws/src/drl_project/srv/LoadGazeboModelsWithTarget.srv"
    "/home/dewe/ros_ws/src/drl_project/srv/SpawnBlocksWithTarget.srv"
    "/home/dewe/ros_ws/src/drl_project/srv/Reset.srv"
    "/home/dewe/ros_ws/src/drl_project/srv/SpawnBlocks.srv"
    "/home/dewe/ros_ws/src/drl_project/srv/SetTorque.srv"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/drl_project/cmake" TYPE FILE FILES "/home/dewe/ros_ws/src/build/drl_project/catkin_generated/installspace/drl_project-msg-paths.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/dewe/ros_ws/src/build/devel/include/drl_project")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/dewe/ros_ws/src/build/devel/share/roseus/ros/drl_project")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/dewe/ros_ws/src/build/devel/share/common-lisp/ros/drl_project")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/dewe/ros_ws/src/build/devel/share/gennodejs/ros/drl_project")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/usr/bin/python2" -m compileall "/home/dewe/ros_ws/src/build/devel/lib/python2.7/dist-packages/drl_project")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/dewe/ros_ws/src/build/devel/lib/python2.7/dist-packages/drl_project")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/dewe/ros_ws/src/build/drl_project/catkin_generated/installspace/drl_project.pc")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/drl_project/cmake" TYPE FILE FILES "/home/dewe/ros_ws/src/build/drl_project/catkin_generated/installspace/drl_project-msg-extras.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/drl_project/cmake" TYPE FILE FILES
    "/home/dewe/ros_ws/src/build/drl_project/catkin_generated/installspace/drl_projectConfig.cmake"
    "/home/dewe/ros_ws/src/build/drl_project/catkin_generated/installspace/drl_projectConfig-version.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/drl_project" TYPE FILE FILES "/home/dewe/ros_ws/src/drl_project/package.xml")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/drl_project" TYPE PROGRAM FILES "/home/dewe/ros_ws/src/build/drl_project/catkin_generated/installspace/gazebo_connection.py")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/drl_project" TYPE PROGRAM FILES "/home/dewe/ros_ws/src/build/drl_project/catkin_generated/installspace/mybaxter_env.py")
endif()

