#' Summarise data with respect to taxonomy
#' 
#' @export
#' @param x (data.frame) input data
#' @return an object of class tv_summary
#' @examples \dontrun{
#' x <- system.file("examples/plant_spp.csv", package = "taxview")
#' dat <- tibble::as_tibble(
#'  data.table::fread(x, stringsAsFactors = FALSE, 
#'    data.table = FALSE))
#' out <- tv_clean_ids(x, ids = dat$id, db = "ncbi")
#' (res <- tv_summarise(out))
#' res$summary
#' res$by_rank
#' res$by_rank_name
#' res$by_within_rank
#' }
tv_summarise <- function(x) {
	# must be a data.frame
	assert(x, c("data.frame", "tbl_df"))
  x <- as_tibble(x)
  # summary data
  sumdat <- length(unique(x$name))
	# by rank
  rank <- x %>% 
    group_by(rank) %>% 
    summarise(count = length(unique(name))) %>% 
    dplyr::ungroup() %>% 
    arrange(desc(count)) %>% 
    mutate(percent = round((count / length(unique(x$name))) * 100))
  # by rank name (including rank to be more useful)
  rank_name <- x %>% 
    group_by(name, rank) %>% 
    summarise(count = length(unique(name))) %>% 
    ungroup() %>% 
    arrange(desc(count)) %>% 
    mutate(percent = round((count / length(unique(x$name))) * 100))
  # comparisons within rank
  within_rank <- rank_name %>% 
    filter(rank != "no rank") %>% 
    group_by(rank) %>% 
    select(-percent) %>% 
    mutate(percent = round((count / sum(count)) * 100)) %>% 
    tidyr::nest()
  within_rank <- stats::setNames(within_rank$data, within_rank$rank)

  # compile output
  out <- list(
    summary = list(spp = sumdat),
    by_rank = rank, 
    by_rank_name = rank_name,
    by_within_rank = within_rank
  )
	return(structure(out, class = "tv_summary"))
}

#' @export
print.tv_summary <- function(x, ...) {
  cat("<tv_summary>", sep = "\n")
  cat(sprintf(" no. taxa: %s", x$summary$spp), sep = "\n")
  cat(sprintf(" by rank: N (%s)", NROW(x$by_rank)), sep = "\n")
  cat(sprintf(" by rank name: N (%s)", NROW(x$by_rank_name)), sep = "\n")
  cat(sprintf(" within ranks: N (%s)", length(x$by_within_rank)), sep = "\n")
}

utils::globalVariables(c("query", "name", "percent", "count", "rank"))
