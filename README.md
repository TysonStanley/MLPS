# anteo *(Latin: prevent, go before)*

Anteo means to prevent or go before; since this package is built for prevention research it was only fitting (plus it sounds good). This package is built for use in interpreting *random forests* and *conditional inference forests* in `R`. This is built on two main aspects of interpretation: 1) visualizations and 2) tables.

## Visualizations

The main tool in understanding random forests and conditional inference forests is visualizing relationships. These functions pull the important variables and plot them against the outcome. The researcher can select how many of the most important variables to plot. It is faceted in an interpretable way so that the relationships pop and the researcher can begin exploring these relationships in more depth. 

1. `forest_viz` gives bivariate relationships between the top n important variables and the outcome with a smoother line (loess by default) to understand the linear or nonlinear relationships.

## Tables

The second aspect of exploring and communicating results from these models are tables. These functions help show the top n important variables in relation to the outcome.

1. `tab1_forests` gives stratified descriptive statistics of the n important variables and the outcome
2. `accuracies` gives the measures of accuracy in a simple table

## Additional Features

There are two `ggplot2` themes that are included in the package:

1. `theme_anteo()`: this theme is well designed for formal presentations. 
2. `theme_anteo_wh`: this theme is well designed for publication. 

They are professional and easy on the eyes. Feel free to use for presentations or publications.

