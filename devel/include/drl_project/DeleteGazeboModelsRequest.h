// Generated by gencpp from file drl_project/DeleteGazeboModelsRequest.msg
// DO NOT EDIT!


#ifndef DRL_PROJECT_MESSAGE_DELETEGAZEBOMODELSREQUEST_H
#define DRL_PROJECT_MESSAGE_DELETEGAZEBOMODELSREQUEST_H


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
struct DeleteGazeboModelsRequest_
{
  typedef DeleteGazeboModelsRequest_<ContainerAllocator> Type;

  DeleteGazeboModelsRequest_()
    : only_blocks(false)  {
    }
  DeleteGazeboModelsRequest_(const ContainerAllocator& _alloc)
    : only_blocks(false)  {
  (void)_alloc;
    }



   typedef uint8_t _only_blocks_type;
  _only_blocks_type only_blocks;





  typedef boost::shared_ptr< ::drl_project::DeleteGazeboModelsRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::drl_project::DeleteGazeboModelsRequest_<ContainerAllocator> const> ConstPtr;

}; // struct DeleteGazeboModelsRequest_

typedef ::drl_project::DeleteGazeboModelsRequest_<std::allocator<void> > DeleteGazeboModelsRequest;

typedef boost::shared_ptr< ::drl_project::DeleteGazeboModelsRequest > DeleteGazeboModelsRequestPtr;
typedef boost::shared_ptr< ::drl_project::DeleteGazeboModelsRequest const> DeleteGazeboModelsRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::drl_project::DeleteGazeboModelsRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::drl_project::DeleteGazeboModelsRequest_<ContainerAllocator> >::stream(s, "", v);
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
struct IsFixedSize< ::drl_project::DeleteGazeboModelsRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::drl_project::DeleteGazeboModelsRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::drl_project::DeleteGazeboModelsRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::drl_project::DeleteGazeboModelsRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::drl_project::DeleteGazeboModelsRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::drl_project::DeleteGazeboModelsRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::drl_project::DeleteGazeboModelsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "b129c2666f54b5803dca2de530a0d745";
  }

  static const char* value(const ::drl_project::DeleteGazeboModelsRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xb129c2666f54b580ULL;
  static const uint64_t static_value2 = 0x3dca2de530a0d745ULL;
};

template<class ContainerAllocator>
struct DataType< ::drl_project::DeleteGazeboModelsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "drl_project/DeleteGazeboModelsRequest";
  }

  static const char* value(const ::drl_project::DeleteGazeboModelsRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::drl_project::DeleteGazeboModelsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "bool only_blocks\n\
";
  }

  static const char* value(const ::drl_project::DeleteGazeboModelsRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::drl_project::DeleteGazeboModelsRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.only_blocks);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct DeleteGazeboModelsRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::drl_project::DeleteGazeboModelsRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::drl_project::DeleteGazeboModelsRequest_<ContainerAllocator>& v)
  {
    s << indent << "only_blocks: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.only_blocks);
  }
};

} // namespace message_operations
} // namespace ros

#endif // DRL_PROJECT_MESSAGE_DELETEGAZEBOMODELSREQUEST_H
