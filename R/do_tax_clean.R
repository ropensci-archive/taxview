db_options <- c("bold", "col", "eol", "gbif", "iucn", "natserv", "nbn", 
  "tol", "tropicos", "itis", "ncbi", "worms")

db_db_options <- "ncbi"

do_nms <- function(x, tax_names = NULL, tax_ids = NULL, db = NULL) {
  if (!is.null(tax_names)) {
    xx <- x[[tax_names]] 
    if (is.null(xx)) stop("'tax_names' field not found or empty")
    # get ID for each name
    # get classifications for each ID
  } else {
    xx <- x[[tax_ids]]
    if (is.null(xx)) stop("'tax_ids' field not found or empty")
    # get classifications for each ID
    taxizedb::classification()
  }
  
  xx_uniq <- unique(xx)
  if (!db %in% db_options) stop("'db' not in set of db options, see help")
}

do_ids <- function(x, col = NULL, ids = NULL, db = NULL) {
  # if (!db %in% db_options) stop("'db' not in set of db options, see help")
  if (!db %in% db_db_options) stop("'db' not in set of db options, see help")
  # db_db_options
  if (!is.null(col)) {
    ids <- x[[col]] 
    if (is.null(ids)) stop("'col' field not found or empty")
  }
  
  # get uniq ids
  ids_u <- unique(ids)
  # get classifications for each ID
  ## chunk by 50 per request in attemp to avoid server timeouts/etc
  rws <- seq_len(length(ids))
  chunk_size <- 50
  chks <- split(rws, ceiling(seq_along(rws) / chunk_size))
  cls <- list()
  for (i in seq_along(chks)) {
    # cls[[i]] <- taxize::classification(ids_u[chks[[i]]], db = db)
    cls[[i]] <- taxizedb::classification(ids_u[chks[[i]]], db = db)
  }
  cls <- unlist(cls, recursive = FALSE)
  cls <- Filter(is.data.frame, cls)
  tibble::as_tibble(dplyr::bind_rows(cls))
}
