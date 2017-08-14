;;;; facet-discovery-tool.asd

(asdf:defsystem #:facet-discovery-tool
  :description "An automated tool to find facets of global constraint."
  :author "Serge Kruk <sgkruk@gmail.com> and Jason Medcoff <jemedcoff@oakland.edu>"
  :license "LGPL"
  :serial t
  :components ((:file "package")
               (:file "finite-set")
               (:file "data-structure")
               (:file "facet-discovery-tool")
	       (:file "generator")
               (:file "projector")
               ))

