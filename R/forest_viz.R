#' Visualization of the Variables of Importance
#' 
#' Visualizes--using ggplot2--the relationship of n important variables 
#' in a random forest with the outcome with a loess curve (if continuous). 
#' You can easily add more ggplot2 functions to the plot to adjust it as
#' desired. The default theme is this package's `theme_anteo`.
#' 
#' @param obj a randomForest object
#' @param n the number of important variables
#' @param imp_measure the variable importance measure
#' 
#' @import ggplot2
#' @import dplyr
#' @import tidyr
#' 
#' @export
forest_viz <- function(obj, n=10, imp_measure='default'){
  
  ## Data
  imps = obtain_important(obj, n, imp_measure)
  
  ## Reformat data
  .data_long = gather(imps, "var", "value", 1:n)

  ## Graphic
  ggplot(.data_long, aes_string(x="value", y="outcome", group="var")) +
    geom_count(aes_string(color = "var")) +
    facet_wrap(~var, scales = "free") +
    geom_smooth(color = "coral4", method="loess") +
    theme_anteo() +
    guides(color = "none") +
    labs(y = "Outcome",
         x = "")
}


#' Visualization of the Variables of Importance for cforest
#' 
#' Visualizes--using ggplot2--the relationship of n important variables 
#' in a random forest with the outcome with a loess curve (if continuous). 
#' You can easily add more ggplot2 functions to the plot to adjust it as
#' desired. The default theme is this package's `theme_anteo`.
#' 
#' @param obj a randomForest object
#' @param data the data.frame object from which the randomForest object was made
#' @param outcome the name of the outcome variable in quotes (e.g., "bmi")
#' @param n the number of important variables
#' 
#' @import ggplot2
#' @import dplyr
#' @import tidyr
#' @importFrom party varimp
#' 
#' @export
cforest_viz <- function(obj, data, outcome, n=10){
  
  ## Data
  .varimps = party::varimp(obj)
  .imps    = sort(.varimps, decreasing = FALSE)
  .nams    = names(.imps)[1:n]
  .data    = data[, .nams]
  
  .data$outcome = data[[outcome]]
  
  ## Reformat data
  .data_long = gather(.data, "var", "value", 1:n)
  
  ## Graphic
  ggplot(.data_long, aes_string(x="value", y="outcome", group="var")) +
    geom_count(aes_string(color = "var")) +
    facet_wrap(~var, scales = "free") +
    geom_smooth(color = "coral4", method="loess") +
    theme_anteo() +
    guides(color = "none") +
    labs(y = "Outcome",
         x = "")
}



#' Obtain Important Variable Information
#' 
#' Internal tool for forest_viz and forest_tab1 functions. Can be used to get data
#' from a Random Forest object.
#' 
#' @param obj a randomForest object
#' @param n the number of important variables
#' @param imp_measure the variable importance measure
#' 
#' @export
obtain_important = function(obj, n=10, imp_measure='mse'){
  ## RandomForest object
  if (any(grepl("randomForest", class(obj)))){
    .data  = eval(obj$call$data)
    .y     = obj$y
    .d_imp = data.frame(obj$importance)
    
    if(obj$type == "regression"){
      if (imp_measure=="mse"){
        .imp = .d_imp[order(.d_imp[,1], decreasing = TRUE),]
      } else {
        .imp = .d_imp[order(.d_imp[,2], decreasing = TRUE),]
      }
    } else if (obj$type == "classification"){
      .imp = .d_imp[order(.d_imp[,1], decreasing = TRUE),]
    }
    
    .nams = row.names(.imp)[1:n]
  }

  ## Error catching
  else {
    stop("obj must be of class 'randomForest' from the randomForest package")
  }
  
  ## Final Return
  d = .data[.nams]
  d$outcome = .y
  
  return(d)
}





