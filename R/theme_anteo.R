#' ggplot2 anteo theme
#' 
#' A clean ggplot2 theme designed for prresentations, websites, and reports. For more 
#' information on ggplot2 themes, see the documentation for ggplot2.
#' 
#' @param base_size default 12
#' @param base_family default Helvetica
#' 
#' @import ggplot2
#' 
#' @export
theme_anteo <- function(base_size = 12, base_family = "Helvetica"){
  theme_bw(base_size = base_size, base_family = base_family) +
  theme(legend.key=element_rect(color="grey99"),
        legend.box.background=element_rect(color="grey99"),
        legend.background=element_rect(color="grey99"),
        panel.border=element_rect(color="grey99", size=.1),
        axis.ticks.y=element_line(color="lightgrey"),
        axis.ticks.x=element_line(color="lightgrey"),
        strip.background=element_rect(fill="grey99", color="grey99"),
        strip.text=element_text(face="bold"),
        axis.line.x=element_line(color="grey50"),
        axis.line.y=element_line(color="grey50"),
        panel.spacing = unit(0, "lines"),
        panel.background=element_rect(fill="grey99"),
        plot.background=element_rect(fill="grey99"))
}



#' ggplot2 anteo-white theme
#' 
#' A clean ggplot2 theme designed for prresentations, websites, and reports similar to
#' theme_anteo() but with a white background for better printing. For more 
#' information on ggplot2 themes, see the documentation for ggplot2.
#' 
#' @param base_size default 12
#' @param base_family default Helvetica
#' 
#' @import ggplot2
#' 
#' @export
theme_anteo_wh <- function(base_size = 12, base_family = "Helvetica"){
  theme_anteo(base_size = base_size, base_family = base_family) +
  theme(legend.key=element_rect(color="white"),
        panel.border=element_blank(),
        axis.ticks.y=element_line(color="grey50"),
        axis.ticks.x=element_line(color="grey50"),
        strip.background=element_rect(fill="white", color="white"),
        strip.text=element_text(face="bold"),
        axis.line.x=element_line(color="grey50"),
        axis.line.y=element_line(color="grey50"),
        panel.spacing = unit(0, "lines"),
        panel.background=element_rect(fill="grey99"),
        plot.background=element_rect(fill="white"))
}

