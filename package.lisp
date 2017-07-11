;;;; package.lisp

(defpackage #:facet-discovery-tool
  (:use #:cl)
  (:export #:generate-instances-and-output
           #:gen-at-least
           #:eliminate-all
           #:eliminate-equations
           #:output-matrix))

