// Generated by gencpp from file drl_project/AddTwoInts.msg
// DO NOT EDIT!


#ifndef DRL_PROJECT_MESSAGE_ADDTWOINTS_H
#define DRL_PROJECT_MESSAGE_ADDTWOINTS_H

#include <ros/service_traits.h>


#include <drl_project/AddTwoIntsRequest.h>
#include <drl_project/AddTwoIntsResponse.h>


namespace drl_project
{

struct AddTwoInts
{

typedef AddTwoIntsRequest Request;
typedef AddTwoIntsResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct AddTwoInts
} // namespace drl_project


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::drl_project::AddTwoInts > {
  static const char* value()
  {
    return "6a2e34150c00229791cc89ff309fff21";
  }

  static const char* value(const ::drl_project::AddTwoInts&) { return value(); }
};

template<>
struct DataType< ::drl_project::AddTwoInts > {
  static const char* value()
  {
    return "drl_project/AddTwoInts";
  }

  static const char* value(const ::drl_project::AddTwoInts&) { return value(); }
};


// service_traits::MD5Sum< ::drl_project::AddTwoIntsRequest> should match 
// service_traits::MD5Sum< ::drl_project::AddTwoInts > 
template<>
struct MD5Sum< ::drl_project::AddTwoIntsRequest>
{
  static const char* value()
  {
    return MD5Sum< ::drl_project::AddTwoInts >::value();
  }
  static const char* value(const ::drl_project::AddTwoIntsRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::drl_project::AddTwoIntsRequest> should match 
// service_traits::DataType< ::drl_project::AddTwoInts > 
template<>
struct DataType< ::drl_project::AddTwoIntsRequest>
{
  static const char* value()
  {
    return DataType< ::drl_project::AddTwoInts >::value();
  }
  static const char* value(const ::drl_project::AddTwoIntsRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::drl_project::AddTwoIntsResponse> should match 
// service_traits::MD5Sum< ::drl_project::AddTwoInts > 
template<>
struct MD5Sum< ::drl_project::AddTwoIntsResponse>
{
  static const char* value()
  {
    return MD5Sum< ::drl_project::AddTwoInts >::value();
  }
  static const char* value(const ::drl_project::AddTwoIntsResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::drl_project::AddTwoIntsResponse> should match 
// service_traits::DataType< ::drl_project::AddTwoInts > 
template<>
struct DataType< ::drl_project::AddTwoIntsResponse>
{
  static const char* value()
  {
    return DataType< ::drl_project::AddTwoInts >::value();
  }
  static const char* value(const ::drl_project::AddTwoIntsResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // DRL_PROJECT_MESSAGE_ADDTWOINTS_H
