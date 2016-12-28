#' Selector of Alpha in Elastic Net
#' 
#' Reports the minimum cross-validated error at various, user specific alphas
#' for elastic net. Uses \code{cv.glmnet} from the \code{glmnet} package
#' 
#' @param x predictor matrix
#' @param y response vector
#' @param alpha a single value or a sequence of values $0 \leq \alpha \leq 1$
#' @param ... optional arguments passed to \code{cv.glmnet}
#' 
#' @import glmnet
#' 
#' @export
select_alpha = function(x, y, alpha, ...){
  .min = list()
  j = 0
  for (i in alpha){
    j = j + 1
    .fit = cv.glmnet(x, y, alpha = i, ...)
    .min[[j]] = data.frame("Min Error"=min(.fit$cvm), "alpha"=alpha[[j]])
  }
  vals = do.call("rbind", .min)
  return(vals)
}
