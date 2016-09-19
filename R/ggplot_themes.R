
## ggplot2 theme original
theme_furniture <- theme_bw()
theme_furniture <- theme_update(legend.key=element_rect(color="white"),
                                panel.border=element_rect(color="grey99", size=.1),
                                axis.ticks.y=element_line(color="lightgrey"),
                                axis.ticks.x=element_line(color="lightgrey"),
                                strip.background=element_rect(fill="grey99", color="grey99"),
                                strip.text=element_text(face="bold"),
                                axis.line.x=element_line(color="grey70"),
                                axis.line.y=element_line(color="grey70"),
                                panel.margin = unit(0, "lines"),
                                panel.background=element_rect(fill="grey99"),
                                plot.background=element_rect(fill="grey99"))

## ggplot2 theme white
theme_furniture_white <- theme_bw()
theme_furniture_white <- theme_update(legend.key=element_rect(color="white"),
                                panel.border=element_blank(),
                                axis.ticks.y=element_line(color="lightgrey"),
                                axis.ticks.x=element_line(color="lightgrey"),
                                strip.background=element_rect(fill="white", color="white"),
                                strip.text=element_text(face="bold"),
                                axis.line.x=element_line(color="grey70"),
                                axis.line.y=element_line(color="grey70"),
                                panel.margin = unit(0, "lines"),
                                panel.background=element_rect(fill="white"),
                                plot.background=element_rect(fill="white"))
