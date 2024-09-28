#'
#' Archive downloaded dataset from website
#' 
#' @param path_from Path to downloaded dataset file
#' 
#' @returns Path to archived dataset file
#' 
#' @examples
#' archive_website_data(
#'   "data-raw/pandemic-pact-data.csv", "data/archived_data.csv"
#' )
#' 
#' @export
#' 

archive_website_data <- function(path_from) {
  ## Create archive directory ----
  dir.create("data/archive", showWarnings = FALSE)

  ## Construct path_to ----
  path_to <- file.path(
    "data/archive", 
    paste0(
      basename(path_from) |> tools::file_path_sans_ext(),
      "-",
      Sys.Date(),
      ".csv"
    )
  )

  ## Check if file exists ----
  if (!file.exists(path_to)) {
    ## Copy file to path_to for archiving ----
    file.copy(from = path_from, to = path_to)
  }

  ## Return path_to ----
  path_to
}