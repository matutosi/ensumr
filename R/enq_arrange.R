#' @name enq_arrange
#' @title Arrange a data frame based on count, option, or total
#'
#' @description This function arranges a data frame 
#' by count, option, or total, depending on the specified key. 
#' It uses `dplyr::arrange()` for arranging the data. 
#' The default arrangement is by descending count ("n").
#'
#' @param df  A dataframe to be arranged.
#' @param key A character vector specifying the arrangement key. 
#' Possible values include:
#'   * "n": arrange by descending count ("n").
#'   * "option": arrange by the first column (assumed to be option).
#'   * "total": arrange by a total column (assumed to "total") in descending order 
#'     (requires the data frame to already have a "total" column).
#'   * "default": arrange by descending count ("n") if the first column name does not 
#'     contain "_ord", otherwise arrange by the first column.
#'
#' @return A dataframe.
#'
#' @examples
#' enq_simple(dummy_data, "q1") |>
#'   print() |>
#'   enq_arrange(key = "option")
#' enq_simple(dummy_data, "q2_ord") |>
#'   print() |>
#'   enq_arrange(key = "n")
#' enq_cross(dummy_data, "q1", "q3_multi") |>
#'   print() |>
#'   enq_arrange(key = "total")
#'
#' @export
enq_arrange <- function(df,
                        key = c("n", "option", "total", "default")){
  cn <- colnames(df)[1]
  res <- 
    switch(
      key,
      n       = dplyr::arrange(df, dplyr::desc(dplyr::pick("n"))),
      option  = dplyr::arrange(df, dplyr::pick({{ cn }})),
      total   = df |>
                  add_total() |>
                  dplyr::arrange(dplyr::desc(dplyr::pick("total"))),
      default = if(stringr::str_detect(cn, "_ord$")){
                    dplyr::arrange(df, dplyr::pick({{ cn }}))
                  }else{
                    dplyr::arrange(df, dplyr::desc(dplyr::pick("n")))
                  }
    )
  return(res)
}

#' @rdname enq_arrange
#'
#' @export
arrange_total <- function(df){
  dplyr::arrange(df, dplyr::desc(dplyr::pick("total")))
}

#' @rdname enq_arrange
#'
#' @export
add_total <- function(df){
  cn <- colnames(df)[-1]
  has_total <- "total" %in% cn
  if(has_total) return(df)
  total <- 
    df |>
    dplyr::select(tidyselect::all_of(cn)) |>
    apply(1, sum, na.rm = TRUE) |>
    tibble::tibble(total = _)
  dplyr::bind_cols(df, total)
}
