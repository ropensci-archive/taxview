taxview
=======

taxonomy based data explorer

## install


```r
devtools::install_github("ropensci/taxview")
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
dat_clean <- tv_clean_ids(x, ids = dat$id, db = "ncbi")
```

prepare summary


```r
(sumdat <- tv_summarise(dat_clean))
```

```
## $by_rank
## # A tibble: 21 x 3
##            rank count percent
##           <chr> <int>   <dbl>
##  1      no rank   129     100
##  2       phylum   129     100
##  3 superkingdom   129     100
##  4       family   128      99
##  5        genus   128      99
##  6        order   128      99
##  7      kingdom   127      98
##  8    subphylum   122      95
##  9      species   112      87
## 10     subclass   103      80
## # ... with 11 more rows
## 
## $by_rank_name
## # A tibble: 594 x 4
##                  name         rank count percent
##                 <chr>        <chr> <int>   <dbl>
##  1 cellular organisms      no rank   129     100
##  2          Eukaryota superkingdom   127      98
##  3        Embryophyta      no rank   119      92
##  4       Streptophyta       phylum   119      92
##  5     Streptophytina    subphylum   119      92
##  6      Viridiplantae      kingdom   119      92
##  7      Euphyllophyta      no rank   117      91
##  8       Tracheophyta      no rank   117      91
##  9      Magnoliophyta      no rank   111      86
## 10    Mesangiospermae      no rank   111      86
## # ... with 584 more rows
## 
## $by_within_rank
## $by_within_rank[[1]]
## [1] "superkingdom"
## 
## $by_within_rank[[2]]
## [1] "phylum"
## 
## $by_within_rank[[3]]
## [1] "subphylum"
## 
## $by_within_rank[[4]]
## [1] "kingdom"
## 
## $by_within_rank[[5]]
## [1] "subclass"
## 
## $by_within_rank[[6]]
## [1] "class"
## 
## $by_within_rank[[7]]
## [1] "order"
## 
## $by_within_rank[[8]]
## [1] "family"
## 
## $by_within_rank[[9]]
## [1] "subfamily"
## 
## $by_within_rank[[10]]
## [1] "suborder"
## 
## $by_within_rank[[11]]
## [1] "tribe"
## 
## $by_within_rank[[12]]
## [1] "subtribe"
## 
## $by_within_rank[[13]]
## [1] "genus"
## 
## $by_within_rank[[14]]
## [1] "superclass"
## 
## $by_within_rank[[15]]
## [1] "infraclass"
## 
## $by_within_rank[[16]]
## [1] "species"
## 
## $by_within_rank[[17]]
## [1] "superfamily"
## 
## $by_within_rank[[18]]
## [1] "infraorder"
## 
## $by_within_rank[[19]]
## [1] "superorder"
## 
## $by_within_rank[[20]]
## [1] "cohort"
## 
## $by_within_rank[[21]]
## # A tibble: 2 x 3
##        name count percent
##       <chr> <int>   <dbl>
## 1 Eukaryota   127      98
## 2  Bacteria     2       2
## 
## $by_within_rank[[22]]
## # A tibble: 7 x 3
##            name count percent
##           <chr> <int>   <dbl>
## 1  Streptophyta   119      92
## 2    Arthropoda     3       2
## 3      Chordata     2       2
## 4      Mollusca     2       2
## 5 Bacteroidetes     1       1
## 6    Ctenophora     1       1
## 7    Firmicutes     1       1
## 
## $by_within_rank[[23]]
## # A tibble: 3 x 3
##             name count percent
##            <chr> <int>   <dbl>
## 1 Streptophytina   119      98
## 2       Craniata     2       2
## 3    Chelicerata     1       1
## 
## $by_within_rank[[24]]
## # A tibble: 2 x 3
##            name count percent
##           <chr> <int>   <dbl>
## 1 Viridiplantae   119      94
## 2       Metazoa     8       6
## 
## $by_within_rank[[25]]
## # A tibble: 6 x 3
##            name count percent
##           <chr> <int>   <dbl>
## 1      asterids    41      40
## 2        rosids    33      32
## 3 Petrosaviidae    20      19
## 4  Polypodiidae     6       6
## 5     Pterygota     2       2
## 6    Dicranidae     1       1
## 
## $by_within_rank[[26]]
## # A tibble: 11 x 3
##              name count percent
##             <chr> <int>   <dbl>
##  1     Liliopsida    22      56
##  2 Polypodiopsida     6      15
##  3     Gastropoda     2       5
##  4        Insecta     2       5
##  5      Arachnida     1       3
##  6           Aves     1       3
##  7      Bryopsida     1       3
##  8     Clostridia     1       3
##  9     Cytophagia     1       3
## 10   Sphagnopsida     1       3
## 11    Tentaculata     1       3
## 
## $by_within_rank[[27]]
## # A tibble: 40 x 3
##              name count percent
##             <chr> <int>   <dbl>
##  1      Asterales    12       9
##  2        Fabales    11       9
##  3 Caryophyllales     8       6
##  4         Poales     8       6
##  5    Asparagales     7       5
##  6       Lamiales     7       5
##  7        Apiales     6       5
##  8       Ericales     5       4
##  9    Brassicales     4       3
## 10   Malpighiales     4       3
## # ... with 30 more rows
## 
## $by_within_rank[[28]]
## # A tibble: 73 x 3
##            name count percent
##           <chr> <int>   <dbl>
##  1   Asteraceae    11       9
##  2     Fabaceae    11       9
##  3     Apiaceae     5       4
##  4 Brassicaceae     4       3
##  5    Cactaceae     4       3
##  6   Cyperaceae     4       3
##  7   Solanaceae     4       3
##  8    Arecaceae     3       2
##  9    Ericaceae     3       2
## 10 Gesneriaceae     3       2
## # ... with 63 more rows
## 
## $by_within_rank[[29]]
## # A tibble: 44 x 3
##              name count percent
##             <chr> <int>   <dbl>
##  1 Papilionoideae     7       9
##  2    Asteroideae     4       5
##  3     Cactoideae     4       5
##  4    Carduoideae     4       5
##  5    Cyperoideae     4       5
##  6      Apioideae     3       4
##  7     Arecoideae     3       4
##  8  Cichorioideae     3       4
##  9     Myrtoideae     3       4
## 10    Solanoideae     3       4
## # ... with 34 more rows
## 
## $by_within_rank[[30]]
## # A tibble: 10 x 3
##                  name count percent
##                 <chr> <int>   <dbl>
##  1           Apiineae     6      32
##  2          Cactineae     5      26
##  3      Araneomorphae     1       5
##  4       Aspleniineae     1       5
##  5    Auchenorrhyncha     1       5
##  6           Ensifera     1       5
##  7       Lindsaeineae     1       5
##  8      Polypodiineae     1       5
##  9        Pteridineae     1       5
## 10 Systellommatophora     1       5
## 
## $by_within_rank[[31]]
## # A tibble: 57 x 3
##           name count percent
##          <chr> <int>   <dbl>
##  1    Cardueae     4       5
##  2 Gnaphalieae     3       4
##  3   Arabideae     2       3
##  4    Cariceae     2       3
##  5  Cichorieae     2       3
##  6  Cymbidieae     2       3
##  7    Galegeae     2       3
##  8  Gesnerieae     2       3
##  9     Myrteae     2       3
## 10  Saniculeae     2       3
## # ... with 47 more rows
## 
## $by_within_rank[[32]]
## # A tibble: 18 x 3
##               name count percent
##              <chr> <int>   <dbl>
##  1       Carduinae     2      10
##  2    Centaureinae     2      10
##  3      Attaleinae     1       5
##  4        Aveninae     1       5
##  5    Caladeniinae     1       5
##  6     Columneinae     1       5
##  7        Daucinae     1       5
##  8  Didymocarpinae     1       5
##  9     Eulophiinae     1       5
## 10       Ferulinae     1       5
## 11 Heterostemminae     1       5
## 12     Hieraciinae     1       5
## 13 Hypochaeridinae     1       5
## 14      Ligeriinae     1       5
## 15  Lychnophorinae     1       5
## 16      Oncidiinae     1       5
## 17 Psittacanthinae     1       5
## 18    Senecioninae     1       5
## 
## $by_within_rank[[33]]
## # A tibble: 124 x 3
##            name count percent
##           <chr> <int>   <dbl>
##  1        Carex     2       2
##  2      Eugenia     2       2
##  3    Saussurea     2       2
##  4      Solanum     2       2
##  5  Abrodictyum     1       1
##  6       Acacia     1       1
##  7 Acridocarpus     1       1
##  8     Adiantum     1       1
##  9     Agapetes     1       1
## 10       Aglaia     1       1
## # ... with 114 more rows
## 
## $by_within_rank[[34]]
## # A tibble: 1 x 3
##       name count percent
##      <chr> <int>   <dbl>
## 1 Hexapoda     2     100
## 
## $by_within_rank[[35]]
## # A tibble: 1 x 3
##       name count percent
##      <chr> <int>   <dbl>
## 1 Neoptera     2     100
## 
## $by_within_rank[[36]]
## # A tibble: 112 x 3
##                         name count percent
##                        <chr> <int>   <dbl>
##  1    Abrodictyum asae-grayi     1       1
##  2            Acacia jonesii     1       1
##  3  Acridocarpus spectabilis     1       1
##  4         Adiantum wilsonii     1       1
##  5           Agapetes moorei     1       1
##  6        Aglaia exstipulata     1       1
##  7          Alepidea serrata     1       1
##  8       Allium membranaceum     1       1
##  9     Allocasuarina fibrosa     1       1
## 10 Amorphophallus declinatus     1       1
## # ... with 102 more rows
## 
## $by_within_rank[[37]]
## # A tibble: 6 x 3
##             name count percent
##            <chr> <int>   <dbl>
## 1     Araneoidea     1      17
## 2    Colubroidea     1      17
## 3   Membracoidea     1      17
## 4   Polygyroidea     1      17
## 5 Rathouisioidea     1      17
## 6 Tettigonioidea     1      17
## 
## $by_within_rank[[38]]
## # A tibble: 3 x 3
##            name count percent
##           <chr> <int>   <dbl>
## 1  Cicadomorpha     1      33
## 2     Serpentes     1      33
## 3 Tettigoniidea     1      33
## 
## $by_within_rank[[39]]
## # A tibble: 2 x 3
##           name count percent
##          <chr> <int>   <dbl>
## 1 Lepidosauria     1      50
## 2   Neognathae     1      50
## 
## $by_within_rank[[40]]
## # A tibble: 2 x 3
##           name count percent
##          <chr> <int>   <dbl>
## 1 Paraneoptera     1      50
## 2 Polyneoptera     1      50
## 
## 
## attr(,"class")
## [1] "tv_summary"
```

visualize (NOT WORKING YET)


```r
tv_viz(sumdat)
```
