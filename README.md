taxview
=======



[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)
[![Build Status](https://travis-ci.org/ropensci/taxview.svg?branch=master)](https://travis-ci.org/ropensci/taxview)

Summarise and visualize data sets taxonomically

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
out <- tv_clean_ids(x, ids = dat$id, db = "ncbi")
```

prepare summary


```r
res <- tv_summarise(out)
res
#> <tv_summary>
#>  no. taxa: 602
#>  by rank: N (22)
#>  by rank name: N (602)
#>  within ranks: N (21)
```

visualize (NOT WORKING YET)


```r
tv_viz(res)
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/taxview/issues).
* License: MIT
* Get citation information for `taxview` in R doing `citation(package = 'taxview')`
* Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md).
By participating in this project you agree to abide by its terms.
