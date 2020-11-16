; Auto-generated. Do not edit!


(cl:in-package drl_project-srv)


;//! \htmlinclude DeleteGazeboModelsWithTarget-request.msg.html

(cl:defclass <DeleteGazeboModelsWithTarget-request> (roslisp-msg-protocol:ros-message)
  ((only_blocks
    :reader only_blocks
    :initarg :only_blocks
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass DeleteGazeboModelsWithTarget-request (<DeleteGazeboModelsWithTarget-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DeleteGazeboModelsWithTarget-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DeleteGazeboModelsWithTarget-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name drl_project-srv:<DeleteGazeboModelsWithTarget-request> is deprecated: use drl_project-srv:DeleteGazeboModelsWithTarget-request instead.")))

(cl:ensure-generic-function 'only_blocks-val :lambda-list '(m))
(cl:defmethod only_blocks-val ((m <DeleteGazeboModelsWithTarget-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader drl_project-srv:only_blocks-val is deprecated.  Use drl_project-srv:only_blocks instead.")
  (only_blocks m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DeleteGazeboModelsWithTarget-request>) ostream)
  "Serializes a message object of type '<DeleteGazeboModelsWithTarget-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'only_blocks) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DeleteGazeboModelsWithTarget-request>) istream)
  "Deserializes a message object of type '<DeleteGazeboModelsWithTarget-request>"
    (cl:setf (cl:slot-value msg 'only_blocks) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DeleteGazeboModelsWithTarget-request>)))
  "Returns string type for a service object of type '<DeleteGazeboModelsWithTarget-request>"
  "drl_project/DeleteGazeboModelsWithTargetRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DeleteGazeboModelsWithTarget-request)))
  "Returns string type for a service object of type 'DeleteGazeboModelsWithTarget-request"
  "drl_project/DeleteGazeboModelsWithTargetRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DeleteGazeboModelsWithTarget-request>)))
  "Returns md5sum for a message object of type '<DeleteGazeboModelsWithTarget-request>"
  "b129c2666f54b5803dca2de530a0d745")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DeleteGazeboModelsWithTarget-request)))
  "Returns md5sum for a message object of type 'DeleteGazeboModelsWithTarget-request"
  "b129c2666f54b5803dca2de530a0d745")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DeleteGazeboModelsWithTarget-request>)))
  "Returns full string definition for message of type '<DeleteGazeboModelsWithTarget-request>"
  (cl:format cl:nil "bool only_blocks~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DeleteGazeboModelsWithTarget-request)))
  "Returns full string definition for message of type 'DeleteGazeboModelsWithTarget-request"
  (cl:format cl:nil "bool only_blocks~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DeleteGazeboModelsWithTarget-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DeleteGazeboModelsWithTarget-request>))
  "Converts a ROS message object to a list"
  (cl:list 'DeleteGazeboModelsWithTarget-request
    (cl:cons ':only_blocks (only_blocks msg))
))
;//! \htmlinclude DeleteGazeboModelsWithTarget-response.msg.html

(cl:defclass <DeleteGazeboModelsWithTarget-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass DeleteGazeboModelsWithTarget-response (<DeleteGazeboModelsWithTarget-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DeleteGazeboModelsWithTarget-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DeleteGazeboModelsWithTarget-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name drl_project-srv:<DeleteGazeboModelsWithTarget-response> is deprecated: use drl_project-srv:DeleteGazeboModelsWithTarget-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DeleteGazeboModelsWithTarget-response>) ostream)
  "Serializes a message object of type '<DeleteGazeboModelsWithTarget-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DeleteGazeboModelsWithTarget-response>) istream)
  "Deserializes a message object of type '<DeleteGazeboModelsWithTarget-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DeleteGazeboModelsWithTarget-response>)))
  "Returns string type for a service object of type '<DeleteGazeboModelsWithTarget-response>"
  "drl_project/DeleteGazeboModelsWithTargetResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DeleteGazeboModelsWithTarget-response)))
  "Returns string type for a service object of type 'DeleteGazeboModelsWithTarget-response"
  "drl_project/DeleteGazeboModelsWithTargetResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DeleteGazeboModelsWithTarget-response>)))
  "Returns md5sum for a message object of type '<DeleteGazeboModelsWithTarget-response>"
  "b129c2666f54b5803dca2de530a0d745")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DeleteGazeboModelsWithTarget-response)))
  "Returns md5sum for a message object of type 'DeleteGazeboModelsWithTarget-response"
  "b129c2666f54b5803dca2de530a0d745")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DeleteGazeboModelsWithTarget-response>)))
  "Returns full string definition for message of type '<DeleteGazeboModelsWithTarget-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DeleteGazeboModelsWithTarget-response)))
  "Returns full string definition for message of type 'DeleteGazeboModelsWithTarget-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DeleteGazeboModelsWithTarget-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DeleteGazeboModelsWithTarget-response>))
  "Converts a ROS message object to a list"
  (cl:list 'DeleteGazeboModelsWithTarget-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'DeleteGazeboModelsWithTarget)))
  'DeleteGazeboModelsWithTarget-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'DeleteGazeboModelsWithTarget)))
  'DeleteGazeboModelsWithTarget-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DeleteGazeboModelsWithTarget)))
  "Returns string type for a service object of type '<DeleteGazeboModelsWithTarget>"
  "drl_project/DeleteGazeboModelsWithTarget")