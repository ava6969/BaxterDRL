// Generated by gencpp from file drl_project/GetObsResponse.msg
// DO NOT EDIT!


#ifndef DRL_PROJECT_MESSAGE_GETOBSRESPONSE_H
#define DRL_PROJECT_MESSAGE_GETOBSRESPONSE_H


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
struct GetObsResponse_
{
  typedef GetObsResponse_<ContainerAllocator> Type;

  GetObsResponse_()
    : obs()  {
    }
  GetObsResponse_(const ContainerAllocator& _alloc)
    : obs(_alloc)  {
  (void)_alloc;
    }



   typedef std::vector<double, typename ContainerAllocator::template rebind<double>::other >  _obs_type;
  _obs_type obs;





  typedef boost::shared_ptr< ::drl_project::GetObsResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::drl_project::GetObsResponse_<ContainerAllocator> const> ConstPtr;

}; // struct GetObsResponse_

typedef ::drl_project::GetObsResponse_<std::allocator<void> > GetObsResponse;

typedef boost::shared_ptr< ::drl_project::GetObsResponse > GetObsResponsePtr;
typedef boost::shared_ptr< ::drl_project::GetObsResponse const> GetObsResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::drl_project::GetObsResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::drl_project::GetObsResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace drl_project

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': False}
// {'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'actionlib_msgs': ['/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg'], 'trajectory_msgs': ['/opt/ros/kinetic/share/trajectory_msgs/cmake/../msg'], 'sensor_msgs': ['/opt/ros/kinetic/share/sensor_msgs/cmake/../msg'], 'baxter_core_msgs': ['/home/dewe/ros_ws/src/baxter_common/baxter_core_msgs/msg'], 'geometry_msgs': ['/opt/ros/kinetic/share/geometry_msgs/cmake/../msg'], 'control_msgs': ['/opt/ros/kinetic/share/control_msgs/cmake/../msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::drl_project::GetObsResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::drl_project::GetObsResponse_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::drl_project::GetObsResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::drl_project::GetObsResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::drl_project::GetObsResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::drl_project::GetObsResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::drl_project::GetObsResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "8dac64abe4f5eba5d19614ccef1fe66c";
  }

  static const char* value(const ::drl_project::GetObsResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x8dac64abe4f5eba5ULL;
  static const uint64_t static_value2 = 0xd19614ccef1fe66cULL;
};

template<class ContainerAllocator>
struct DataType< ::drl_project::GetObsResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "drl_project/GetObsResponse";
  }

  static const char* value(const ::drl_project::GetObsResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::drl_project::GetObsResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "float64[] obs\n\
";
  }

  static const char* value(const ::drl_project::GetObsResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::drl_project::GetObsResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.obs);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct GetObsResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::drl_project::GetObsResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::drl_project::GetObsResponse_<ContainerAllocator>& v)
  {
    s << indent << "obs[]" << std::endl;
    for (size_t i = 0; i < v.obs.size(); ++i)
    {
      s << indent << "  obs[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.obs[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // DRL_PROJECT_MESSAGE_GETOBSRESPONSE_H
