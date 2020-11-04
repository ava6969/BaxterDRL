;; Auto-generated. Do not edit!


(when (boundp 'drl_project::SpawnBlocks)
  (if (not (find-package "DRL_PROJECT"))
    (make-package "DRL_PROJECT"))
  (shadow 'SpawnBlocks (find-package "DRL_PROJECT")))
(unless (find-package "DRL_PROJECT::SPAWNBLOCKS")
  (make-package "DRL_PROJECT::SPAWNBLOCKS"))
(unless (find-package "DRL_PROJECT::SPAWNBLOCKSREQUEST")
  (make-package "DRL_PROJECT::SPAWNBLOCKSREQUEST"))
(unless (find-package "DRL_PROJECT::SPAWNBLOCKSRESPONSE")
  (make-package "DRL_PROJECT::SPAWNBLOCKSRESPONSE"))

(in-package "ROS")





(defclass drl_project::SpawnBlocksRequest
  :super ros::object
  :slots (_block_pose _block_reference_frame ))

(defmethod drl_project::SpawnBlocksRequest
  (:init
   (&key
    ((:block_pose __block_pose) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:block_reference_frame __block_reference_frame) "")
    )
   (send-super :init)
   (setq _block_pose __block_pose)
   (setq _block_reference_frame (string __block_reference_frame))
   self)
  (:block_pose
   (&optional __block_pose)
   (if __block_pose (setq _block_pose __block_pose)) _block_pose)
  (:block_reference_frame
   (&optional __block_reference_frame)
   (if __block_reference_frame (setq _block_reference_frame __block_reference_frame)) _block_reference_frame)
  (:serialization-length
   ()
   (+
    ;; float64[] _block_pose
    (* 8    (length _block_pose)) 4
    ;; string _block_reference_frame
    4 (length _block_reference_frame)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
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

(defclass drl_project::SpawnBlocksResponse
  :super ros::object
  :slots ())

(defmethod drl_project::SpawnBlocksResponse
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

(defclass drl_project::SpawnBlocks
  :super ros::object
  :slots ())

(setf (get drl_project::SpawnBlocks :md5sum-) "3a354f469531ae7418e2e3001fc52e12")
(setf (get drl_project::SpawnBlocks :datatype-) "drl_project/SpawnBlocks")
(setf (get drl_project::SpawnBlocks :request) drl_project::SpawnBlocksRequest)
(setf (get drl_project::SpawnBlocks :response) drl_project::SpawnBlocksResponse)

(defmethod drl_project::SpawnBlocksRequest
  (:response () (instance drl_project::SpawnBlocksResponse :init)))

(setf (get drl_project::SpawnBlocksRequest :md5sum-) "3a354f469531ae7418e2e3001fc52e12")
(setf (get drl_project::SpawnBlocksRequest :datatype-) "drl_project/SpawnBlocksRequest")
(setf (get drl_project::SpawnBlocksRequest :definition-)
      "float64[] block_pose
string block_reference_frame
---
")

(setf (get drl_project::SpawnBlocksResponse :md5sum-) "3a354f469531ae7418e2e3001fc52e12")
(setf (get drl_project::SpawnBlocksResponse :datatype-) "drl_project/SpawnBlocksResponse")
(setf (get drl_project::SpawnBlocksResponse :definition-)
      "float64[] block_pose
string block_reference_frame
---
")



(provide :drl_project/SpawnBlocks "3a354f469531ae7418e2e3001fc52e12")


