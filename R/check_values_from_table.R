#'
#' Given a tabulation table, detect NA values
#' 
#' @param tab A data.frame tabulation of values for a specific field. Usually
#'   created using `dplyr::count()` with the values in the first field/column.
#' @param pattern A search term or regular expression to look for in the values
#'   field of `tab`.
#' 
#' @returns An integer value for number of NA values in `tab`.
#' 
#' @rdname check_value
#' @export
#' 

check_value_na <- function(tab) {
  ifelse(
    any(is.na(tab[[1]]), na.rm = TRUE),
    tab[[2]][is.na(tab[[1]])],
    0L
  )
}

#'
#' @rdname check_value
#' @export
#' 

check_value_empty <- function(tab) {
  ifelse(
    any(tab[[1]] == "", na.rm = TRUE),
    tab[[2]][tab[[1]] == ""],
    0L
  )
}

#'
#' @rdname check_value
#' @export
#' 

check_value_detect <- function(tab, pattern) {
  ## Detect pattern ----
  index <- which(stringr::str_detect(tab[[1]], pattern = pattern))

  ifelse(length(index) == 0, 0L, sum(tab[[2]][index]))
}


#'
#' @rdname check_value
#' @export
#' 

check_value_combo <- function(tab) {
  tab |>
    dplyr::filter(!grouping) |>
    (\(x) x[[2]])() |>
    paste(collapse = ", ")
}