; Auto-generated. Do not edit!


(cl:in-package drl_project-srv)


;//! \htmlinclude LoadGazeboModelsWithTarget-request.msg.html

(cl:defclass <LoadGazeboModelsWithTarget-request> (roslisp-msg-protocol:ros-message)
  ((table_pose
    :reader table_pose
    :initarg :table_pose
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (table_reference_frame
    :reader table_reference_frame
    :initarg :table_reference_frame
    :type cl:string
    :initform "")
   (block_pose
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

(cl:defclass LoadGazeboModelsWithTarget-request (<LoadGazeboModelsWithTarget-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LoadGazeboModelsWithTarget-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LoadGazeboModelsWithTarget-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name drl_project-srv:<LoadGazeboModelsWithTarget-request> is deprecated: use drl_project-srv:LoadGazeboModelsWithTarget-request instead.")))

(cl:ensure-generic-function 'table_pose-val :lambda-list '(m))
(cl:defmethod table_pose-val ((m <LoadGazeboModelsWithTarget-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader drl_project-srv:table_pose-val is deprecated.  Use drl_project-srv:table_pose instead.")
  (table_pose m))

(cl:ensure-generic-function 'table_reference_frame-val :lambda-list '(m))
(cl:defmethod table_reference_frame-val ((m <LoadGazeboModelsWithTarget-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader drl_project-srv:table_reference_frame-val is deprecated.  Use drl_project-srv:table_reference_frame instead.")
  (table_reference_frame m))

(cl:ensure-generic-function 'block_pose-val :lambda-list '(m))
(cl:defmethod block_pose-val ((m <LoadGazeboModelsWithTarget-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader drl_project-srv:block_pose-val is deprecated.  Use drl_project-srv:block_pose instead.")
  (block_pose m))

(cl:ensure-generic-function 'block_reference_frame-val :lambda-list '(m))
(cl:defmethod block_reference_frame-val ((m <LoadGazeboModelsWithTarget-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader drl_project-srv:block_reference_frame-val is deprecated.  Use drl_project-srv:block_reference_frame instead.")
  (block_reference_frame m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LoadGazeboModelsWithTarget-request>) ostream)
  "Serializes a message object of type '<LoadGazeboModelsWithTarget-request>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'table_pose))))
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
   (cl:slot-value msg 'table_pose))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'table_reference_frame))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'table_reference_frame))
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LoadGazeboModelsWithTarget-request>) istream)
  "Deserializes a message object of type '<LoadGazeboModelsWithTarget-request>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'table_pose) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'table_pose)))
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
      (cl:setf (cl:slot-value msg 'table_reference_frame) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'table_reference_frame) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LoadGazeboModelsWithTarget-request>)))
  "Returns string type for a service object of type '<LoadGazeboModelsWithTarget-request>"
  "drl_project/LoadGazeboModelsWithTargetRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LoadGazeboModelsWithTarget-request)))
  "Returns string type for a service object of type 'LoadGazeboModelsWithTarget-request"
  "drl_project/LoadGazeboModelsWithTargetRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LoadGazeboModelsWithTarget-request>)))
  "Returns md5sum for a message object of type '<LoadGazeboModelsWithTarget-request>"
  "5f08058997a8852ae0a653fa727e7b80")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LoadGazeboModelsWithTarget-request)))
  "Returns md5sum for a message object of type 'LoadGazeboModelsWithTarget-request"
  "5f08058997a8852ae0a653fa727e7b80")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LoadGazeboModelsWithTarget-request>)))
  "Returns full string definition for message of type '<LoadGazeboModelsWithTarget-request>"
  (cl:format cl:nil "float64[] table_pose~%string table_reference_frame~%float64[] block_pose~%string block_reference_frame~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LoadGazeboModelsWithTarget-request)))
  "Returns full string definition for message of type 'LoadGazeboModelsWithTarget-request"
  (cl:format cl:nil "float64[] table_pose~%string table_reference_frame~%float64[] block_pose~%string block_reference_frame~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LoadGazeboModelsWithTarget-request>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'table_pose) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     4 (cl:length (cl:slot-value msg 'table_reference_frame))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'block_pose) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     4 (cl:length (cl:slot-value msg 'block_reference_frame))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LoadGazeboModelsWithTarget-request>))
  "Converts a ROS message object to a list"
  (cl:list 'LoadGazeboModelsWithTarget-request
    (cl:cons ':table_pose (table_pose msg))
    (cl:cons ':table_reference_frame (table_reference_frame msg))
    (cl:cons ':block_pose (block_pose msg))
    (cl:cons ':block_reference_frame (block_reference_frame msg))
))
;//! \htmlinclude LoadGazeboModelsWithTarget-response.msg.html

(cl:defclass <LoadGazeboModelsWithTarget-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass LoadGazeboModelsWithTarget-response (<LoadGazeboModelsWithTarget-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LoadGazeboModelsWithTarget-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LoadGazeboModelsWithTarget-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name drl_project-srv:<LoadGazeboModelsWithTarget-response> is deprecated: use drl_project-srv:LoadGazeboModelsWithTarget-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LoadGazeboModelsWithTarget-response>) ostream)
  "Serializes a message object of type '<LoadGazeboModelsWithTarget-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LoadGazeboModelsWithTarget-response>) istream)
  "Deserializes a message object of type '<LoadGazeboModelsWithTarget-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LoadGazeboModelsWithTarget-response>)))
  "Returns string type for a service object of type '<LoadGazeboModelsWithTarget-response>"
  "drl_project/LoadGazeboModelsWithTargetResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LoadGazeboModelsWithTarget-response)))
  "Returns string type for a service object of type 'LoadGazeboModelsWithTarget-response"
  "drl_project/LoadGazeboModelsWithTargetResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LoadGazeboModelsWithTarget-response>)))
  "Returns md5sum for a message object of type '<LoadGazeboModelsWithTarget-response>"
  "5f08058997a8852ae0a653fa727e7b80")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LoadGazeboModelsWithTarget-response)))
  "Returns md5sum for a message object of type 'LoadGazeboModelsWithTarget-response"
  "5f08058997a8852ae0a653fa727e7b80")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LoadGazeboModelsWithTarget-response>)))
  "Returns full string definition for message of type '<LoadGazeboModelsWithTarget-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LoadGazeboModelsWithTarget-response)))
  "Returns full string definition for message of type 'LoadGazeboModelsWithTarget-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LoadGazeboModelsWithTarget-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LoadGazeboModelsWithTarget-response>))
  "Converts a ROS message object to a list"
  (cl:list 'LoadGazeboModelsWithTarget-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'LoadGazeboModelsWithTarget)))
  'LoadGazeboModelsWithTarget-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'LoadGazeboModelsWithTarget)))
  'LoadGazeboModelsWithTarget-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LoadGazeboModelsWithTarget)))
  "Returns string type for a service object of type '<LoadGazeboModelsWithTarget>"
  "drl_project/LoadGazeboModelsWithTarget")