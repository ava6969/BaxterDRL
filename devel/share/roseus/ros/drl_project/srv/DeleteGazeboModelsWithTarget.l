;; Auto-generated. Do not edit!


(when (boundp 'drl_project::DeleteGazeboModelsWithTarget)
  (if (not (find-package "DRL_PROJECT"))
    (make-package "DRL_PROJECT"))
  (shadow 'DeleteGazeboModelsWithTarget (find-package "DRL_PROJECT")))
(unless (find-package "DRL_PROJECT::DELETEGAZEBOMODELSWITHTARGET")
  (make-package "DRL_PROJECT::DELETEGAZEBOMODELSWITHTARGET"))
(unless (find-package "DRL_PROJECT::DELETEGAZEBOMODELSWITHTARGETREQUEST")
  (make-package "DRL_PROJECT::DELETEGAZEBOMODELSWITHTARGETREQUEST"))
(unless (find-package "DRL_PROJECT::DELETEGAZEBOMODELSWITHTARGETRESPONSE")
  (make-package "DRL_PROJECT::DELETEGAZEBOMODELSWITHTARGETRESPONSE"))

(in-package "ROS")





(defclass drl_project::DeleteGazeboModelsWithTargetRequest
  :super ros::object
  :slots (_only_blocks ))

(defmethod drl_project::DeleteGazeboModelsWithTargetRequest
  (:init
   (&key
    ((:only_blocks __only_blocks) nil)
    )
   (send-super :init)
   (setq _only_blocks __only_blocks)
   self)
  (:only_blocks
   (&optional __only_blocks)
   (if __only_blocks (setq _only_blocks __only_blocks)) _only_blocks)
  (:serialization-length
   ()
   (+
    ;; bool _only_blocks
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _only_blocks
       (if _only_blocks (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _only_blocks
     (setq _only_blocks (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass drl_project::DeleteGazeboModelsWithTargetResponse
  :super ros::object
  :slots ())

(defmethod drl_project::DeleteGazeboModelsWithTargetResponse
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

(defclass drl_project::DeleteGazeboModelsWithTarget
  :super ros::object
  :slots ())

(setf (get drl_project::DeleteGazeboModelsWithTarget :md5sum-) "b129c2666f54b5803dca2de530a0d745")
(setf (get drl_project::DeleteGazeboModelsWithTarget :datatype-) "drl_project/DeleteGazeboModelsWithTarget")
(setf (get drl_project::DeleteGazeboModelsWithTarget :request) drl_project::DeleteGazeboModelsWithTargetRequest)
(setf (get drl_project::DeleteGazeboModelsWithTarget :response) drl_project::DeleteGazeboModelsWithTargetResponse)

(defmethod drl_project::DeleteGazeboModelsWithTargetRequest
  (:response () (instance drl_project::DeleteGazeboModelsWithTargetResponse :init)))

(setf (get drl_project::DeleteGazeboModelsWithTargetRequest :md5sum-) "b129c2666f54b5803dca2de530a0d745")
(setf (get drl_project::DeleteGazeboModelsWithTargetRequest :datatype-) "drl_project/DeleteGazeboModelsWithTargetRequest")
(setf (get drl_project::DeleteGazeboModelsWithTargetRequest :definition-)
      "bool only_blocks
---

")

(setf (get drl_project::DeleteGazeboModelsWithTargetResponse :md5sum-) "b129c2666f54b5803dca2de530a0d745")
(setf (get drl_project::DeleteGazeboModelsWithTargetResponse :datatype-) "drl_project/DeleteGazeboModelsWithTargetResponse")
(setf (get drl_project::DeleteGazeboModelsWithTargetResponse :definition-)
      "bool only_blocks
---

")



(provide :drl_project/DeleteGazeboModelsWithTarget "b129c2666f54b5803dca2de530a0d745")


