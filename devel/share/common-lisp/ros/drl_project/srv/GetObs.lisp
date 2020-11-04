; Auto-generated. Do not edit!


(cl:in-package drl_project-srv)


;//! \htmlinclude GetObs-request.msg.html

(cl:defclass <GetObs-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass GetObs-request (<GetObs-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetObs-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetObs-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name drl_project-srv:<GetObs-request> is deprecated: use drl_project-srv:GetObs-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetObs-request>) ostream)
  "Serializes a message object of type '<GetObs-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetObs-request>) istream)
  "Deserializes a message object of type '<GetObs-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetObs-request>)))
  "Returns string type for a service object of type '<GetObs-request>"
  "drl_project/GetObsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetObs-request)))
  "Returns string type for a service object of type 'GetObs-request"
  "drl_project/GetObsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetObs-request>)))
  "Returns md5sum for a message object of type '<GetObs-request>"
  "8dac64abe4f5eba5d19614ccef1fe66c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetObs-request)))
  "Returns md5sum for a message object of type 'GetObs-request"
  "8dac64abe4f5eba5d19614ccef1fe66c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetObs-request>)))
  "Returns full string definition for message of type '<GetObs-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetObs-request)))
  "Returns full string definition for message of type 'GetObs-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetObs-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetObs-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetObs-request
))
;//! \htmlinclude GetObs-response.msg.html

(cl:defclass <GetObs-response> (roslisp-msg-protocol:ros-message)
  ((obs
    :reader obs
    :initarg :obs
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass GetObs-response (<GetObs-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetObs-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetObs-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name drl_project-srv:<GetObs-response> is deprecated: use drl_project-srv:GetObs-response instead.")))

(cl:ensure-generic-function 'obs-val :lambda-list '(m))
(cl:defmethod obs-val ((m <GetObs-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader drl_project-srv:obs-val is deprecated.  Use drl_project-srv:obs instead.")
  (obs m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetObs-response>) ostream)
  "Serializes a message object of type '<GetObs-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'obs))))
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
   (cl:slot-value msg 'obs))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetObs-response>) istream)
  "Deserializes a message object of type '<GetObs-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'obs) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'obs)))
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
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetObs-response>)))
  "Returns string type for a service object of type '<GetObs-response>"
  "drl_project/GetObsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetObs-response)))
  "Returns string type for a service object of type 'GetObs-response"
  "drl_project/GetObsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetObs-response>)))
  "Returns md5sum for a message object of type '<GetObs-response>"
  "8dac64abe4f5eba5d19614ccef1fe66c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetObs-response)))
  "Returns md5sum for a message object of type 'GetObs-response"
  "8dac64abe4f5eba5d19614ccef1fe66c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetObs-response>)))
  "Returns full string definition for message of type '<GetObs-response>"
  (cl:format cl:nil "float64[] obs~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetObs-response)))
  "Returns full string definition for message of type 'GetObs-response"
  (cl:format cl:nil "float64[] obs~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetObs-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'obs) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetObs-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetObs-response
    (cl:cons ':obs (obs msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetObs)))
  'GetObs-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetObs)))
  'GetObs-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetObs)))
  "Returns string type for a service object of type '<GetObs>"
  "drl_project/GetObs")