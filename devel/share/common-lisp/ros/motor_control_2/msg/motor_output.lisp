; Auto-generated. Do not edit!


(cl:in-package motor_control_2-msg)


;//! \htmlinclude motor_output.msg.html

(cl:defclass <motor_output> (roslisp-msg-protocol:ros-message)
  ((speed
    :reader speed
    :initarg :speed
    :type cl:float
    :initform 0.0)
   (rev
    :reader rev
    :initarg :rev
    :type cl:float
    :initform 0.0)
   (direction
    :reader direction
    :initarg :direction
    :type cl:string
    :initform ""))
)

(cl:defclass motor_output (<motor_output>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <motor_output>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'motor_output)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name motor_control_2-msg:<motor_output> is deprecated: use motor_control_2-msg:motor_output instead.")))

(cl:ensure-generic-function 'speed-val :lambda-list '(m))
(cl:defmethod speed-val ((m <motor_output>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader motor_control_2-msg:speed-val is deprecated.  Use motor_control_2-msg:speed instead.")
  (speed m))

(cl:ensure-generic-function 'rev-val :lambda-list '(m))
(cl:defmethod rev-val ((m <motor_output>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader motor_control_2-msg:rev-val is deprecated.  Use motor_control_2-msg:rev instead.")
  (rev m))

(cl:ensure-generic-function 'direction-val :lambda-list '(m))
(cl:defmethod direction-val ((m <motor_output>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader motor_control_2-msg:direction-val is deprecated.  Use motor_control_2-msg:direction instead.")
  (direction m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <motor_output>) ostream)
  "Serializes a message object of type '<motor_output>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rev))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'direction))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'direction))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <motor_output>) istream)
  "Deserializes a message object of type '<motor_output>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'speed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rev) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'direction) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'direction) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<motor_output>)))
  "Returns string type for a message object of type '<motor_output>"
  "motor_control_2/motor_output")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'motor_output)))
  "Returns string type for a message object of type 'motor_output"
  "motor_control_2/motor_output")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<motor_output>)))
  "Returns md5sum for a message object of type '<motor_output>"
  "159eef3b3a7301d5db300a5f487bda11")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'motor_output)))
  "Returns md5sum for a message object of type 'motor_output"
  "159eef3b3a7301d5db300a5f487bda11")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<motor_output>)))
  "Returns full string definition for message of type '<motor_output>"
  (cl:format cl:nil "float32 speed~%float32 rev~%string direction~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'motor_output)))
  "Returns full string definition for message of type 'motor_output"
  (cl:format cl:nil "float32 speed~%float32 rev~%string direction~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <motor_output>))
  (cl:+ 0
     4
     4
     4 (cl:length (cl:slot-value msg 'direction))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <motor_output>))
  "Converts a ROS message object to a list"
  (cl:list 'motor_output
    (cl:cons ':speed (speed msg))
    (cl:cons ':rev (rev msg))
    (cl:cons ':direction (direction msg))
))
