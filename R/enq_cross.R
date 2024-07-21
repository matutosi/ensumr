#' @name enq_cross
#' @title Create a cross tabulation of counts for two character columns
#'
#' @description 
#' This function creates a cross tabulation of counts 
#' for two character columns in a data frame. 
#' It uses `tidyr::separate_longer_delim()` to split the columns if necessary,
#' `dplyr::count()` to count the occurrences of each combination of unique 
#' values, and `tidyr::pivot_wider()` to reshape the data into a cross 
#' tabulation. 
#' The output is arranged by the values in the col_1 by default. 
#' An optional total can be added using the `arrange_total()` argument.
#'
#' @param df   A dataframe containing the columns to be used 
#'             for the cross tabulation.
#' @param col_1,col_2,split  
#'             A string for the name of the character column to be used 
#'             in the cross tabulation.
#' @param delim  A string to be used for delimiter of values 
#'               in the column (default is ";").
#' @param arrange_total A logical value indicating whether to add a total. 
#'                      Defaults to TRUE.
#'
#' @return A data frame with the cross tabulation of counts. 
#'         The first column contains the unique values from the col_1. 
#'         The remaining columns are named based on the col_2 column values 
#'         prefixed with "col_". 
#'         Each cell contains the count of the corresponding combination of 
#'         values from col_1 and col_2. 
#'         An optional total are added if `arrange_total` is TRUE.
#'
#' @examples
#' enq_cross(dummy_data, "q1", "q2_ord")
#' enq_cross(dummy_data, "q1", "q3_multi")
#' enq_cross(dummy_data, "q2_ord", "q3_multi", arrange_total = FALSE)
#' enq_cross_split(dummy_data, "q1", "q2_ord", "q3_multi")
#'
#' @export
#'
enq_cross <- function(df, col_1, col_2, 
                      delim = ";", 
                      arrange_total = TRUE
                      ){
  cc <- chr_cols(df, c(col_1, col_2))
  if(!is.null(cc)){
    df <- tidyr::separate_longer_delim(df, cols = {{ cc }}, delim = delim)
  }
  n <- "n"
  res <- 
    df |>
    dplyr::count(dplyr::pick({{ col_1 }}, {{ col_2 }})) |>
    tidyr::pivot_wider(
      names_from = {{ col_2 }}, 
      names_prefix = paste0(col_2, "_"),
      values_from = {{ n }},
      names_sort = TRUE,
      values_fill = 0
      ) |>
    dplyr::arrange(dplyr::pick({{ col_1 }})) |>
    add_total()
  if(arrange_total == TRUE){
    res <- arrange_total(res)
  }
  return(res)
}

#' @rdname enq_cross
#'
#' @export
#'
enq_cross_split <- function(df, col_1, col_2, split = NULL, delim = ";"){
  if(is.character(df[[split]])){
    df <- tidyr::separate_longer_delim(df, cols = {{ split }}, delim = delim)
  }
  res <- 
    df |>
    split_by(split) |>
    purrr::map(enq_cross, col_1, col_2, delim)
  return(res)
}

#' @name chr_cols
#' @title Identify character columns in a data frame
#'
#' @description This function identifies which columns in a data frame are of character type.
#'
#' @param df   A dataframe to check for character columns.
#' @param cols An optional vector of column names to check. 
#' If NULL (default), all columns in the dataframe are checked.
#'
#' @return A character vector containing the names of the columns 
#' in the dataframe that are of character type.
#'
#' @examples
#' chr_cols(dummy_data)
#'
#' @export
#'
chr_cols <- function(df, cols = NULL){
  if(is.null(cols)){
    cols <- colnames(df)
  }
  is_chr <- purrr::map_lgl(df[cols], is.character)
  cols[is_chr]
}

#' @name split_by
#' @title Shortcut for `base::split()`
#'
#' @param df    A dataframe.
#' @param group A string.
#' @return      A list of split dataframe.
#' @export
#'
split_by <- function(df, group){
  grp <- df[[group]]
  split(df, grp)
}
