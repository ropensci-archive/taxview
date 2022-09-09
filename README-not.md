taxview
=======



[![Project Status: Suspended – Initial development has started, but there has not yet been a stable, usable release; work has been stopped for the time being but the author(s) intend on resuming work.](https://www.repostatus.org/badges/latest/suspended.svg)](https://www.repostatus.org/#suspended)
[![R-check](https://github.com/ropensci/taxview/workflows/R-check/badge.svg)](https://github.com/ropensci/taxview/actions)

Summarise and visualize data sets taxonomically

The proposed workflow with `taxview`:

- input:
  - data.frame with data, indicate which column has names or ids
  - vector/list of names or ids (not associated with data)
- gather taxonomic classification data for each taxon
- from previously collected data, compute summary statistics/etc.
- visualize data among taxonomic groups, etc.

## install


```r
remotes::install_github("ropensci/taxview")
```


```r
library(taxview)
```

## use

get some data


```r
x <- system.file("examples/plant_spp.csv", package = "taxview")
```

prepare data: clean, etc.


```r
dat <- tibble::as_tibble(
 data.table::fread(x, stringsAsFactors = FALSE, 
   data.table = FALSE))
out <- tv_prep_ids(x, ids = dat$id, db = "ncbi")
```

Prepare summary. The output of `tv_summarise()` is an S3 class, with a summary of the groupings.


```r
res <- tv_summarise(out)
res
#> <tv_summary>
#>  no. taxa: 602
#>  by rank: N (22)
#>  by rank name: N (602)
#>  within ranks: N (21)
```

The `$summary` slot has the number of taxa in the dataset


```r
res$summary
#> $spp
#> [1] 602
```

The `$by_rank` slot has the breakdown of taxa within each rank category, as a count and percentage.


```r
res$by_rank
#> # A tibble: 22 x 3
#>    rank      count percent
#>    <chr>     <int>   <dbl>
#>  1 genus       124      21
#>  2 species     112      19
#>  3 family       73      12
#>  4 clade        72      12
#>  5 tribe        58      10
#>  6 subfamily    45       7
#>  7 order        41       7
#>  8 subtribe     18       3
#>  9 class        12       2
#> 10 suborder      9       1
#> # … with 12 more rows
```

The `$by_rank_name` slot has the breakdown of taxa ...


```r
res$by_rank_name
#> # A tibble: 602 x 4
#>    name                     rank      count percent
#>    <chr>                    <chr>     <int>   <dbl>
#>  1 50 kb inversion clade    clade         1       0
#>  2 Abrodictyum              genus         1       0
#>  3 Abrodictyum asae-grayi   species       1       0
#>  4 Acacia                   genus         1       0
#>  5 Acacia jonesii           species       1       0
#>  6 Acacieae                 tribe         1       0
#>  7 Acalypheae               tribe         1       0
#>  8 Acalyphoideae            subfamily     1       0
#>  9 Acridocarpus             genus         1       0
#> 10 Acridocarpus spectabilis species       1       0
#> # … with 592 more rows
```

The `$by_within_rank` slot has the breakdown of number of records within each taxon within each rank grouping.


```r
res$by_within_rank[1:2]
#> $clade
#> # A tibble: 72 x 3
#>    name                         count percent
#>    <chr>                        <int>   <dbl>
#>  1 50 kb inversion clade            1       1
#>  2 Amniota                          1       1
#>  3 apioid superclade                1       1
#>  4 Archelosauria                    1       1
#>  5 Archosauria                      1       1
#>  6 asterids                         1       1
#>  7 Bacteroidetes/Chlorobi group     1       1
#>  8 Bifurcata                        1       1
#>  9 Bilateria                        1       1
#> 10 BOP clade                        1       1
#> # … with 62 more rows
#> 
#> $genus
#> # A tibble: 124 x 3
#>    name          count percent
#>    <chr>         <int>   <dbl>
#>  1 Abrodictyum       1       1
#>  2 Acacia            1       1
#>  3 Acridocarpus      1       1
#>  4 Adiantum          1       1
#>  5 Agapetes          1       1
#>  6 Aglaia            1       1
#>  7 Aiouea            1       1
#>  8 Alepidea          1       1
#>  9 Allium            1       1
#> 10 Allocasuarina     1       1
#> # … with 114 more rows
```

visualize (NOT WORKING YET)


```r
tv_viz(res)
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/taxview/issues).
* License: MIT
* Get citation information for `taxview` in R doing `citation(package = 'taxview')`
* Please note that this package is released with a [Contributor Code of Conduct](https://ropensci.org/code-of-conduct/). By contributing to this project, you agree to abide by its terms.
