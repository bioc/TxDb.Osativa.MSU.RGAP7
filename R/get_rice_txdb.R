#' Retrieve the RGAP Release 7 TxDb from AnnotationHub
#'
#' Retrieve the \\emph{Oryza sativa} transcript database hosted by AnnotationHub.
#' The resource corresponds to the RGAP Release 7 / MSU7 annotation and the
#' IRGSP-1.0 reference genome.
#'
#' @importClassesFrom GenomicFeatures TxDb
#' @importFrom AnnotationHub AnnotationHub
#' @param hub An \\code{AnnotationHub} object. By default, a new AnnotationHub
#'   instance is created. Supplying an existing object allows reuse of an
#'   AnnotationHub instance and its cache.
#'
#' @return A \\code{TxDb} object for \\emph{Oryza sativa} (RGAP Release 7 / IRGSP-1.0).
#'
#' @examples
#' formals(get_rice_txdb)
#'
#' # To retrieve the resource from AnnotationHub (requires network access):
#' # txdb <- get_rice_txdb()
#'
#' @export
get_rice_txdb <- function(hub = AnnotationHub()) {
    hub[["AH122276"]]
}
