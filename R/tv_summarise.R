#' Summarise data with respect to taxonomy
#' 
#' @export
#' @param x (data.frame) input data
#' @return an object of class tv_summary
#' @examples
#' x <- system.file("examples/plant_spp.csv", package = "taxview")
#' dat <- tibble::as_tibble(
#'  data.table::fread(x, stringsAsFactors = FALSE, 
#'    data.table = FALSE))
#' out <- tv_clean_ids(x, ids = dat$id, db = "ncbi")
#' (res <- tv_summarise(out))
#' res$by_rank
#' res$by_rank_name
#' res$by_within_rank
tv_summarise <- function(x) {
	# must be a data.frame
	assert(x, "data.frame")
  x <- tbl_df(x)
	# by rank
  rank <- x %>% 
    group_by(rank) %>% 
    summarise(count = length(unique(query))) %>% 
    dplyr::ungroup() %>% 
    arrange(desc(count)) %>% 
    mutate(percent = round((count / length(unique(x$query))) * 100))
  # by rank name (including rank to be more useful)
  rank_name <- x %>% 
    group_by(name, rank) %>% 
    summarise(count = length(unique(query))) %>% 
    ungroup() %>% 
    arrange(desc(count)) %>% 
    mutate(percent = round((count / length(unique(x$query))) * 100))
  # comparisons within rank
  within_rank <- rank_name %>% 
    filter(rank != "no rank") %>% 
    group_by(rank) %>% 
    select(-percent) %>% 
    mutate(percent = round((count / sum(count)) * 100)) %>% 
    nest() %>% 
    unlist(recursive = FALSE) %>% 
    unname

  # compile output
  out <- list(
    by_rank = rank, 
    by_rank_name = rank_name,
    by_within_rank = within_rank
  )
	return(structure(out, class = "tv_summary"))
}
