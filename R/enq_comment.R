
  # 
  # remotes::install_github("matutosi/moranajp", ref = "develop", upgrade = "never")
  # library(moranajp)
  # 
enq_comment_bigram <- function(df){
  stop_words <- stringi::stri_unescape_unicode(c("\\uff22\\uff30", "\\uff2a\\uff30"))
  #   stringi::stri_unescape_unicode(stop_words)
  cn_comment <- 
    df |>
      colnames() |>
      stringr::str_subset("_comment")
  chamame_res <- 
    cn_comment |>
    purrr::map(\(x){
      dplyr::select(df, {{ x }}) |>
      stats::na.omit() |>
      dplyr::filter(!stringr::str_detect({{ x }}, "^0$")) |>
      moranajp::moranajp_all(method = "chamame", text_col = x)
    })
  bigram <- 
    chamame_res |>
      purrr::map(\(x){
        x |>
          moranajp::add_sentence_no() |>
          moranajp::clean_up(
            use_common_data = TRUE,
            add_stop_words = stop_words) |>
          moranajp::draw_bigram_network()
      })
  return(bigram)
}
