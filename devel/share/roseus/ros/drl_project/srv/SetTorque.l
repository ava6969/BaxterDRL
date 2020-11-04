;; Auto-generated. Do not edit!


(when (boundp 'drl_project::SetTorque)
  (if (not (find-package "DRL_PROJECT"))
    (make-package "DRL_PROJECT"))
  (shadow 'SetTorque (find-package "DRL_PROJECT")))
(unless (find-package "DRL_PROJECT::SETTORQUE")
  (make-package "DRL_PROJECT::SETTORQUE"))
(unless (find-package "DRL_PROJECT::SETTORQUEREQUEST")
  (make-package "DRL_PROJECT::SETTORQUEREQUEST"))
(unless (find-package "DRL_PROJECT::SETTORQUERESPONSE")
  (make-package "DRL_PROJECT::SETTORQUERESPONSE"))

(in-package "ROS")





(defclass drl_project::SetTorqueRequest
  :super ros::object
  :slots (_t_value _g_value ))

(defmethod drl_project::SetTorqueRequest
  (:init
   (&key
    ((:t_value __t_value) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:g_value __g_value) 0.0)
    )
   (send-super :init)
   (setq _t_value __t_value)
   (setq _g_value (float __g_value))
   self)
  (:t_value
   (&optional __t_value)
   (if __t_value (setq _t_value __t_value)) _t_value)
  (:g_value
   (&optional __g_value)
   (if __g_value (setq _g_value __g_value)) _g_value)
  (:serialization-length
   ()
   (+
    ;; float64[] _t_value
    (* 8    (length _t_value)) 4
    ;; float64 _g_value
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64[] _t_value
     (write-long (length _t_value) s)
     (dotimes (i (length _t_value))
       (sys::poke (elt _t_value i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64 _g_value
       (sys::poke _g_value (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64[] _t_value
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _t_value (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _t_value i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; float64 _g_value
     (setq _g_value (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass drl_project::SetTorqueResponse
  :super ros::object
  :slots ())

(defmethod drl_project::SetTorqueResponse
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

(defclass drl_project::SetTorque
  :super ros::object
  :slots ())

(setf (get drl_project::SetTorque :md5sum-) "a50b48b6ae6e4ba807756e2843deb824")
(setf (get drl_project::SetTorque :datatype-) "drl_project/SetTorque")
(setf (get drl_project::SetTorque :request) drl_project::SetTorqueRequest)
(setf (get drl_project::SetTorque :response) drl_project::SetTorqueResponse)

(defmethod drl_project::SetTorqueRequest
  (:response () (instance drl_project::SetTorqueResponse :init)))

(setf (get drl_project::SetTorqueRequest :md5sum-) "a50b48b6ae6e4ba807756e2843deb824")
(setf (get drl_project::SetTorqueRequest :datatype-) "drl_project/SetTorqueRequest")
(setf (get drl_project::SetTorqueRequest :definition-)
      "float64[] t_value
float64 g_value
---

")

(setf (get drl_project::SetTorqueResponse :md5sum-) "a50b48b6ae6e4ba807756e2843deb824")
(setf (get drl_project::SetTorqueResponse :datatype-) "drl_project/SetTorqueResponse")
(setf (get drl_project::SetTorqueResponse :definition-)
      "float64[] t_value
float64 g_value
---

")



(provide :drl_project/SetTorque "a50b48b6ae6e4ba807756e2843deb824")


