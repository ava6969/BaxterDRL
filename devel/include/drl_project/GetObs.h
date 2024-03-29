// Generated by gencpp from file drl_project/GetObs.msg
// DO NOT EDIT!


#ifndef DRL_PROJECT_MESSAGE_GETOBS_H
#define DRL_PROJECT_MESSAGE_GETOBS_H

#include <ros/service_traits.h>


#include <drl_project/GetObsRequest.h>
#include <drl_project/GetObsResponse.h>


namespace drl_project
{

struct GetObs
{

typedef GetObsRequest Request;
typedef GetObsResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct GetObs
} // namespace drl_project


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::drl_project::GetObs > {
  static const char* value()
  {
    return "8dac64abe4f5eba5d19614ccef1fe66c";
  }

  static const char* value(const ::drl_project::GetObs&) { return value(); }
};

template<>
struct DataType< ::drl_project::GetObs > {
  static const char* value()
  {
    return "drl_project/GetObs";
  }

  static const char* value(const ::drl_project::GetObs&) { return value(); }
};


// service_traits::MD5Sum< ::drl_project::GetObsRequest> should match 
// service_traits::MD5Sum< ::drl_project::GetObs > 
template<>
struct MD5Sum< ::drl_project::GetObsRequest>
{
  static const char* value()
  {
    return MD5Sum< ::drl_project::GetObs >::value();
  }
  static const char* value(const ::drl_project::GetObsRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::drl_project::GetObsRequest> should match 
// service_traits::DataType< ::drl_project::GetObs > 
template<>
struct DataType< ::drl_project::GetObsRequest>
{
  static const char* value()
  {
    return DataType< ::drl_project::GetObs >::value();
  }
  static const char* value(const ::drl_project::GetObsRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::drl_project::GetObsResponse> should match 
// service_traits::MD5Sum< ::drl_project::GetObs > 
template<>
struct MD5Sum< ::drl_project::GetObsResponse>
{
  static const char* value()
  {
    return MD5Sum< ::drl_project::GetObs >::value();
  }
  static const char* value(const ::drl_project::GetObsResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::drl_project::GetObsResponse> should match 
// service_traits::DataType< ::drl_project::GetObs > 
template<>
struct DataType< ::drl_project::GetObsResponse>
{
  static const char* value()
  {
    return DataType< ::drl_project::GetObs >::value();
  }
  static const char* value(const ::drl_project::GetObsResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // DRL_PROJECT_MESSAGE_GETOBS_H
