;; Copyright 2017 John J Foerch. All rights reserved.
;;
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions are
;; met:
;;
;;    1. Redistributions of source code must retain the above copyright
;;       notice, this list of conditions and the following disclaimer.
;;
;;    2. Redistributions in binary form must reproduce the above copyright
;;       notice, this list of conditions and the following disclaimer in
;;       the documentation and/or other materials provided with the
;;       distribution.
;;
;; THIS SOFTWARE IS PROVIDED BY JOHN J FOERCH ''AS IS'' AND ANY EXPRESS OR
;; IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
;; WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
;; DISCLAIMED. IN NO EVENT SHALL JOHN J FOERCH OR CONTRIBUTORS BE LIABLE
;; FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
;; BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
;; WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
;; OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
;; ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

(module xfixes
        (xfixesselectionnotifyevent-type
         xfixesselectionnotifyevent-serial
         xfixesselectionnotifyevent-send_event
         xfixesselectionnotifyevent-display
         xfixesselectionnotifyevent-window
         xfixesselectionnotifyevent-subtype
         xfixesselectionnotifyevent-owner
         xfixesselectionnotifyevent-selection
         xfixesselectionnotifyevent-timestamp
         xfixesselectionnotifyevent-selection_timestamp

         xfixescursornotifyevent-type
         xfixescursornotifyevent-serial
         xfixescursornotifyevent-send_event
         xfixescursornotifyevent-display
         xfixescursornotifyevent-window
         xfixescursornotifyevent-subtype
         xfixescursornotifyevent-cursor_serial
         xfixescursornotifyevent-timestamp
         xfixescursornotifyevent-cursor_name

         xfixes-query-extension
         xfixes-query-version
         xfixes-version

         XFIXESSELECTIONNOTIFY
         XFIXESSETSELECTIONOWNERNOTIFYMASK
         XFIXESSELECTIONWINDOWDESTROYNOTIFYMASK
         XFIXESSELECTIONCLIENTCLOSENOTIFYMASK

         xfixes-select-selection-input

         )

(import chicken scheme foreign foreigners)

(foreign-declare "#include <X11/extensions/Xfixes.h>")

(define-foreign-type XID unsigned-long)
(define-foreign-type Atom unsigned-long)
(define-foreign-type Cursor XID)
(define-foreign-type Display c-pointer)
(define-foreign-type Picture XID)
(define-foreign-type Pixmap XID)
(define-foreign-type XserverRegion XID)
(define-foreign-type Status int)
(define-foreign-type Time unsigned-long)
(define-foreign-type Window XID)
(define-foreign-type XRectangle c-pointer)

(define-foreign-record-type (XFixesSelectionNotifyEvent XFixesSelectionNotifyEvent)
  (constructor: %make-xfixesselectionnotifyevent)
  (destructor: %free-xfixesselectionnotifyevent)
  (int type xfixesselectionnotifyevent-type)
  (unsigned-long serial xfixesselectionnotifyevent-serial)
  (bool send_event xfixesselectionnotifyevent-send_event)
  (Display display xfixesselectionnotifyevent-display)
  (Window window xfixesselectionnotifyevent-window)
  (int subtype xfixesselectionnotifyevent-subtype)
  (Window owner xfixesselectionnotifyevent-owner)
  (Atom selection xfixesselectionnotifyevent-selection)
  (Time timestamp xfixesselectionnotifyevent-timestamp)
  (Time selection_timestamp xfixesselectionnotifyevent-selection_timestamp))

(define-foreign-record-type (XFixesCursorNotifyEvent XFixesCursorNotifyEvent)
  (constructor: %make-xfixescursornotifyevent)
  (destructor: %free-xfixescursornotifyevent)
  (int type xfixescursornotifyevent-type)
  (unsigned-long serial xfixescursornotifyevent-serial)
  (bool send_event xfixescursornotifyevent-send_event)
  (Display display xfixescursornotifyevent-display)
  (Window window xfixescursornotifyevent-window)
  (int subtype xfixescursornotifyevent-subtype)
  (unsigned-long cursor_serial xfixescursornotifyevent-cursor_serial)
  (Time timestamp xfixescursornotifyevent-timestamp)
  (Atom cursor_name xfixescursornotifyevent-cursor_name))


;;;
;;; Initialization functions
;;;

(define (xfixes-query-extension display)
  (let-location ((event int)
                 (error int))
    (let ((status
           ((foreign-lambda bool XFixesQueryExtension
                            Display (c-pointer int) (c-pointer int))
            display (location event) (location error))))
      (and status (list event error)))))

(define (xfixes-query-version display)
  (let-location ((major int)
                 (minor int))
    (let ((status
           ((foreign-lambda bool XFixesQueryVersion
                            Display (c-pointer int) (c-pointer int))
            display (location major) (location minor))))
      (and status (list major minor)))))

(define xfixes-version
  (foreign-lambda int XFixesVersion))


;;;
;;; Selection Notification
;;;

(define XFIXESSELECTIONNOTIFY 0)

(define XFIXESSETSELECTIONOWNERNOTIFYMASK 1)
(define XFIXESSELECTIONWINDOWDESTROYNOTIFYMASK 2)
(define XFIXESSELECTIONCLIENTCLOSENOTIFYMASK 4)

(define xfixes-select-selection-input
  (foreign-lambda void XFixesSelectSelectionInput Display Window Atom unsigned-long))

)
