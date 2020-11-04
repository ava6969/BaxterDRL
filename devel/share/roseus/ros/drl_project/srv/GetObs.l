;; Auto-generated. Do not edit!


(when (boundp 'drl_project::GetObs)
  (if (not (find-package "DRL_PROJECT"))
    (make-package "DRL_PROJECT"))
  (shadow 'GetObs (find-package "DRL_PROJECT")))
(unless (find-package "DRL_PROJECT::GETOBS")
  (make-package "DRL_PROJECT::GETOBS"))
(unless (find-package "DRL_PROJECT::GETOBSREQUEST")
  (make-package "DRL_PROJECT::GETOBSREQUEST"))
(unless (find-package "DRL_PROJECT::GETOBSRESPONSE")
  (make-package "DRL_PROJECT::GETOBSRESPONSE"))

(in-package "ROS")





(defclass drl_project::GetObsRequest
  :super ros::object
  :slots ())

(defmethod drl_project::GetObsRequest
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

(defclass drl_project::GetObsResponse
  :super ros::object
  :slots (_obs ))

(defmethod drl_project::GetObsResponse
  (:init
   (&key
    ((:obs __obs) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _obs __obs)
   self)
  (:obs
   (&optional __obs)
   (if __obs (setq _obs __obs)) _obs)
  (:serialization-length
   ()
   (+
    ;; float64[] _obs
    (* 8    (length _obs)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64[] _obs
     (write-long (length _obs) s)
     (dotimes (i (length _obs))
       (sys::poke (elt _obs i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64[] _obs
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _obs (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _obs i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;;
   self)
  )

(defclass drl_project::GetObs
  :super ros::object
  :slots ())

(setf (get drl_project::GetObs :md5sum-) "8dac64abe4f5eba5d19614ccef1fe66c")
(setf (get drl_project::GetObs :datatype-) "drl_project/GetObs")
(setf (get drl_project::GetObs :request) drl_project::GetObsRequest)
(setf (get drl_project::GetObs :response) drl_project::GetObsResponse)

(defmethod drl_project::GetObsRequest
  (:response () (instance drl_project::GetObsResponse :init)))

(setf (get drl_project::GetObsRequest :md5sum-) "8dac64abe4f5eba5d19614ccef1fe66c")
(setf (get drl_project::GetObsRequest :datatype-) "drl_project/GetObsRequest")
(setf (get drl_project::GetObsRequest :definition-)
      "---
float64[] obs
")

(setf (get drl_project::GetObsResponse :md5sum-) "8dac64abe4f5eba5d19614ccef1fe66c")
(setf (get drl_project::GetObsResponse :datatype-) "drl_project/GetObsResponse")
(setf (get drl_project::GetObsResponse :definition-)
      "---
float64[] obs
")



(provide :drl_project/GetObs "8dac64abe4f5eba5d19614ccef1fe66c")


