#' Retrieve the RGAP Release 7 TxDb from AnnotationHub
#'
#' Retrieve the `Oryza sativa` transcript database hosted by AnnotationHub.
#' The resource corresponds to the RGAP Release 7 / MSU7 annotation and the
#' IRGSP-1.0 reference genome.
#'
#' @param hub An `AnnotationHub` object. By default, a new AnnotationHub
#'   instance is created. Supplying an existing object allows reuse of an
#'   AnnotationHub instance and its cache.
#'
#' @return A `TxDb` object for `Oryza sativa` (RGAP Release 7 / IRGSP-1.0).
#'
#' @examples
#' \\dontrun{
#' txdb <- get_rice_txdb()
#' }
#'
#' @export
get_rice_txdb <- function(hub = AnnotationHub()) {
    hub[["AH122276"]]
}
