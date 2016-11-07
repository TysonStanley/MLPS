#' anteo
#' 
#' The anteo package offers tools that work with random forest objects (from the 
#' \code{randomForest} package and conditional inference forest objects (from the 
#' \code{party} package. 
#' \itemize{
#'   \item \code{forest_viz} a simple visualization tool for looking at the relationships
#'          of the n most imporant variables and the outcome (for \code{randomForest})
#'   \item \code{cforest_viz} a simple visualization tool for looking at the relationships
#'          of the n most imporant variables and the outcome (for \code{cforest})
#' }
#' 
#' There are also two simple \code{ggplot2} themes:
#' \itemize{
#'   \item \code{theme_anteo} 
#'   \item \code{theme_anteo_wh} 
#' }
#' 
#' Overall, the package helps with the exploration of large data sets.
#' 
#' Note: anteo means to prevent or go before in latin.
#' 
#' @examples
#' \dontrun{
#' 
#' library(anteo)
#' 
#' ## Random Forest
#' fit = randomForest(outcome ~ ., data=data)
#' forest_viz(fit)
#' 
#' ## Conditional Inference Forest
#' fit2 = cforest(outcome ~ ., data=data)
#' cforest_viz(fit2, data = data, outcome = "outcome")
#' 
#' }
#' 
#' @docType package
#' @name anteo
NULL