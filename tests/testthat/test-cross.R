  # expected results
mt <- 
  dummy_data |>
  dplyr::select(q2_ord, q3_multi) |>
  tidyr::separate_longer_delim(q3_multi, ";") |>
  table() |>
  as.matrix()
exp_1 <- mt[, 1] |> `names<-`(NULL)
exp_2 <- mt[, 2] |> `names<-`(NULL)
exp_3 <- mt[, 3] |> `names<-`(NULL)
exp_4 <- mt[, 4] |> `names<-`(NULL)
exp_5 <- mt[, 5] |> `names<-`(NULL)
exp_6 <- mt[, 6] |> `names<-`(NULL)

res <- 
  enq_cross(dummy_data, "q2_ord", "q3_multi") |>
  enq_arrange("option")
res_1 <- res[[2]]
res_2 <- res[[3]]
res_3 <- res[[4]]
res_4 <- res[[5]]
res_5 <- res[[6]]
res_6 <- res[[7]]

  # tests
test_that("enq_cross() work", {
    expect_equal(res_1, exp_1)
    expect_equal(res_2, exp_2)
    expect_equal(res_3, exp_3)
    expect_equal(res_4, exp_4)
    expect_equal(res_5, exp_5)
    expect_equal(res_6, exp_6)
})
