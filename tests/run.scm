
(import chicken scheme)

(use test
     xlib
     xfixes)

(define *display* (xopendisplay #f))

(assert *display* "XOpenDisplay failed. Cannot procede with tests.")

(test "xfixes-query-extension"
      #t
      (pair? (xfixes-query-extension *display*)))

(test "xfixes-query-version"
      #t
      (pair? (xfixes-query-version *display*)))




(test-exit)
