#' Clean data
#' 
#' @name tv_clean
#' @param x (data.frame) input data
#' @param tax_names (character) column name holding taxonomic names 
#' to use
#' @param tax_ids (character) column name holding taxonomic IDs
#' to use. if given, `db` is required
#' @param db (character) database IDs from. see below for options
#' @return an object of class data.frame
#' @section db options:
#' 
#' - `bold`: Barcode of Life
#' - `col`: Catalogue of Life
#' - `eol`: Encyclopedia of Life
#' - `gbif`: Global Biodiversity Information Facility
#' - `iucn`: International Union for Conservation of Nature Red List
#' - `natserv`: Nature Serve
#' - `nbn`: National Biodiversity Network (UK)
#' - `tol`: Tree of Life
#' - `tropicos`: Tropicos
#' - `itis`: Integrated Taxonomic Information Service
#' - `ncbi`: National Center for Biotechnology Information
#' - `worms`: World Register of Marine Species
#' 
#' @examples \dontrun{
#' x <- system.file("examples/plant_spp.csv", package = "taxview")
#' 
#' # assuming you only have taxonomic names
#' # tv_clean_names(x, names = "name")
#' 
#' # if you have taxonomic IDs (from set of allowed databases, see above)
#' ## if a column name
#' # tv_clean_ids(x, ids = "id", db = "eol")
#' ## if a vector of IDs
#' dat <- tibble::as_tibble(
#'  data.table::fread(x, stringsAsFactors = FALSE, 
#'    data.table = FALSE))
#' out <- tv_clean_ids(x, ids = dat$id, db = "ncbi")
#' head(out)
#' }

#' @export
#' @rdname tv_clean
tv_clean_names <- function(x, col = NULL, names = NULL, db = NULL) {
  UseMethod('tv_clean_names')
}

#' @export
tv_clean_names.default <- function(x, col = NULL, names = NULL, db = NULL) {
  stop("No 'tv_clean_names' for class ", class(x)[1L])
}

#' @export
tv_clean_names.character <- function(x, col = NULL, names = NULL, db = NULL) {
  stop("not working yet")
  # file must exist
  stopifnot(file.exists(x))
  stopifnot(xor(!is.null(col), !is.null(names)))
  # read in data
  dat <- tibble::as_tibble(
    data.table::fread(x, stringsAsFactors = FALSE, 
      data.table = FALSE)
  )
  do_nms(dat, col, names, db)
}

#' @export
tv_clean_names.data.frame <- function(x, col = NULL, names = NULL, db = NULL) {
  stop("not working yet")
  stopifnot(xor(!is.null(names), !is.null(col)))
  if (any())
  do_nms(x, col, names, db)
}



#' @export
#' @rdname tv_clean
tv_clean_ids <- function(x, col = NULL, ids = NULL, db = NULL) {
  UseMethod('tv_clean_ids')
}

#' @export
tv_clean_ids.default <- function(x, col = NULL, ids = NULL, db = NULL) {
  stop("No 'tv_clean_ids' for class ", class(x)[1L])
}

#' @export
tv_clean_ids.character <- function(x, col = NULL, ids = NULL, db = NULL) {
  # file must exist
  stopifnot(file.exists(x))
  stopifnot(xor(!is.null(col), !is.null(ids)))
  # read in data
  dat <- tibble::as_tibble(
    data.table::fread(x, stringsAsFactors = FALSE, 
      data.table = FALSE)
  )
  do_ids(dat, col, ids, db)
}

#' @export
tv_clean_ids.data.frame <- function(x, col = NULL, ids = NULL, db = NULL) {
  stopifnot(xor(!is.null(col), !is.null(ids)))
  do_ids(x, col, ids, db)
}



# helpers ------------------
extract_em <- function (string, pattern) {
  regmatches(string, gregexpr(pattern, string))
}
