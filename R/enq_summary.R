#' @name enq_summary
#' @title Create summaries for multiple character columns in a data frame
#'
#' @description This function creates summaries for 
#'              multiple character columns in a data frame. 
#'              It uses `enq_simple` to calculate the occurrences of 
#'               split values for each column.
#'
#' @inheritParams enq_simple
#' @param cols_except A regular expression pattern to exclude columns from the summary. 
#'                    Columns that do not match the pattern will be included. 
#'                    Defaults to "_comment$".
#' @param simplify    A logical. If TRUE, bind elements of a list (default is FALSE).
#'
#' @return A list of dataframe. 
#'         Names of the list elements are the same as the column names.
#'
#' @examples
#' enq_summary(dummy_data)
#' enq_summary(dummy_data, simplify = TRUE)
#'
#' @export
enq_summary <- function(df, 
                        cols_except = "_comment$", 
                        delim = ";",
                        simplify = FALSE
                        ){
  cols <- 
    colnames(df) |>
    stringr::str_subset(cols_except, negate = TRUE)
  res <- 
    cols |>
    purrr::map(\(x){
      enq_simple(df, x, delim = delim)
    })
  names(res) <- cols
  if(simplify){
    res <- enq_summary_bind(res)
  }
  return(res)
}

#' @rdname enq_summary
#' 
#' @export
enq_summary_bind <- function(df){
  item <- "item"
  res <- 
    df |>
    purrr::map(`colnames<-`, c("option", "n")) |>
    purrr::imap(\(.x, .y){
      dplyr::mutate(.x, `:=`({{ item }}, .y), .before = 1)
    }) |>
    dplyr::bind_rows()
  return(res)
}
