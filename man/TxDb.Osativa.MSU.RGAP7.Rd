\name{TxDb.Osativa.MSU.RGAP7}
\docType{package}

\alias{TxDb.Osativa.MSU.RGAP7-package}
\alias{TxDb.Osativa.MSU.RGAP7}

\title{Transcript annotation database for rice}

\description{
  This package provides access to a TxDb object for \emph{Oryza sativa}
  based on the Rice Genome Annotation Project (RGAP) Release 7
  annotation (MSU7). The TxDb object provides transcript, exon, CDS and
  gene ranges for the IRGSP-1.0 / MSU7 genome assembly.

  The TxDb object itself is not shipped with the package: it is hosted
  on AnnotationHub and retrieved at runtime using the AnnotationHub
  package. The package additionally provides \code{\link{msu_to_rap}}
  for converting MSU locus identifiers to RAP-DB identifiers.
}

\note{
  This data resource was built from the RGAP Release 7 GFF3 annotation
  (MSU7, IRGSP-1.0).
}

\author{
  Dwijesh Chandra Mishra (aut),
  Sharanbasappa D Madival (aut),
  Kabilan S (aut, cre) \email{kabilan151414@gmail.com}
}

\seealso{
  \link[GenomicFeatures]{transcripts},
  \link[GenomicFeatures]{transcriptsBy},
  \code{\link{msu_to_rap}}
}

\examples{
## Retrieve the TxDb from AnnotationHub (requires network access):
## ah <- AnnotationHub::AnnotationHub()
## txdb <- ah[["AH122276"]]
## GenomicFeatures::genes(txdb)
}

\keyword{package}
\keyword{data}
