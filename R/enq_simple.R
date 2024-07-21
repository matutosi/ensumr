#' @name enq_simple
#' @title Count occurrences of values in a column
#'
#' @description 
#' This function splits values in a character column by a delimiter 
#' and then counts the occurrences of each unique value. 
#' It uses `tidyr::separate_longer_delim()` to split the column and 
#' `dplyr::count()` to count the occurrences. The order of the output 
#' is determined by the presence of "_ord" in the column name. 
#' If "_ord" is present, the output is arranged by "option", 
#' otherwise it is arranged by "n" (number of occurrences).
#'
#' @param df    A dataframe containing the column to be counted.
#' @param col   A string for column to be count.
#' @param delim A string to be used for delimiter of values 
#'              in the column (default is ";").
#' @return A dataframe with two columns: 
#'         "option" (the unique values after splitting) and "n" 
#'         (the number of occurrences of each unique value).
#'
#' @examples
#' enq_simple(dummy_data, "q1")
#' enq_simple(dummy_data, "q2_ord")
#' enq_simple(dummy_data, "q3_multi")
#' 
#' @export
#' 
enq_simple <- function(df, col, 
                       delim = ";"
                       ){
  if(is.character(df[[col]])){
    df <- tidyr::separate_longer_delim(df, cols = {{ col }},delim = delim)
  }
  res <- dplyr::count(df, dplyr::pick({{ col }}))
  is_ord <- stringr::str_detect(colnames(df[col]), "_ord")
  if(is_ord){
    res <- enq_arrange(res, key = "option")
  }else{
    res <- enq_arrange(res, key = "n")
  }
  return(res)
}
