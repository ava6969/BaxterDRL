;; Auto-generated. Do not edit!


(when (boundp 'drl_project::Reset)
  (if (not (find-package "DRL_PROJECT"))
    (make-package "DRL_PROJECT"))
  (shadow 'Reset (find-package "DRL_PROJECT")))
(unless (find-package "DRL_PROJECT::RESET")
  (make-package "DRL_PROJECT::RESET"))
(unless (find-package "DRL_PROJECT::RESETREQUEST")
  (make-package "DRL_PROJECT::RESETREQUEST"))
(unless (find-package "DRL_PROJECT::RESETRESPONSE")
  (make-package "DRL_PROJECT::RESETRESPONSE"))

(in-package "ROS")





(defclass drl_project::ResetRequest
  :super ros::object
  :slots ())

(defmethod drl_project::ResetRequest
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass drl_project::ResetResponse
  :super ros::object
  :slots ())

(defmethod drl_project::ResetResponse
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass drl_project::Reset
  :super ros::object
  :slots ())

(setf (get drl_project::Reset :md5sum-) "d41d8cd98f00b204e9800998ecf8427e")
(setf (get drl_project::Reset :datatype-) "drl_project/Reset")
(setf (get drl_project::Reset :request) drl_project::ResetRequest)
(setf (get drl_project::Reset :response) drl_project::ResetResponse)

(defmethod drl_project::ResetRequest
  (:response () (instance drl_project::ResetResponse :init)))

(setf (get drl_project::ResetRequest :md5sum-) "d41d8cd98f00b204e9800998ecf8427e")
(setf (get drl_project::ResetRequest :datatype-) "drl_project/ResetRequest")
(setf (get drl_project::ResetRequest :definition-)
      "---
")

(setf (get drl_project::ResetResponse :md5sum-) "d41d8cd98f00b204e9800998ecf8427e")
(setf (get drl_project::ResetResponse :datatype-) "drl_project/ResetResponse")
(setf (get drl_project::ResetResponse :definition-)
      "---
")



(provide :drl_project/Reset "d41d8cd98f00b204e9800998ecf8427e")


