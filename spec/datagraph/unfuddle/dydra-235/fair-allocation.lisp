;;; -*- Package: org.datagraph.spocq.implementation; -*-

(in-package :org.datagraph.spocq.implementation)

;;;  This file demonstrates a fair-allocation bug in rmq 2.1.1.
;;;


;;; to observe the protocol exchange
;;; (setq *log-level* :debug)

(defun start-server-process  (mode &key (broker-uri (error "broker-uri is required."))
                                   (queue "request")
                                   (exchange "testing")
                                   (routing-key "request")
                                   (content-type MIME:APPLICATION/OCTET-STREAM))
  
  (loop
    (warn "test server connecting to exchanges...")
    (amqp:with-open-connection (connection :uri broker-uri)
      (amqp:with-open-channel (channel connection
                                       :element-type '(unsigned-byte 8)
                                       :content-type content-type)
        (let ((queue (amqp:queue channel :queue queue))
              (exchange (amqp:exchange channel :exchange exchange))
              (consumer-tag nil))
          (declare (ignorable consumer-tag))

          (setf (amqp.u:channel-content-type channel) content-type)
          (amqp:basic channel :delivery-mode 1)
          (amqp:declare exchange  :type "topic")
          (amqp:declare queue :auto-delete t)
          (amqp:bind queue :exchange exchange :queue queue :routing-key routing-key)
          (amqp:qos (amqp:basic channel) :prefetch-count 1)
          (setf consumer-tag (amqp:consume queue :no-ack nil))
          
          (labels ((handle-request (channel class method &rest args)
                     (declare (dynamic-extent args)
                              (ignore channel method))
                     (let ((request nil))
                       (flet ((receive-message-content (stream content-type)
                                (declare (ignore content-type))
                                (let* ((length (amqp.i::device-body-length stream))
                                      (buffer (make-array length :element-type 'character)))
                                  (read-sequence buffer stream :start 0 :end length))))
                         (declare (dynamic-extent #'receive-message-content))
                         (setf request (apply #'amqp:respond-to-deliver class
                                              :body #'receive-message-content 
                                              args))
                         (format *trace-output* "~%[~s] @server request : ~s" (getpid) request)
                         (ecase mode
                           (:wait (sleep 120))
                           (:continue ))
                         (publish-response (format nil (format nil "[response [~s.~s]]"(getpid)  request))))))
                   (publish-response (response)
                     (amqp:publish channel :body response :exchange exchange
                                   :routing-key "response")
                     (format *trace-output* "~%[~s] @server response: ~s" (getpid) response)
                     t))
                  
                  ;; subscribe to the query and store queues, then run the connection loop
                  (setf (de.setf.amqp.implementation::channel-command channel 'amqp:deliver)
                        #'handle-request)
                  (amqp.u:process-connection-loop connection)))))))

(defun start-client-process  (&key (broker-uri (error "broker-uri is required."))
                                   (queue "response")
                                   (exchange "testing")
                                   (routing-key "response")
                                   (content-type MIME:APPLICATION/OCTET-STREAM))
  
  (loop
    (warn "test client connecting to exchanges...")
    (amqp:with-open-connection (connection :uri broker-uri)
      (amqp:with-open-channel (channel connection
                                       :element-type '(unsigned-byte 8)
                                       :content-type content-type)
        (let ((queue (amqp:queue channel :queue queue))
              (exchange (amqp:exchange channel :exchange exchange))
              (consumer-tag nil)
              (count 0))
          (declare (ignorable consumer-tag))

          (setf (amqp.u:channel-content-type channel) content-type)
          (amqp:basic channel :delivery-mode 1)
          (amqp:declare exchange  :type "topic")
          (amqp:declare queue :auto-delete t)
          (amqp:bind queue :exchange exchange :queue queue :routing-key routing-key)
          (amqp:qos (amqp:basic channel) :prefetch-count 1)
          (setf consumer-tag (amqp:consume queue :no-ack t))
          
          (labels ((handle-response (channel class method &rest args)
                     (declare (dynamic-extent args)
                              (ignore channel method))
                     (let ((response nil))
                       (flet ((receive-message-content (stream content-type)
                                (declare (ignore content-type))
                                (let* ((length (amqp.i::device-body-length stream))
                                       (buffer (make-array length :element-type 'character)))
                                  (read-sequence buffer stream :start 0 :end length))))
                         (declare (dynamic-extent #'receive-message-content))
                         (setf response (apply #'amqp:respond-to-deliver class
                                               :body #'receive-message-content 
                                               args))
                         (format *trace-output* "~%[~s] response: ~s" (getpid) response)
                         (publish-request)
                         t)))
                   (publish-request ()
                     (let ((request (format nil "[request [~s.~d]]" (getpid) (incf count))))
                       (format *trace-output* "~%[~s] @client request : ~s" (getpid) request)
                       (amqp:publish channel :body request
                                     :exchange exchange :routing-key "request"))))
                  
                  ;; subscribe to the query and store queues, then run the connection loop
                  (setf (de.setf.amqp.implementation::channel-command channel 'amqp:deliver)
                        #'handle-response)
                  (publish-request)
                  (amqp.u:process-connection-loop connection)))))))

