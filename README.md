
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ensumr

<!-- badges: start -->
<!-- badges: end -->

The goal of ensumr is to analyse enquate data easily.

## Installation

You can install the development version of ensumr from
[GitHub](https://github.com/) with:

``` r
  # install.packages("remotes")
remotes::install_github("matutosi/ensumr")
```

## Example

You can use dummy data.

``` r
library(ensumr)
dummy_data
#> # A tibble: 50 × 4
#>    q1    q2_ord    q3_multi    q4_comment                                       
#>    <chr> <fct>     <chr>       <chr>                                            
#>  1 u     never     "A;B;C;D;E" The odor of spring makes young hearts jump.      
#>  2 j     often     "E"         The goose was brought straight from the old mark…
#>  3 m     rarely    "B;C;D"     A young child should not suffer fright.          
#>  4 n     often     "C;D"       Mark the spot with a sign painted red.           
#>  5 x     sometimes "A;D"       Plead with the lawyer to drop the lost cause.    
#>  6 d     never     "A;B;C;D;E" The fight will end in just six minutes.          
#>  7 c     rarely    "A;B;C;D;E" The three story house was built of stone.        
#>  8 y     rarely    ""          Time brings us many changes.                     
#>  9 b     rarely    "A;B;C;D;E" Whitings are small fish caught in nets.          
#> 10 b     rarely    "A;B;D;E"   The baby puts his right foot in his mouth.       
#> # ℹ 40 more rows
```

You can show the summary of enquate by `enq_summary()`.

``` r
enq_summary(dummy_data)
#> $q1
#> # A tibble: 21 × 2
#>    q1        n
#>    <chr> <int>
#>  1 b         6
#>  2 c         4
#>  3 m         4
#>  4 n         4
#>  5 u         4
#>  6 j         3
#>  7 r         3
#>  8 s         3
#>  9 a         2
#> 10 g         2
#> # ℹ 11 more rows
#> 
#> $q2_ord
#> # A tibble: 5 × 2
#>   q2_ord        n
#>   <fct>     <int>
#> 1 always        4
#> 2 often        10
#> 3 sometimes    12
#> 4 rarely       14
#> 5 never        10
#> 
#> $q3_multi
#> # A tibble: 6 × 2
#>   q3_multi     n
#>   <chr>    <int>
#> 1 "A"         32
#> 2 "B"         24
#> 3 "D"         24
#> 4 "C"         23
#> 5 "E"         21
#> 6 ""           8
```

``` r
enq_summary(dummy_data, simplify = TRUE)
#> # A tibble: 32 × 3
#>    item  option     n
#>    <chr> <chr>  <int>
#>  1 q1    b          6
#>  2 q1    c          4
#>  3 q1    m          4
#>  4 q1    n          4
#>  5 q1    u          4
#>  6 q1    j          3
#>  7 q1    r          3
#>  8 q1    s          3
#>  9 q1    a          2
#> 10 q1    g          2
#> # ℹ 22 more rows
```

You can analyse a item by `enq_simple()`, which can be used for both
singular or multiple options. When the column name has “\_ord”, the
result will be arranged by options. Otherwise, the results will be
arranged by counted numbers. When multiple options will be separated by
deliminator (default is “;”).

``` r
enq_simple(dummy_data, "q1")
#> # A tibble: 21 × 2
#>    q1        n
#>    <chr> <int>
#>  1 b         6
#>  2 c         4
#>  3 m         4
#>  4 n         4
#>  5 u         4
#>  6 j         3
#>  7 r         3
#>  8 s         3
#>  9 a         2
#> 10 g         2
#> # ℹ 11 more rows
```

``` r
enq_simple(dummy_data, "q2_ord")
#> # A tibble: 5 × 2
#>   q2_ord        n
#>   <fct>     <int>
#> 1 always        4
#> 2 often        10
#> 3 sometimes    12
#> 4 rarely       14
#> 5 never        10
```

``` r
enq_simple(dummy_data, "q3_multi")
#> # A tibble: 6 × 2
#>   q3_multi     n
#>   <chr>    <int>
#> 1 "A"         32
#> 2 "B"         24
#> 3 "D"         24
#> 4 "C"         23
#> 5 "E"         21
#> 6 ""           8
```

You can analyse two item (cross tabulation) by `enq_cross()`.

``` r
enq_cross(dummy_data, "q1", "q2_ord")
#> # A tibble: 21 × 7
#>    q1    q2_ord_always q2_ord_often q2_ord_sometimes q2_ord_rarely q2_ord_never
#>    <chr>         <int>        <int>            <int>         <int>        <int>
#>  1 b                 0            0                1             5            0
#>  2 c                 1            1                0             1            1
#>  3 m                 0            0                1             2            1
#>  4 n                 0            3                1             0            0
#>  5 u                 0            0                1             1            2
#>  6 j                 0            1                1             1            0
#>  7 r                 1            0                0             1            1
#>  8 s                 0            1                1             1            0
#>  9 a                 0            0                1             0            1
#> 10 g                 0            1                0             0            1
#> # ℹ 11 more rows
#> # ℹ 1 more variable: total <int>
```

``` r
enq_cross(dummy_data, "q1", "q3_multi")
#> # A tibble: 21 × 8
#>    q1    q3_multi_ q3_multi_A q3_multi_B q3_multi_C q3_multi_D q3_multi_E total
#>    <chr>     <int>      <int>      <int>      <int>      <int>      <int> <int>
#>  1 b             0          6          4          3          4          4    21
#>  2 u             0          4          2          3          4          2    15
#>  3 c             1          3          3          2          2          3    14
#>  4 m             0          3          3          2          2          2    12
#>  5 g             0          2          2          1          1          2     8
#>  6 n             1          2          1          2          1          1     8
#>  7 l             0          1          1          1          2          1     6
#>  8 s             1          1          1          1          1          1     6
#>  9 t             0          1          1          1          2          1     6
#> 10 a             1          1          1          1          1          0     5
#> # ℹ 11 more rows
```

``` r
enq_cross(dummy_data, "q2_ord", "q3_multi", arrange_total = FALSE)
#> # A tibble: 5 × 8
#>   q2_ord  q3_multi_ q3_multi_A q3_multi_B q3_multi_C q3_multi_D q3_multi_E total
#>   <fct>       <int>      <int>      <int>      <int>      <int>      <int> <int>
#> 1 always          1          3          1          2          1          2    10
#> 2 often           3          3          3          5          4          4    22
#> 3 someti…         2          9          3          6          5          4    29
#> 4 rarely          2         10         10          6          7          6    41
#> 5 never           0          7          7          4          7          5    30
```

``` r
enq_cross_split(dummy_data, "q1", "q2_ord", "q3_multi")
#> [[1]]
#> # A tibble: 8 × 6
#>   q1    q2_ord_always q2_ord_often q2_ord_sometimes q2_ord_rarely total
#>   <chr>         <int>        <int>            <int>         <int> <int>
#> 1 a                 0            0                1             0     1
#> 2 c                 1            0                0             0     1
#> 3 j                 0            0                0             1     1
#> 4 n                 0            1                0             0     1
#> 5 p                 0            1                0             0     1
#> 6 q                 0            1                0             0     1
#> 7 s                 0            0                1             0     1
#> 8 y                 0            0                0             1     1
#> 
#> $A
#> # A tibble: 18 × 7
#>    q1    q2_ord_always q2_ord_often q2_ord_sometimes q2_ord_rarely q2_ord_never
#>    <chr>         <int>        <int>            <int>         <int>        <int>
#>  1 b                 0            0                1             5            0
#>  2 u                 0            0                1             1            2
#>  3 c                 0            1                0             1            1
#>  4 m                 0            0                1             1            1
#>  5 g                 0            1                0             0            1
#>  6 n                 0            1                1             0            0
#>  7 a                 0            0                0             0            1
#>  8 d                 0            0                0             0            1
#>  9 h                 1            0                0             0            0
#> 10 k                 0            0                1             0            0
#> 11 l                 0            0                1             0            0
#> 12 r                 1            0                0             0            0
#> 13 s                 0            0                0             1            0
#> 14 t                 1            0                0             0            0
#> 15 v                 0            0                0             1            0
#> 16 x                 0            0                1             0            0
#> 17 y                 0            0                1             0            0
#> 18 z                 0            0                1             0            0
#> # ℹ 1 more variable: total <int>
#> 
#> $B
#> # A tibble: 15 × 7
#>    q1    q2_ord_always q2_ord_often q2_ord_sometimes q2_ord_rarely q2_ord_never
#>    <chr>         <int>        <int>            <int>         <int>        <int>
#>  1 b                 0            0                0             4            0
#>  2 c                 0            1                0             1            1
#>  3 m                 0            0                1             1            1
#>  4 g                 0            1                0             0            1
#>  5 u                 0            0                0             1            1
#>  6 a                 0            0                0             0            1
#>  7 d                 0            0                0             0            1
#>  8 l                 0            0                1             0            0
#>  9 n                 0            1                0             0            0
#> 10 p                 0            0                0             0            1
#> 11 r                 0            0                0             1            0
#> 12 s                 0            0                0             1            0
#> 13 t                 1            0                0             0            0
#> 14 v                 0            0                0             1            0
#> 15 z                 0            0                1             0            0
#> # ℹ 1 more variable: total <int>
#> 
#> $C
#> # A tibble: 16 × 7
#>    q1    q2_ord_always q2_ord_often q2_ord_sometimes q2_ord_rarely q2_ord_never
#>    <chr>         <int>        <int>            <int>         <int>        <int>
#>  1 b                 0            0                0             3            0
#>  2 u                 0            0                1             1            1
#>  3 c                 0            1                0             1            0
#>  4 m                 0            0                1             1            0
#>  5 n                 0            2                0             0            0
#>  6 a                 0            0                0             0            1
#>  7 d                 0            0                0             0            1
#>  8 g                 0            1                0             0            0
#>  9 h                 1            0                0             0            0
#> 10 j                 0            0                1             0            0
#> 11 k                 0            0                1             0            0
#> 12 l                 0            0                1             0            0
#> 13 r                 0            0                0             0            1
#> 14 s                 0            1                0             0            0
#> 15 t                 1            0                0             0            0
#> 16 z                 0            0                1             0            0
#> # ℹ 1 more variable: total <int>
#> 
#> $D
#> # A tibble: 14 × 7
#>    q1    q2_ord_always q2_ord_often q2_ord_sometimes q2_ord_rarely q2_ord_never
#>    <chr>         <int>        <int>            <int>         <int>        <int>
#>  1 b                 0            0                0             4            0
#>  2 u                 0            0                1             1            2
#>  3 c                 0            0                0             1            1
#>  4 l                 0            0                1             0            1
#>  5 m                 0            0                1             1            0
#>  6 t                 1            1                0             0            0
#>  7 a                 0            0                0             0            1
#>  8 d                 0            0                0             0            1
#>  9 g                 0            1                0             0            0
#> 10 n                 0            1                0             0            0
#> 11 p                 0            0                0             0            1
#> 12 s                 0            1                0             0            0
#> 13 x                 0            0                1             0            0
#> 14 z                 0            0                1             0            0
#> # ℹ 1 more variable: total <int>
#> 
#> $E
#> # A tibble: 13 × 7
#>    q1    q2_ord_always q2_ord_often q2_ord_sometimes q2_ord_rarely q2_ord_never
#>    <chr>         <int>        <int>            <int>         <int>        <int>
#>  1 b                 0            0                0             4            0
#>  2 c                 0            1                0             1            1
#>  3 g                 0            1                0             0            1
#>  4 m                 0            0                1             0            1
#>  5 u                 0            0                0             1            1
#>  6 d                 0            0                0             0            1
#>  7 h                 1            0                0             0            0
#>  8 j                 0            1                0             0            0
#>  9 l                 0            0                1             0            0
#> 10 n                 0            0                1             0            0
#> 11 s                 0            1                0             0            0
#> 12 t                 1            0                0             0            0
#> 13 y                 0            0                1             0            0
#> # ℹ 1 more variable: total <int>
```

``` r
df <- dummy_data
bigram <- function(df, col = "", delim = " "){
  id <- "id"
  "word_1"
  df |>
    tibble::rownames_to_column(var = id) |>
    dplyr::select({{ id }}, contains(col)) |>
    tidyr::separate_longer_delim(contains(col), delim = delim)
}
```

## Citation

Toshikazu Matsumura (2024) ensumr. Analyse Enquate Data Easily.
<https://github.com/matutosi/ensumr/>.
