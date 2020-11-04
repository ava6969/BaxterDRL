// Generated by gencpp from file drl_project/SpawnBlocksResponse.msg
// DO NOT EDIT!


#ifndef DRL_PROJECT_MESSAGE_SPAWNBLOCKSRESPONSE_H
#define DRL_PROJECT_MESSAGE_SPAWNBLOCKSRESPONSE_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace drl_project
{
template <class ContainerAllocator>
struct SpawnBlocksResponse_
{
  typedef SpawnBlocksResponse_<ContainerAllocator> Type;

  SpawnBlocksResponse_()
    {
    }
  SpawnBlocksResponse_(const ContainerAllocator& _alloc)
    {
  (void)_alloc;
    }







  typedef boost::shared_ptr< ::drl_project::SpawnBlocksResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::drl_project::SpawnBlocksResponse_<ContainerAllocator> const> ConstPtr;

}; // struct SpawnBlocksResponse_

typedef ::drl_project::SpawnBlocksResponse_<std::allocator<void> > SpawnBlocksResponse;

typedef boost::shared_ptr< ::drl_project::SpawnBlocksResponse > SpawnBlocksResponsePtr;
typedef boost::shared_ptr< ::drl_project::SpawnBlocksResponse const> SpawnBlocksResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::drl_project::SpawnBlocksResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::drl_project::SpawnBlocksResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace drl_project

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'actionlib_msgs': ['/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg'], 'trajectory_msgs': ['/opt/ros/kinetic/share/trajectory_msgs/cmake/../msg'], 'sensor_msgs': ['/opt/ros/kinetic/share/sensor_msgs/cmake/../msg'], 'baxter_core_msgs': ['/home/dewe/ros_ws/src/baxter_common/baxter_core_msgs/msg'], 'geometry_msgs': ['/opt/ros/kinetic/share/geometry_msgs/cmake/../msg'], 'control_msgs': ['/opt/ros/kinetic/share/control_msgs/cmake/../msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::drl_project::SpawnBlocksResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::drl_project::SpawnBlocksResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::drl_project::SpawnBlocksResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::drl_project::SpawnBlocksResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::drl_project::SpawnBlocksResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::drl_project::SpawnBlocksResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::drl_project::SpawnBlocksResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "d41d8cd98f00b204e9800998ecf8427e";
  }

  static const char* value(const ::drl_project::SpawnBlocksResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xd41d8cd98f00b204ULL;
  static const uint64_t static_value2 = 0xe9800998ecf8427eULL;
};

template<class ContainerAllocator>
struct DataType< ::drl_project::SpawnBlocksResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "drl_project/SpawnBlocksResponse";
  }

  static const char* value(const ::drl_project::SpawnBlocksResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::drl_project::SpawnBlocksResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n\
";
  }

  static const char* value(const ::drl_project::SpawnBlocksResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::drl_project::SpawnBlocksResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream&, T)
    {}

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct SpawnBlocksResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::drl_project::SpawnBlocksResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream&, const std::string&, const ::drl_project::SpawnBlocksResponse_<ContainerAllocator>&)
  {}
};

} // namespace message_operations
} // namespace ros

#endif // DRL_PROJECT_MESSAGE_SPAWNBLOCKSRESPONSE_H
