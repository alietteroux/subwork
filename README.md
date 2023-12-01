
<!-- README.md is generated from README.Rmd. Please edit that file -->

# subwork

Le package permet d’importer, par de simples lignes de commande, les
fichiers diffusés par le projet de recherche Subwork. Les fichiers et la
documentation associée sont déposés sur Nakala :
<https://nakala.fr/10.34847/nkl.c8caljc9>.

## Installation

``` r
# install.packages("devtools")
devtools::install_github("alietteroux/subwork")
```

## Exemples

``` r
library(subwork)
# importer les données "FD11" dans un dataframe nommé "FD11.data"
FD11.data <- import(code="FD11",type="data")
# importer les intitulés des variables du fichier "FD11" dans un dataframe nommé "FD11.libvar"
FD11.libvar <- import(code="FD11",type="libvar")
# importer le fichier géographique "SH51" dans un objet sf nommé "SH51"
SH51 <- import(code="SH51",type="geo")
```

A noter : l’import de certains fichiers (comme par exemple *SH81*) peut
prendre plusieurs secondes voire une ou deux minutes…
