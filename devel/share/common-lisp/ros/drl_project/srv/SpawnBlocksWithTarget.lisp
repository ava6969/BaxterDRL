; Auto-generated. Do not edit!


(cl:in-package drl_project-srv)


;//! \htmlinclude SpawnBlocksWithTarget-request.msg.html

(cl:defclass <SpawnBlocksWithTarget-request> (roslisp-msg-protocol:ros-message)
  ((block_pose
    :reader block_pose
    :initarg :block_pose
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (block_reference_frame
    :reader block_reference_frame
    :initarg :block_reference_frame
    :type cl:string
    :initform ""))
)

(cl:defclass SpawnBlocksWithTarget-request (<SpawnBlocksWithTarget-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SpawnBlocksWithTarget-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SpawnBlocksWithTarget-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name drl_project-srv:<SpawnBlocksWithTarget-request> is deprecated: use drl_project-srv:SpawnBlocksWithTarget-request instead.")))

(cl:ensure-generic-function 'block_pose-val :lambda-list '(m))
(cl:defmethod block_pose-val ((m <SpawnBlocksWithTarget-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader drl_project-srv:block_pose-val is deprecated.  Use drl_project-srv:block_pose instead.")
  (block_pose m))

(cl:ensure-generic-function 'block_reference_frame-val :lambda-list '(m))
(cl:defmethod block_reference_frame-val ((m <SpawnBlocksWithTarget-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader drl_project-srv:block_reference_frame-val is deprecated.  Use drl_project-srv:block_reference_frame instead.")
  (block_reference_frame m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SpawnBlocksWithTarget-request>) ostream)
  "Serializes a message object of type '<SpawnBlocksWithTarget-request>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'block_pose))))
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
   (cl:slot-value msg 'block_pose))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'block_reference_frame))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'block_reference_frame))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SpawnBlocksWithTarget-request>) istream)
  "Deserializes a message object of type '<SpawnBlocksWithTarget-request>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'block_pose) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'block_pose)))
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
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'block_reference_frame) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'block_reference_frame) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SpawnBlocksWithTarget-request>)))
  "Returns string type for a service object of type '<SpawnBlocksWithTarget-request>"
  "drl_project/SpawnBlocksWithTargetRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SpawnBlocksWithTarget-request)))
  "Returns string type for a service object of type 'SpawnBlocksWithTarget-request"
  "drl_project/SpawnBlocksWithTargetRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SpawnBlocksWithTarget-request>)))
  "Returns md5sum for a message object of type '<SpawnBlocksWithTarget-request>"
  "3a354f469531ae7418e2e3001fc52e12")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SpawnBlocksWithTarget-request)))
  "Returns md5sum for a message object of type 'SpawnBlocksWithTarget-request"
  "3a354f469531ae7418e2e3001fc52e12")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SpawnBlocksWithTarget-request>)))
  "Returns full string definition for message of type '<SpawnBlocksWithTarget-request>"
  (cl:format cl:nil "float64[] block_pose~%string block_reference_frame~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SpawnBlocksWithTarget-request)))
  "Returns full string definition for message of type 'SpawnBlocksWithTarget-request"
  (cl:format cl:nil "float64[] block_pose~%string block_reference_frame~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SpawnBlocksWithTarget-request>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'block_pose) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     4 (cl:length (cl:slot-value msg 'block_reference_frame))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SpawnBlocksWithTarget-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SpawnBlocksWithTarget-request
    (cl:cons ':block_pose (block_pose msg))
    (cl:cons ':block_reference_frame (block_reference_frame msg))
))
;//! \htmlinclude SpawnBlocksWithTarget-response.msg.html

(cl:defclass <SpawnBlocksWithTarget-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass SpawnBlocksWithTarget-response (<SpawnBlocksWithTarget-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SpawnBlocksWithTarget-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SpawnBlocksWithTarget-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name drl_project-srv:<SpawnBlocksWithTarget-response> is deprecated: use drl_project-srv:SpawnBlocksWithTarget-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SpawnBlocksWithTarget-response>) ostream)
  "Serializes a message object of type '<SpawnBlocksWithTarget-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SpawnBlocksWithTarget-response>) istream)
  "Deserializes a message object of type '<SpawnBlocksWithTarget-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SpawnBlocksWithTarget-response>)))
  "Returns string type for a service object of type '<SpawnBlocksWithTarget-response>"
  "drl_project/SpawnBlocksWithTargetResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SpawnBlocksWithTarget-response)))
  "Returns string type for a service object of type 'SpawnBlocksWithTarget-response"
  "drl_project/SpawnBlocksWithTargetResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SpawnBlocksWithTarget-response>)))
  "Returns md5sum for a message object of type '<SpawnBlocksWithTarget-response>"
  "3a354f469531ae7418e2e3001fc52e12")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SpawnBlocksWithTarget-response)))
  "Returns md5sum for a message object of type 'SpawnBlocksWithTarget-response"
  "3a354f469531ae7418e2e3001fc52e12")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SpawnBlocksWithTarget-response>)))
  "Returns full string definition for message of type '<SpawnBlocksWithTarget-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SpawnBlocksWithTarget-response)))
  "Returns full string definition for message of type 'SpawnBlocksWithTarget-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SpawnBlocksWithTarget-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SpawnBlocksWithTarget-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SpawnBlocksWithTarget-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SpawnBlocksWithTarget)))
  'SpawnBlocksWithTarget-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SpawnBlocksWithTarget)))
  'SpawnBlocksWithTarget-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SpawnBlocksWithTarget)))
  "Returns string type for a service object of type '<SpawnBlocksWithTarget>"
  "drl_project/SpawnBlocksWithTarget")