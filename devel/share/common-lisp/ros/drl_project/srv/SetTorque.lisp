; Auto-generated. Do not edit!


(cl:in-package drl_project-srv)


;//! \htmlinclude SetTorque-request.msg.html

(cl:defclass <SetTorque-request> (roslisp-msg-protocol:ros-message)
  ((t_value
    :reader t_value
    :initarg :t_value
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (g_value
    :reader g_value
    :initarg :g_value
    :type cl:float
    :initform 0.0))
)

(cl:defclass SetTorque-request (<SetTorque-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetTorque-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetTorque-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name drl_project-srv:<SetTorque-request> is deprecated: use drl_project-srv:SetTorque-request instead.")))

(cl:ensure-generic-function 't_value-val :lambda-list '(m))
(cl:defmethod t_value-val ((m <SetTorque-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader drl_project-srv:t_value-val is deprecated.  Use drl_project-srv:t_value instead.")
  (t_value m))

(cl:ensure-generic-function 'g_value-val :lambda-list '(m))
(cl:defmethod g_value-val ((m <SetTorque-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader drl_project-srv:g_value-val is deprecated.  Use drl_project-srv:g_value instead.")
  (g_value m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetTorque-request>) ostream)
  "Serializes a message object of type '<SetTorque-request>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 't_value))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 't_value))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'g_value))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetTorque-request>) istream)
  "Deserializes a message object of type '<SetTorque-request>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 't_value) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 't_value)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-double-float-bits bits))))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'g_value) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetTorque-request>)))
  "Returns string type for a service object of type '<SetTorque-request>"
  "drl_project/SetTorqueRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetTorque-request)))
  "Returns string type for a service object of type 'SetTorque-request"
  "drl_project/SetTorqueRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetTorque-request>)))
  "Returns md5sum for a message object of type '<SetTorque-request>"
  "a50b48b6ae6e4ba807756e2843deb824")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetTorque-request)))
  "Returns md5sum for a message object of type 'SetTorque-request"
  "a50b48b6ae6e4ba807756e2843deb824")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetTorque-request>)))
  "Returns full string definition for message of type '<SetTorque-request>"
  (cl:format cl:nil "float64[] t_value~%float64 g_value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetTorque-request)))
  "Returns full string definition for message of type 'SetTorque-request"
  (cl:format cl:nil "float64[] t_value~%float64 g_value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetTorque-request>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 't_value) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetTorque-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetTorque-request
    (cl:cons ':t_value (t_value msg))
    (cl:cons ':g_value (g_value msg))
))
;//! \htmlinclude SetTorque-response.msg.html

(cl:defclass <SetTorque-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass SetTorque-response (<SetTorque-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetTorque-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetTorque-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name drl_project-srv:<SetTorque-response> is deprecated: use drl_project-srv:SetTorque-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetTorque-response>) ostream)
  "Serializes a message object of type '<SetTorque-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetTorque-response>) istream)
  "Deserializes a message object of type '<SetTorque-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetTorque-response>)))
  "Returns string type for a service object of type '<SetTorque-response>"
  "drl_project/SetTorqueResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetTorque-response)))
  "Returns string type for a service object of type 'SetTorque-response"
  "drl_project/SetTorqueResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetTorque-response>)))
  "Returns md5sum for a message object of type '<SetTorque-response>"
  "a50b48b6ae6e4ba807756e2843deb824")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetTorque-response)))
  "Returns md5sum for a message object of type 'SetTorque-response"
  "a50b48b6ae6e4ba807756e2843deb824")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetTorque-response>)))
  "Returns full string definition for message of type '<SetTorque-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetTorque-response)))
  "Returns full string definition for message of type 'SetTorque-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetTorque-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetTorque-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetTorque-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetTorque)))
  'SetTorque-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetTorque)))
  'SetTorque-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetTorque)))
  "Returns string type for a service object of type '<SetTorque>"
  "drl_project/SetTorque")