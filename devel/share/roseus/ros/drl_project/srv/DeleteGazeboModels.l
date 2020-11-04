;; Auto-generated. Do not edit!


(when (boundp 'drl_project::DeleteGazeboModels)
  (if (not (find-package "DRL_PROJECT"))
    (make-package "DRL_PROJECT"))
  (shadow 'DeleteGazeboModels (find-package "DRL_PROJECT")))
(unless (find-package "DRL_PROJECT::DELETEGAZEBOMODELS")
  (make-package "DRL_PROJECT::DELETEGAZEBOMODELS"))
(unless (find-package "DRL_PROJECT::DELETEGAZEBOMODELSREQUEST")
  (make-package "DRL_PROJECT::DELETEGAZEBOMODELSREQUEST"))
(unless (find-package "DRL_PROJECT::DELETEGAZEBOMODELSRESPONSE")
  (make-package "DRL_PROJECT::DELETEGAZEBOMODELSRESPONSE"))

(in-package "ROS")





(defclass drl_project::DeleteGazeboModelsRequest
  :super ros::object
  :slots (_only_blocks ))

(defmethod drl_project::DeleteGazeboModelsRequest
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

(defclass drl_project::DeleteGazeboModelsResponse
  :super ros::object
  :slots ())

(defmethod drl_project::DeleteGazeboModelsResponse
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

(defclass drl_project::DeleteGazeboModels
  :super ros::object
  :slots ())

(setf (get drl_project::DeleteGazeboModels :md5sum-) "b129c2666f54b5803dca2de530a0d745")
(setf (get drl_project::DeleteGazeboModels :datatype-) "drl_project/DeleteGazeboModels")
(setf (get drl_project::DeleteGazeboModels :request) drl_project::DeleteGazeboModelsRequest)
(setf (get drl_project::DeleteGazeboModels :response) drl_project::DeleteGazeboModelsResponse)

(defmethod drl_project::DeleteGazeboModelsRequest
  (:response () (instance drl_project::DeleteGazeboModelsResponse :init)))

(setf (get drl_project::DeleteGazeboModelsRequest :md5sum-) "b129c2666f54b5803dca2de530a0d745")
(setf (get drl_project::DeleteGazeboModelsRequest :datatype-) "drl_project/DeleteGazeboModelsRequest")
(setf (get drl_project::DeleteGazeboModelsRequest :definition-)
      "bool only_blocks
---

")

(setf (get drl_project::DeleteGazeboModelsResponse :md5sum-) "b129c2666f54b5803dca2de530a0d745")
(setf (get drl_project::DeleteGazeboModelsResponse :datatype-) "drl_project/DeleteGazeboModelsResponse")
(setf (get drl_project::DeleteGazeboModelsResponse :definition-)
      "bool only_blocks
---

")



(provide :drl_project/DeleteGazeboModels "b129c2666f54b5803dca2de530a0d745")


