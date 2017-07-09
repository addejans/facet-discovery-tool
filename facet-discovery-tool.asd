;;;; facet-discovery-tool.asd

(asdf:defsystem #:facet-discovery-tool
  :description "An automated tool to find facets of global constraint."
  :author "Serge Kruk <sgkruk@gmail.com> and Jason Medcoff <jemedcoff@oakland.edu>"
  :license "LGPL"
  :serial t
  :components ((:file "package")
               (:file "facet-discovery-tool")
	       (:file "generator")))

