#' Visualize data with respect to taxonomy
#'
#' @export
#' @param x An object of class `tv_summary`
#' @return opens interactive vis
#' @examples
#' x <- system.file("examples/plant_spp.csv", package = "taxview")
#' dat <- tibble::as_tibble(
#'  data.table::fread(x, stringsAsFactors = FALSE,
#'    data.table = FALSE))
#' out <- tv_clean_ids(x, ids = dat$id, db = "ncbi")
#' (res <- tv_summarise(out))
#' tv_viz(res)
tv_viz <- function(x) {
  # must be of class tv_summary
  assert(x, "tv_summary")
  stop("not working yet")
  return(x)
}
