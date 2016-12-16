#' Cross-Validation of Group LASSO
#' 
#' Performs 10-fold cross-validation for models fit with \code{grplasso}.
#' 
#' @param formula a two-sided formula for the model fit
#' @param .data the \code{data.frame} object
#' @param lambda the number(s) to test for the tuning parameter $\lambda$. Can be a sequence but must be in reverse order.
#' @param ... other arguments for the \code{grplasso} function such as \code{model = LinReg()}
#' @param plot logical; when set to \code{TRUE} it prints out a ggplot2 plot of the RMSE of each lambda value supplied
#' 
#' @import stats
#' @import ggplot2
#' @import grplasso
#' 
#' @export
cv_grplasso = function(formula, .data, lambda, ..., plot=TRUE){
  modlist = rmse = list()
  diff2 = list()
  nfolds = 10
  foldid = sample(seq(nfolds), length(.data[[1]]), replace = TRUE)
  .data = as.data.frame(.data)
  which1 = NULL
  for (i in seq(nfolds)) {
    which1 = (foldid == i)
    modlist[[i]] = grplasso(formula, 
                            data = .data, 
                            ...,
                            lambda = lambda,
                            center = TRUE, 
                            standardize = TRUE,
                            subset = !which1)
    modfit = modlist[[i]]
    preds = as.data.frame(predict(modfit, d4[which1, ]))
    diff2[[i]] = (.data$del1[which1] - preds)^2
  }
  diffs = do.call("rbind", diff2)
  nobs  = dim(diffs)[1]
  m = 0
  for (k in lambda){
    m = m + 1
    rmse[[paste0("lambda=", k)]] = data.frame("RMSE"    = sqrt(mean(diffs[, m])),
                                              "RMSE_SE" = sqrt(var(diffs[, m]))/sqrt(nobs))
  }
  
  if (plot){
    vals = do.call("rbind", rmse)
    vals$x = row.names(vals)
    vals$x = as.numeric(gsub("lambda=", "", vals$x))
    p1 = ggplot(vals, aes(x = x, y = RMSE, group=1)) +
      geom_line(aes(color=RMSE)) +
      geom_pointrange(aes(ymin = RMSE - RMSE_SE, ymax = RMSE + RMSE_SE,
                          color=RMSE)) +
      theme_anteo_wh() +
      scale_color_gradient2(low = "dodgerblue4", mid = "chartreuse4", high="coral3",
                            midpoint = mean(vals$RMSE, na.rm=TRUE), guide=FALSE) +
      geom_hline(data=vals[which(vals$RMSE == min(vals$RMSE)),], aes(yintercept = RMSE + RMSE_SE), 
                 color = "dodgerblue4") +
      labs(y = "Root Mean Squared Error (RMSE)",
           x = "Lambda") +
      scale_x_reverse()
    
    rmse = do.call("rbind", rmse)
    return(list("Plot"=p1, "RMSE"=rmse))
  } else {
    rmse = do.call("rbind", rmse)
    return(list("Plot"=paste("No plot requested"), "RMSE"=rmse))
  }
}
