\\name{get_rice_txdb}
\\alias{get_rice_txdb}
\\title{Retrieve the RGAP Release 7 TxDb from AnnotationHub}
\\usage{
get_rice_txdb(hub = AnnotationHub())
}
\\arguments{
  \\item{hub}{
    An \\code{AnnotationHub} object. By default, a new AnnotationHub
    instance is created. Supplying an existing object allows reuse of
    an AnnotationHub instance and its cache.
  }
}
\\value{
  A \\code{TxDb} object for \\emph{Oryza sativa} (RGAP Release 7 /
  IRGSP-1.0).
}
\\description{
  Retrieves the \\emph{Oryza sativa} transcript database hosted by
  AnnotationHub. The resource corresponds to the Rice Genome Annotation
  Project (RGAP) Release 7 / MSU7 annotation and the IRGSP-1.0 reference
  genome.
}
\\details{
  The function retrieves AnnotationHub resource \\code{AH122276}.
  AnnotationHub manages the local cache of the downloaded resource.
}
\\examples{
\\dontrun{
txdb <- get_rice_txdb()
}
}
