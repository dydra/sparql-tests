;;; -*- Package:cl-user; -*-

(in-package :cl-user)

;;;  This file demonstrates a fair-allocation bug in rmq 2.1.1.
;;;


;;; to observe the protocol exchange
;;; (setq *log-level* :debug)
;;;
;;; (load "/development/source/library/org/datagraph/sparql-tests/spec/datagraph/unfuddle/dydra-235/fair-allocation.lisp")
;;; (in-package :cl-user)
;;; w/proxy
;;; (start-server-process t :broker-uri "amqp://HETZNERkopakooooooooo:HETZNERasdjfi2j3o4iajs@hetzner.dydra.com:5673")
;;; (start-server-process nil :broker-uri "amqp://HETZNERkopakooooooooo:HETZNERasdjfi2j3o4iajs@hetzner.dydra.com:5673")
;;; (start-client-process 5 :broker-uri "amqp://HETZNERkopakooooooooo:HETZNERasdjfi2j3o4iajs@hetzner.dydra.com:5673")
;;; wo/proxy
;;; (start-server-process t :broker-uri "amqp://HETZNERkopakooooooooo:HETZNERasdjfi2j3o4iajs@hetzner.dydra.com")
;;; (start-server-process nil :broker-uri "amqp://HETZNERkopakooooooooo:HETZNERasdjfi2j3o4iajs@hetzner.dydra.com")
;;; (start-client-process 1 :broker-uri "amqp://HETZNERkopakooooooooo:HETZNERasdjfi2j3o4iajs@hetzner.dydra.com")

(defun start-server-process  (delay &key (broker-uri (error "broker-uri is required."))
				    (pid (gensym))
				    (queue "request")
				    (exchange "testing")
				    (routing-key "request")
				    (content-type mime:text/plain))
  "run a server process which subscribes to a shared queue accepts messages and echoes them back
   with the message-specific routing. id delay is non-null, prompt before each response."
  
  (loop
    (warn "test server connecting to exchanges...")
    (amqp:with-open-connection (connection :uri broker-uri)
      (amqp:with-open-channel (channel connection)
        (let ((queue (amqp:queue channel :queue queue))
              (exchange (amqp:exchange channel :exchange exchange))
              (consumer-tag nil)
	      (basic (amqp:basic channel :delivery-mode 1)))
          (declare (ignorable consumer-tag))

          (setf (amqp.u:channel-content-type channel) content-type)
          (amqp:declare exchange  :type "topic")
          (amqp:declare queue :auto-delete t)
          (amqp:bind queue :exchange exchange :queue queue :routing-key routing-key)
          (amqp:qos basic :prefetch-count 1)
          (setf consumer-tag (amqp:consume queue :no-ack nil))
	  (setf (amqp.u:channel-acknowledge-messages channel) nil)
          
          (labels ((handle-request (channel class method &rest args)
                     (declare (dynamic-extent args)
                              (ignore method))
		     (flet ((read-request (stream content-type)
			      (declare (ignore content-type))
			      (let* ((length (amqp.i::device-body-length stream))
				     (buffer (make-array length :element-type 'character)))
				(read-sequence buffer stream :start 0 :end length)
				buffer)))
			   (declare (dynamic-extent #'read-request))
			   (let* ((request (apply #'amqp:respond-to-deliver class
						  :body #'read-request
						  args))
				   (basic (amqp:basic channel))
				   (tag (amqp:basic-delivery-tag basic)))
			      (format *trace-output* "~%[~a] @server received : ~s" pid request)
			      (when delay
				(format *trace-output* " ... return to continue....")
				(finish-output *trace-output*)
				(read-line *terminal-io*))
			      (publish-response (format nil (format nil "[response [~a.~a]]" pid  request))
						(amqp:basic-reply-to basic))
			      (when (typep tag '(integer 1 *))
				(setf (amqp:basic-delivery-tag basic) 0)
				(amqp::send-ack basic :delivery-tag tag :multiple 1))
			      request)))
                   (publish-response (response key)
                     (amqp:publish channel :body response :exchange exchange :routing-key key)
                     (format *trace-output* "~%[~a] @server sent: ~s -> ~s" pid response key)
		     (finish-output *trace-output*)
                     t))
                  
                  ;; subscribe to the query and store queues, then run the connection loop
                  (setf (de.setf.amqp.implementation::channel-command channel 'amqp:deliver)
                        #'handle-request)
                  (amqp.u:process-connection-loop connection)))))))

(defun start-client-process  (delay &key (broker-uri (error "broker-uri is required."))
				    (pid (gensym))
				    (routing-key (string pid))
				    (queue (format nil "response.~a" routing-key))
				    (exchange "testing")
				    (content-type mime:text/plain))
  "run a client which creates a private response queue, subscribes to it and primes the exchange
   with a first message. each delivered response just triggers another publication."

  (loop
    (warn "test client connecting to exchanges as ~s ..." routing-key)
    (amqp:with-open-connection (connection :uri broker-uri)
      (amqp:with-open-channel (channel connection)
        (let ((queue (amqp:queue channel :queue queue))
              (exchange (amqp:exchange channel :exchange exchange))
              (consumer-tag nil)
              (count 0)
	      (basic (amqp:basic channel :delivery-mode 1)))
          (declare (ignorable consumer-tag))

          (setf (amqp.u:channel-content-type channel) content-type)
          (amqp:declare exchange  :type "topic")
          (amqp:declare queue :auto-delete t)
          (amqp:bind queue :exchange exchange :queue queue :routing-key routing-key)
          (amqp:qos basic :prefetch-count 1)
          (setf consumer-tag (amqp:consume queue :no-ack t))
          
          (labels ((handle-response (channel class method &rest args)
                     (declare (dynamic-extent args)
                              (ignore channel method))
                     (let ((response nil))
                       (flet ((receive-message-content (stream content-type)
                                (declare (ignore content-type))
                                (let* ((length (amqp.i::device-body-length stream))
                                       (buffer (make-array length :element-type 'character)))
                                  (read-sequence buffer stream :start 0 :end length)
				  buffer)))
                         (declare (dynamic-extent #'receive-message-content))
                         (setf response (apply #'amqp:respond-to-deliver class
                                               :body #'receive-message-content 
                                               args))
                         (format *trace-output* "~%[~a] client response: ~s" pid response)
			 (format *trace-output* "~%[~a] sleep: ~d" pid delay)
			 (finish-output *trace-output*)
			 (sleep delay)
                         (publish-request)
                         t)))
                   (publish-request ()
                     (let ((request (format nil "[request [~a.~d]]" routing-key (incf count))))
                       (format *trace-output* "~%[~a] @client request : ~s" routing-key request)
		       (finish-output *trace-output*)
		       (setf (amqp:basic-reply-to basic) routing-key)
                       (amqp:publish channel :body request
                                     :exchange exchange :routing-key "request"))))
                  
                  ;; subscribe to the request queue, send the first message, start the processing loop
                  (setf (de.setf.amqp.implementation::channel-command channel 'amqp:deliver)
                        #'handle-response)
                  (publish-request)
                  (amqp.u:process-connection-loop connection)))))))

