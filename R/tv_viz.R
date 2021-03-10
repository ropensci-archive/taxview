#' Visualize data with respect to taxonomy
#'
#' @export
#' @param x An object of class `tv_summary`
#' @return opens interactive vis
#' @examples \dontrun{
#' x <- system.file("examples/plant_spp.csv", package = "taxview")
#' dat <- tibble::as_tibble(
#'  data.table::fread(x, stringsAsFactors = FALSE,
#'    data.table = FALSE))
#' out <- tv_prep_ids(x, ids = dat$id, db = "ncbi")
#' (res <- tv_summarise(out))
#' tv_viz(res)
#' }
tv_viz <- function(x) {
  # must be of class tv_summary
  assert(x, "tv_summary")
  stop("not working yet")
  return(x)
}

# x = parse_tax_data(hmp_otus, class_cols = "lineage", class_sep = ";",
#                         class_key = c(tax_rank = "taxon_rank", tax_name = "taxon_name"),
#                         class_regex = "^(.+)__(.+)$")
# heat_tree(x)

