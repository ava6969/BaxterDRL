;; Auto-generated. Do not edit!


(when (boundp 'drl_project::LoadGazeboModels)
  (if (not (find-package "DRL_PROJECT"))
    (make-package "DRL_PROJECT"))
  (shadow 'LoadGazeboModels (find-package "DRL_PROJECT")))
(unless (find-package "DRL_PROJECT::LOADGAZEBOMODELS")
  (make-package "DRL_PROJECT::LOADGAZEBOMODELS"))
(unless (find-package "DRL_PROJECT::LOADGAZEBOMODELSREQUEST")
  (make-package "DRL_PROJECT::LOADGAZEBOMODELSREQUEST"))
(unless (find-package "DRL_PROJECT::LOADGAZEBOMODELSRESPONSE")
  (make-package "DRL_PROJECT::LOADGAZEBOMODELSRESPONSE"))

(in-package "ROS")





(defclass drl_project::LoadGazeboModelsRequest
  :super ros::object
  :slots (_table_pose _table_reference_frame _block_pose _block_reference_frame ))

(defmethod drl_project::LoadGazeboModelsRequest
  (:init
   (&key
    ((:table_pose __table_pose) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:table_reference_frame __table_reference_frame) "")
    ((:block_pose __block_pose) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:block_reference_frame __block_reference_frame) "")
    )
   (send-super :init)
   (setq _table_pose __table_pose)
   (setq _table_reference_frame (string __table_reference_frame))
   (setq _block_pose __block_pose)
   (setq _block_reference_frame (string __block_reference_frame))
   self)
  (:table_pose
   (&optional __table_pose)
   (if __table_pose (setq _table_pose __table_pose)) _table_pose)
  (:table_reference_frame
   (&optional __table_reference_frame)
   (if __table_reference_frame (setq _table_reference_frame __table_reference_frame)) _table_reference_frame)
  (:block_pose
   (&optional __block_pose)
   (if __block_pose (setq _block_pose __block_pose)) _block_pose)
  (:block_reference_frame
   (&optional __block_reference_frame)
   (if __block_reference_frame (setq _block_reference_frame __block_reference_frame)) _block_reference_frame)
  (:serialization-length
   ()
   (+
    ;; float64[] _table_pose
    (* 8    (length _table_pose)) 4
    ;; string _table_reference_frame
    4 (length _table_reference_frame)
    ;; float64[] _block_pose
    (* 8    (length _block_pose)) 4
    ;; string _block_reference_frame
    4 (length _block_reference_frame)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64[] _table_pose
     (write-long (length _table_pose) s)
     (dotimes (i (length _table_pose))
       (sys::poke (elt _table_pose i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; string _table_reference_frame
       (write-long (length _table_reference_frame) s) (princ _table_reference_frame s)
     ;; float64[] _block_pose
     (write-long (length _block_pose) s)
     (dotimes (i (length _block_pose))
       (sys::poke (elt _block_pose i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; string _block_reference_frame
       (write-long (length _block_reference_frame) s) (princ _block_reference_frame s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64[] _table_pose
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _table_pose (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _table_pose i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; string _table_reference_frame
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _table_reference_frame (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float64[] _block_pose
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _block_pose (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _block_pose i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; string _block_reference_frame
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _block_reference_frame (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass drl_project::LoadGazeboModelsResponse
  :super ros::object
  :slots ())

(defmethod drl_project::LoadGazeboModelsResponse
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

(defclass drl_project::LoadGazeboModels
  :super ros::object
  :slots ())

(setf (get drl_project::LoadGazeboModels :md5sum-) "5f08058997a8852ae0a653fa727e7b80")
(setf (get drl_project::LoadGazeboModels :datatype-) "drl_project/LoadGazeboModels")
(setf (get drl_project::LoadGazeboModels :request) drl_project::LoadGazeboModelsRequest)
(setf (get drl_project::LoadGazeboModels :response) drl_project::LoadGazeboModelsResponse)

(defmethod drl_project::LoadGazeboModelsRequest
  (:response () (instance drl_project::LoadGazeboModelsResponse :init)))

(setf (get drl_project::LoadGazeboModelsRequest :md5sum-) "5f08058997a8852ae0a653fa727e7b80")
(setf (get drl_project::LoadGazeboModelsRequest :datatype-) "drl_project/LoadGazeboModelsRequest")
(setf (get drl_project::LoadGazeboModelsRequest :definition-)
      "float64[] table_pose
string table_reference_frame
float64[] block_pose
string block_reference_frame
---
")

(setf (get drl_project::LoadGazeboModelsResponse :md5sum-) "5f08058997a8852ae0a653fa727e7b80")
(setf (get drl_project::LoadGazeboModelsResponse :datatype-) "drl_project/LoadGazeboModelsResponse")
(setf (get drl_project::LoadGazeboModelsResponse :definition-)
      "float64[] table_pose
string table_reference_frame
float64[] block_pose
string block_reference_frame
---
")



(provide :drl_project/LoadGazeboModels "5f08058997a8852ae0a653fa727e7b80")


