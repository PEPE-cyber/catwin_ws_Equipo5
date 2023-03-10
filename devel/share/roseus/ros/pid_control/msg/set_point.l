;; Auto-generated. Do not edit!


(when (boundp 'pid_control::set_point)
  (if (not (find-package "PID_CONTROL"))
    (make-package "PID_CONTROL"))
  (shadow 'set_point (find-package "PID_CONTROL")))
(unless (find-package "PID_CONTROL::SET_POINT")
  (make-package "PID_CONTROL::SET_POINT"))

(in-package "ROS")
;;//! \htmlinclude set_point.msg.html


(defclass pid_control::set_point
  :super ros::object
  :slots (_value _time ))

(defmethod pid_control::set_point
  (:init
   (&key
    ((:value __value) 0.0)
    ((:time __time) 0.0)
    )
   (send-super :init)
   (setq _value (float __value))
   (setq _time (float __time))
   self)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:time
   (&optional __time)
   (if __time (setq _time __time)) _time)
  (:serialization-length
   ()
   (+
    ;; float32 _value
    4
    ;; float64 _time
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _value
       (sys::poke _value (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float64 _time
       (sys::poke _time (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _value
     (setq _value (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float64 _time
     (setq _time (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get pid_control::set_point :md5sum-) "74f8c6fdf5012f9d9f480b319a08e976")
(setf (get pid_control::set_point :datatype-) "pid_control/set_point")
(setf (get pid_control::set_point :definition-)
      "float32 value
float64 time
")



(provide :pid_control/set_point "74f8c6fdf5012f9d9f480b319a08e976")


