# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "drl_project: 0 messages, 7 services")

set(MSG_I_FLAGS "-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/kinetic/share/geometry_msgs/cmake/../msg;-Ibaxter_core_msgs:/home/dewe/ros_ws/src/baxter_common/baxter_core_msgs/msg;-Icontrol_msgs:/opt/ros/kinetic/share/control_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/kinetic/share/sensor_msgs/cmake/../msg;-Itrajectory_msgs:/opt/ros/kinetic/share/trajectory_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(drl_project_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/AddTwoInts.srv" NAME_WE)
add_custom_target(_drl_project_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "drl_project" "/home/dewe/ros_ws/src/drl_project/srv/AddTwoInts.srv" ""
)

get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/DeleteGazeboModels.srv" NAME_WE)
add_custom_target(_drl_project_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "drl_project" "/home/dewe/ros_ws/src/drl_project/srv/DeleteGazeboModels.srv" ""
)

get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/GetObs.srv" NAME_WE)
add_custom_target(_drl_project_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "drl_project" "/home/dewe/ros_ws/src/drl_project/srv/GetObs.srv" ""
)

get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/Reset.srv" NAME_WE)
add_custom_target(_drl_project_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "drl_project" "/home/dewe/ros_ws/src/drl_project/srv/Reset.srv" ""
)

get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/SetTorque.srv" NAME_WE)
add_custom_target(_drl_project_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "drl_project" "/home/dewe/ros_ws/src/drl_project/srv/SetTorque.srv" ""
)

get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/SpawnBlocks.srv" NAME_WE)
add_custom_target(_drl_project_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "drl_project" "/home/dewe/ros_ws/src/drl_project/srv/SpawnBlocks.srv" ""
)

get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/LoadGazeboModels.srv" NAME_WE)
add_custom_target(_drl_project_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "drl_project" "/home/dewe/ros_ws/src/drl_project/srv/LoadGazeboModels.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/AddTwoInts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/drl_project
)
_generate_srv_cpp(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/DeleteGazeboModels.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/drl_project
)
_generate_srv_cpp(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/GetObs.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/drl_project
)
_generate_srv_cpp(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/Reset.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/drl_project
)
_generate_srv_cpp(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/SetTorque.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/drl_project
)
_generate_srv_cpp(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/SpawnBlocks.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/drl_project
)
_generate_srv_cpp(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/LoadGazeboModels.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/drl_project
)

### Generating Module File
_generate_module_cpp(drl_project
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/drl_project
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(drl_project_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(drl_project_generate_messages drl_project_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/AddTwoInts.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_cpp _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/DeleteGazeboModels.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_cpp _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/GetObs.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_cpp _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/Reset.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_cpp _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/SetTorque.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_cpp _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/SpawnBlocks.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_cpp _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/LoadGazeboModels.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_cpp _drl_project_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(drl_project_gencpp)
add_dependencies(drl_project_gencpp drl_project_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS drl_project_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages

### Generating Services
_generate_srv_eus(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/AddTwoInts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/drl_project
)
_generate_srv_eus(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/DeleteGazeboModels.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/drl_project
)
_generate_srv_eus(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/GetObs.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/drl_project
)
_generate_srv_eus(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/Reset.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/drl_project
)
_generate_srv_eus(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/SetTorque.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/drl_project
)
_generate_srv_eus(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/SpawnBlocks.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/drl_project
)
_generate_srv_eus(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/LoadGazeboModels.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/drl_project
)

### Generating Module File
_generate_module_eus(drl_project
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/drl_project
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(drl_project_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(drl_project_generate_messages drl_project_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/AddTwoInts.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_eus _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/DeleteGazeboModels.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_eus _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/GetObs.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_eus _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/Reset.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_eus _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/SetTorque.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_eus _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/SpawnBlocks.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_eus _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/LoadGazeboModels.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_eus _drl_project_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(drl_project_geneus)
add_dependencies(drl_project_geneus drl_project_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS drl_project_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/AddTwoInts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/drl_project
)
_generate_srv_lisp(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/DeleteGazeboModels.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/drl_project
)
_generate_srv_lisp(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/GetObs.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/drl_project
)
_generate_srv_lisp(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/Reset.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/drl_project
)
_generate_srv_lisp(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/SetTorque.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/drl_project
)
_generate_srv_lisp(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/SpawnBlocks.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/drl_project
)
_generate_srv_lisp(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/LoadGazeboModels.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/drl_project
)

### Generating Module File
_generate_module_lisp(drl_project
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/drl_project
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(drl_project_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(drl_project_generate_messages drl_project_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/AddTwoInts.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_lisp _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/DeleteGazeboModels.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_lisp _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/GetObs.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_lisp _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/Reset.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_lisp _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/SetTorque.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_lisp _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/SpawnBlocks.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_lisp _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/LoadGazeboModels.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_lisp _drl_project_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(drl_project_genlisp)
add_dependencies(drl_project_genlisp drl_project_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS drl_project_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages

### Generating Services
_generate_srv_nodejs(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/AddTwoInts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/drl_project
)
_generate_srv_nodejs(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/DeleteGazeboModels.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/drl_project
)
_generate_srv_nodejs(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/GetObs.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/drl_project
)
_generate_srv_nodejs(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/Reset.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/drl_project
)
_generate_srv_nodejs(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/SetTorque.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/drl_project
)
_generate_srv_nodejs(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/SpawnBlocks.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/drl_project
)
_generate_srv_nodejs(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/LoadGazeboModels.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/drl_project
)

### Generating Module File
_generate_module_nodejs(drl_project
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/drl_project
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(drl_project_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(drl_project_generate_messages drl_project_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/AddTwoInts.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_nodejs _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/DeleteGazeboModels.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_nodejs _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/GetObs.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_nodejs _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/Reset.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_nodejs _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/SetTorque.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_nodejs _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/SpawnBlocks.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_nodejs _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/LoadGazeboModels.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_nodejs _drl_project_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(drl_project_gennodejs)
add_dependencies(drl_project_gennodejs drl_project_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS drl_project_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/AddTwoInts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/drl_project
)
_generate_srv_py(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/DeleteGazeboModels.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/drl_project
)
_generate_srv_py(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/GetObs.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/drl_project
)
_generate_srv_py(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/Reset.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/drl_project
)
_generate_srv_py(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/SetTorque.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/drl_project
)
_generate_srv_py(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/SpawnBlocks.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/drl_project
)
_generate_srv_py(drl_project
  "/home/dewe/ros_ws/src/drl_project/srv/LoadGazeboModels.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/drl_project
)

### Generating Module File
_generate_module_py(drl_project
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/drl_project
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(drl_project_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(drl_project_generate_messages drl_project_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/AddTwoInts.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_py _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/DeleteGazeboModels.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_py _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/GetObs.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_py _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/Reset.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_py _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/SetTorque.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_py _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/SpawnBlocks.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_py _drl_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/dewe/ros_ws/src/drl_project/srv/LoadGazeboModels.srv" NAME_WE)
add_dependencies(drl_project_generate_messages_py _drl_project_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(drl_project_genpy)
add_dependencies(drl_project_genpy drl_project_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS drl_project_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/drl_project)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/drl_project
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(drl_project_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(drl_project_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET baxter_core_msgs_generate_messages_cpp)
  add_dependencies(drl_project_generate_messages_cpp baxter_core_msgs_generate_messages_cpp)
endif()
if(TARGET control_msgs_generate_messages_cpp)
  add_dependencies(drl_project_generate_messages_cpp control_msgs_generate_messages_cpp)
endif()
if(TARGET sensor_msgs_generate_messages_cpp)
  add_dependencies(drl_project_generate_messages_cpp sensor_msgs_generate_messages_cpp)
endif()
if(TARGET trajectory_msgs_generate_messages_cpp)
  add_dependencies(drl_project_generate_messages_cpp trajectory_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/drl_project)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/drl_project
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(drl_project_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(drl_project_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET baxter_core_msgs_generate_messages_eus)
  add_dependencies(drl_project_generate_messages_eus baxter_core_msgs_generate_messages_eus)
endif()
if(TARGET control_msgs_generate_messages_eus)
  add_dependencies(drl_project_generate_messages_eus control_msgs_generate_messages_eus)
endif()
if(TARGET sensor_msgs_generate_messages_eus)
  add_dependencies(drl_project_generate_messages_eus sensor_msgs_generate_messages_eus)
endif()
if(TARGET trajectory_msgs_generate_messages_eus)
  add_dependencies(drl_project_generate_messages_eus trajectory_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/drl_project)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/drl_project
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(drl_project_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(drl_project_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET baxter_core_msgs_generate_messages_lisp)
  add_dependencies(drl_project_generate_messages_lisp baxter_core_msgs_generate_messages_lisp)
endif()
if(TARGET control_msgs_generate_messages_lisp)
  add_dependencies(drl_project_generate_messages_lisp control_msgs_generate_messages_lisp)
endif()
if(TARGET sensor_msgs_generate_messages_lisp)
  add_dependencies(drl_project_generate_messages_lisp sensor_msgs_generate_messages_lisp)
endif()
if(TARGET trajectory_msgs_generate_messages_lisp)
  add_dependencies(drl_project_generate_messages_lisp trajectory_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/drl_project)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/drl_project
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(drl_project_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(drl_project_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET baxter_core_msgs_generate_messages_nodejs)
  add_dependencies(drl_project_generate_messages_nodejs baxter_core_msgs_generate_messages_nodejs)
endif()
if(TARGET control_msgs_generate_messages_nodejs)
  add_dependencies(drl_project_generate_messages_nodejs control_msgs_generate_messages_nodejs)
endif()
if(TARGET sensor_msgs_generate_messages_nodejs)
  add_dependencies(drl_project_generate_messages_nodejs sensor_msgs_generate_messages_nodejs)
endif()
if(TARGET trajectory_msgs_generate_messages_nodejs)
  add_dependencies(drl_project_generate_messages_nodejs trajectory_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/drl_project)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/drl_project\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/drl_project
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(drl_project_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(drl_project_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET baxter_core_msgs_generate_messages_py)
  add_dependencies(drl_project_generate_messages_py baxter_core_msgs_generate_messages_py)
endif()
if(TARGET control_msgs_generate_messages_py)
  add_dependencies(drl_project_generate_messages_py control_msgs_generate_messages_py)
endif()
if(TARGET sensor_msgs_generate_messages_py)
  add_dependencies(drl_project_generate_messages_py sensor_msgs_generate_messages_py)
endif()
if(TARGET trajectory_msgs_generate_messages_py)
  add_dependencies(drl_project_generate_messages_py trajectory_msgs_generate_messages_py)
endif()
