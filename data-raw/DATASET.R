## code to prepare `dummy_data` dataset goes here
set.seed(6)
n <- 50
dummy_data <-
  tibble::tibble(
    q1 = sample(letters, n, replace = TRUE),
    q2_ord = sample(fct_inorder(c("always", "often", "sometimes", "rarely", "never")), n, replace = TRUE),
    q3_multi = purrr::map_chr(seq(n), 
                 \(x){
                   sample(LETTERS[1:5], sample(0:5, 1), prob =  log10(6:2)) |> 
                   sort() |> 
                   paste0(collapse = ";")
                 }
               ), 
    q4_comment = sample(sentences, n)
    )

usethis::use_data(dummy_data, overwrite = TRUE)
