cmake_minimum_required(VERSION 2.8.3)

project(gps_goal_server)

find_package(catkin REQUIRED COMPONENTS
  rospy
  tf
  actionlib
  actionlib_msgs
  sensor_msgs
  geometry_msgs
  move_base_msgs
  message_generation
  gps_goal_msgs
)
#add_service_files(
#  FILES
#  gps_goal_msgs/decDegreesToPose.srv
#)
catkin_python_setup()

generate_messages( DEPENDENCIES std_msgs geometry_msgs )
catkin_package(
  LIBRARIES ${PROJECT_NAME}
  CATKIN_DEPENDS rospy tf actionlib actionlib_msgs sensor_msgs geometry_msgs gps_goal_msgs move_base_msgs
)

catkin_install_python(
  PROGRAMS nodes/gps_goal
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

# Install launch files
install(
  DIRECTORY launch/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/launch
)
