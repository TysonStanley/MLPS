#' Extracting the Selected Variables
#' 
#' Extracts the list of selected variables from \code{cv.glmnet} lasso regression.
#' Can easily be combined with the data to subset with only those variables.
#' 
#' @param ... cv.glmnet objects
#' @param s options of lambda cut off (see \code{coef.glmnet})
#' 
#' @import stats
#' 
#' @export
lasso_extract = function(..., s="lambda.1se"){
  j = 0
  .selected = list()
  for (i in list(...)){
    j = j + 1
    .s    = eval(parse(text=paste(s)), i)
    coefs = coef(i, s=.s)
    nams  = coefs@Dimnames[[1]]
    vars  = nams[coefs@i + 1]
    .selected[[j]] = vars[-1]
  }
  return(.selected)
}
