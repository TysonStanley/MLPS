#' Cross-Validation of Group LASSO
#' 
#' Performs 10-fold cross-validation for models fit with \code{grplasso}.
#' 
#' @param formula a two-sided formula for the model fit
#' @param .data the \code{data.frame} object
#' @param lambda the number(s) to test for the tuning parameter lambda. Can be a sequence but must be in reverse order.
#' @param model default is \code{LinReg()} for linear regression, other option is \code{LogReg()} for logistic regression.
#' @param ... other arguments for the \code{grplasso} function such as \code{model = LinReg()}
#' @param plot logical; when set to \code{TRUE} it prints out a ggplot2 plot of the RMSE of each lambda value supplied
#' 
#' @import stats
#' @import ggplot2
#' @import grplasso
#' 
#' @export
cv_grplasso = function(formula, .data, lambda, model=LinReg(), ..., plot=TRUE){
  modlist = rmse = classe = diff2 = list()
  nfolds = 10
  foldid = sample(seq(nfolds), length(.data[[1]]), replace = TRUE)
  .data = as.data.frame(.data)
  which1 = NULL
  for (i in seq(nfolds)) {
    which1 = (foldid == i)
    training = .data[!which1, ]
    testing  = .data[which1, ]
    modlist[[i]] = grplasso(formula, 
                            data = .data, 
                            model = model,
                            lambda = lambda)
    modfit = modlist[[i]]
    linreg = model@name == "Linear Regression Model"
    logreg = model@name == "Logistic Regression Model"
    if (linreg){
      preds = as.data.frame(predict(modfit, testing))
      diff2[[i]] = (testing[,paste(formula)[2]] - preds)^2
    } else if (logreg){
      preds = as.data.frame(predict(modfit, testing), type = "class")
      diff2[[i]] = abs(testing[,paste(formula)[2]] - preds)
    }
  }
  diffs = do.call("rbind", diff2)
  nobs  = dim(diffs)[1]
  m = 0
  if (linreg){
    for (k in lambda){
      m = m + 1
      rmse[[paste0("lambda=", k)]] = data.frame("RMSE"    = sqrt(mean(diffs[, m])),
                                                "RMSE_SE" = sqrt(var(diffs[, m]))/sqrt(nobs))
    }
  } else if (logreg){
    for (k in lambda){
      m = m + 1
      classe[[paste0("lambda=", k)]] = data.frame("ClassError" = sum(diffs[, m])/nobs)
    }
  }
  
  if (plot & linreg){
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
           x = "Lambda",
           title="RMSE of the Various Models",
           subtitle="by the value of lambda") +
      scale_x_reverse()
    
    rmse = do.call("rbind", rmse)
    return(list("Plot"=p1, "RMSE"=rmse))
    
  } else if (plot & logreg){
    vals = do.call("rbind", classe)
    vals$x = row.names(vals)
    vals$x = as.numeric(gsub("lambda=", "", vals$x))
    p1 = ggplot(vals, aes(x = x, y = RMSE, group=1)) +
      geom_line(aes(color=RMSE)) +
      theme_anteo_wh() +
      labs(y = "Classification Error",
           x = "Lambda",
           title="Classification Error of the Various Models",
           subtitle="by the value of lambda") +
      scale_x_reverse()
    
    classe = do.call("rbind", classe)
    return(list("Plot"=p1, "ClassificationError"=classe))
    
  } else {
    if (linreg){
      classe = do.call("rbind", classe)
      return(list("Plot"=paste("No plot requested"), "Classification_Error"=classe))
    } else if (logreg){
      rmse = do.call("rbind", rmse)
      return(list("Plot"=paste("No plot requested"), "RMSE"=rmse))
    }
  }
}

#' Variable Selection of Group LASSO
#' 
#' Provided a model fit with \code{grplasso::grplasso}, the function provides a plot
#' showing when each variable was selected by the value of lambda (the tuning parameter).
#' 
#' @param grplasso_obj the model object from \code{grplasso::grplasso}
#'
#' @import stats
#' @import ggplot2
#' @import tidyr
#' 
#' @export
selected_grplasso = function(grplasso_obj){
  coefs     = as.data.frame(coef(grplasso_obj))
  coefs$var = row.names(coefs)
  n_lambda  = length(grplasso_obj$lambda)
  p1        = tidyr::gather(coefs, "variable", "value", 1:n_lambda)
  p1$variable = as.numeric(gsub("X", "", p1$variable))
  
  ggplot(p1, aes(x = variable, y = value, group=var, frame=var)) +
    geom_line(aes(color = var)) +
    scale_color_discrete(guide=FALSE) +
    theme_anteo_wh() +
    labs(x="lambda",
         y="Coefficients",
         title="Variable Selection of the Group LASSO",
         subtitle="by the value of lambda") +
    scale_x_reverse()
}