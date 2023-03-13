;; Auto-generated. Do not edit!


(when (boundp 'motor_control_2::motor_output)
  (if (not (find-package "MOTOR_CONTROL_2"))
    (make-package "MOTOR_CONTROL_2"))
  (shadow 'motor_output (find-package "MOTOR_CONTROL_2")))
(unless (find-package "MOTOR_CONTROL_2::MOTOR_OUTPUT")
  (make-package "MOTOR_CONTROL_2::MOTOR_OUTPUT"))

(in-package "ROS")
;;//! \htmlinclude motor_output.msg.html


(defclass motor_control_2::motor_output
  :super ros::object
  :slots (_speed _rev _direction ))

(defmethod motor_control_2::motor_output
  (:init
   (&key
    ((:speed __speed) 0.0)
    ((:rev __rev) 0.0)
    ((:direction __direction) "")
    )
   (send-super :init)
   (setq _speed (float __speed))
   (setq _rev (float __rev))
   (setq _direction (string __direction))
   self)
  (:speed
   (&optional __speed)
   (if __speed (setq _speed __speed)) _speed)
  (:rev
   (&optional __rev)
   (if __rev (setq _rev __rev)) _rev)
  (:direction
   (&optional __direction)
   (if __direction (setq _direction __direction)) _direction)
  (:serialization-length
   ()
   (+
    ;; float32 _speed
    4
    ;; float32 _rev
    4
    ;; string _direction
    4 (length _direction)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _speed
       (sys::poke _speed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _rev
       (sys::poke _rev (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string _direction
       (write-long (length _direction) s) (princ _direction s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _speed
     (setq _speed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _rev
     (setq _rev (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string _direction
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _direction (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get motor_control_2::motor_output :md5sum-) "159eef3b3a7301d5db300a5f487bda11")
(setf (get motor_control_2::motor_output :datatype-) "motor_control_2/motor_output")
(setf (get motor_control_2::motor_output :definition-)
      "float32 speed
float32 rev
string direction
")



(provide :motor_control_2/motor_output "159eef3b3a7301d5db300a5f487bda11")


