#' Extracting the Selected Variables
#' 
#' Extracts the list of selected variables from \code{cv.glmnet} lasso regression.
#' Can easily be combined with the data to subset with only those variables.
#' 
#' @param ... cv.glmnet objects
#' @param s options of lambda cut off (see \code{coef.glmnet})
#' @param data default is NULL; if specified it returns the variables as part of a data.frame
#' 
#' @import stats
#' 
#' @export
lasso_extract = function(..., s="lambda.1se", .data=NULL){
  j = 0
  .selected = list()
  for (i in list(...)){
    j = j + 1
    .s    = eval(parse(text=paste(s)), i)
    coefs = stats::coef(i, s=.s)
    nams  = coefs@Dimnames[[1]]
    vars  = nams[coefs@i + 1]
    .selected[[j]] = vars[-1]
  }
  
  if (is.null(.data)){
    return(.selected)
    
  } else {
    vars2 = .d = list()
    for (l in 1:length(.selected)){
      for (k in seq_along(.data)){
        vars2[[k]] = grepl(names(.data)[k], .selected[[l]])
      }
      indexed = rowSums(as.data.frame(vars2))
      .d[[l]] = .data[, indexed]
    }
    return(.d)
  }
}
