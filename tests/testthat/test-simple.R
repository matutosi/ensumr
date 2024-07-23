  # expected results
exp_1 <- 
  dummy_data[[1]] |>
  table() |> as.data.frame() |> `colnames<-`(c("option", "var"))
exp_1_option <- exp_1$option |> as.character()
exp_1_val  <- exp_1$var
exp_2 <- 
  dummy_data[[2]] |>
  table() |> as.data.frame() |> `colnames<-`(c("option", "var"))
exp_2_option <- exp_2$option |> as.character()
exp_2_val  <- exp_2$var
exp_3 <- 
  dummy_data[[3]] |>
  paste0(collapse = ";") |>
  stringr::str_split_1(";") |>
  table() |> as.data.frame() |> `colnames<-`(c("option", "var"))
exp_3_option <- exp_3$option |> as.character()
exp_3_val  <- exp_3$var

  # computed results by `enq_simple()`
res_1 <- 
  enq_simple(dummy_data, "q1") |>
  enq_arrange("option") |>
  `colnames<-`(c("option", "var"))
res_1_option <- res_1$option
res_1_val  <- res_1$var
res_2 <- 
  enq_simple(dummy_data, "q2_ord") |>
  enq_arrange("option") |>
  `colnames<-`(c("option", "var"))
res_2_option <- res_2$option |> as.character()
res_2_val  <- res_2$var
res_3 <- 
  enq_simple(dummy_data, "q3_multi") |>
  enq_arrange("option") |>
  `colnames<-`(c("option", "var"))
res_3_option <- res_3$option
res_3_val  <- res_3$var

  # tests
test_that("enq_simple() work", {
    expect_equal(res_1_option, exp_1_option)
    expect_equal(res_1_val , exp_1_val )
    expect_equal(res_2_option, exp_2_option)
    expect_equal(res_2_val , exp_2_val )
    expect_equal(res_3_option, exp_3_option)
    expect_equal(res_3_val , exp_3_val )
})
