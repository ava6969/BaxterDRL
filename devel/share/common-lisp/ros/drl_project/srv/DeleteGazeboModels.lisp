; Auto-generated. Do not edit!


(cl:in-package drl_project-srv)


;//! \htmlinclude DeleteGazeboModels-request.msg.html

(cl:defclass <DeleteGazeboModels-request> (roslisp-msg-protocol:ros-message)
  ((only_blocks
    :reader only_blocks
    :initarg :only_blocks
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass DeleteGazeboModels-request (<DeleteGazeboModels-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DeleteGazeboModels-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DeleteGazeboModels-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name drl_project-srv:<DeleteGazeboModels-request> is deprecated: use drl_project-srv:DeleteGazeboModels-request instead.")))

(cl:ensure-generic-function 'only_blocks-val :lambda-list '(m))
(cl:defmethod only_blocks-val ((m <DeleteGazeboModels-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader drl_project-srv:only_blocks-val is deprecated.  Use drl_project-srv:only_blocks instead.")
  (only_blocks m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DeleteGazeboModels-request>) ostream)
  "Serializes a message object of type '<DeleteGazeboModels-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'only_blocks) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DeleteGazeboModels-request>) istream)
  "Deserializes a message object of type '<DeleteGazeboModels-request>"
    (cl:setf (cl:slot-value msg 'only_blocks) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DeleteGazeboModels-request>)))
  "Returns string type for a service object of type '<DeleteGazeboModels-request>"
  "drl_project/DeleteGazeboModelsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DeleteGazeboModels-request)))
  "Returns string type for a service object of type 'DeleteGazeboModels-request"
  "drl_project/DeleteGazeboModelsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DeleteGazeboModels-request>)))
  "Returns md5sum for a message object of type '<DeleteGazeboModels-request>"
  "b129c2666f54b5803dca2de530a0d745")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DeleteGazeboModels-request)))
  "Returns md5sum for a message object of type 'DeleteGazeboModels-request"
  "b129c2666f54b5803dca2de530a0d745")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DeleteGazeboModels-request>)))
  "Returns full string definition for message of type '<DeleteGazeboModels-request>"
  (cl:format cl:nil "bool only_blocks~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DeleteGazeboModels-request)))
  "Returns full string definition for message of type 'DeleteGazeboModels-request"
  (cl:format cl:nil "bool only_blocks~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DeleteGazeboModels-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DeleteGazeboModels-request>))
  "Converts a ROS message object to a list"
  (cl:list 'DeleteGazeboModels-request
    (cl:cons ':only_blocks (only_blocks msg))
))
;//! \htmlinclude DeleteGazeboModels-response.msg.html

(cl:defclass <DeleteGazeboModels-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass DeleteGazeboModels-response (<DeleteGazeboModels-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DeleteGazeboModels-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DeleteGazeboModels-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name drl_project-srv:<DeleteGazeboModels-response> is deprecated: use drl_project-srv:DeleteGazeboModels-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DeleteGazeboModels-response>) ostream)
  "Serializes a message object of type '<DeleteGazeboModels-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DeleteGazeboModels-response>) istream)
  "Deserializes a message object of type '<DeleteGazeboModels-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DeleteGazeboModels-response>)))
  "Returns string type for a service object of type '<DeleteGazeboModels-response>"
  "drl_project/DeleteGazeboModelsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DeleteGazeboModels-response)))
  "Returns string type for a service object of type 'DeleteGazeboModels-response"
  "drl_project/DeleteGazeboModelsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DeleteGazeboModels-response>)))
  "Returns md5sum for a message object of type '<DeleteGazeboModels-response>"
  "b129c2666f54b5803dca2de530a0d745")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DeleteGazeboModels-response)))
  "Returns md5sum for a message object of type 'DeleteGazeboModels-response"
  "b129c2666f54b5803dca2de530a0d745")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DeleteGazeboModels-response>)))
  "Returns full string definition for message of type '<DeleteGazeboModels-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DeleteGazeboModels-response)))
  "Returns full string definition for message of type 'DeleteGazeboModels-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DeleteGazeboModels-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DeleteGazeboModels-response>))
  "Converts a ROS message object to a list"
  (cl:list 'DeleteGazeboModels-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'DeleteGazeboModels)))
  'DeleteGazeboModels-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'DeleteGazeboModels)))
  'DeleteGazeboModels-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DeleteGazeboModels)))
  "Returns string type for a service object of type '<DeleteGazeboModels>"
  "drl_project/DeleteGazeboModels")