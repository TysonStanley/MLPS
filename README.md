### Developmental Version

[![GitHub version](https://badge.fury.io/gh/tysonstanley%2Fanteo.svg)](https://badge.fury.io/gh/tysonstanley%2Fanteo)
[![Build Status](https://travis-ci.org/TysonStanley/anteo.svg?branch=master)](https://travis-ci.org/TysonStanley/anteo)

# anteo *(Latin: prevent, go before)*

Anteo means to prevent or go before; since this package is built for prevention research it was only fitting (plus it sounds good). This package is built for use in interpreting *random forests* and *conditional inference forests* in `R`. This is built on easy visualizations of bivariate relationships. 



## Visualizations

The main tool in understanding random forests and conditional inference forests is visualizing relationships. These functions pull the important variables and plot them against the outcome. The researcher can select how many of the most important variables to plot. It is faceted in an interpretable way so that the relationships pop and the researcher can begin exploring these relationships in more depth. 

1. `forest_viz` gives bivariate relationships between the top n important variables and the outcome with a smoother line (loess by default) to understand the linear or nonlinear relationships (for randomForest objects).
2. `cforest_viz` gives bivariate relationships between the top n important variables and the outcome with a smoother line (loess by default) to understand the linear or nonlinear relationships (for conditional inference forest objects).

In addition, data from a randomForest object containing only the n most important variables can be extracted via:

* `obtain_important` provides the subsetted data of n most important variables from the random forest.

## Additional Features

There are two `ggplot2` themes that are included in the package:

1. `theme_anteo()`: this theme is well designed for formal presentations. 
2. `theme_anteo_wh`: this theme is well designed for publication. 

They are professional and easy on the eyes. Feel free to use for presentations or publications.

