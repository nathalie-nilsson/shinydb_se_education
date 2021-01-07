# ==============================================================================
#   
#  Script name ...... functions.R
#  Project .......... shinydb_se_education
#  Script purpose ... Define project functions
#  
#  Author ........... Nathalie Nilsson
#  
#  Date created ..... 2021-01-06
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

dict_replace <- function(datapoint, value, key) {
  # Looks up a data point in a value vector and returns the corresponding value 
  # in the key vector.
  key[datapoint == value]
}

my.theme <- theme(legend.position = "none",
                  #legend.key = element_blank(),
                  legend.background = element_blank(),
                  axis.line = element_line(colour = "Gainsboro"),
                  text = element_text(size = 13, family = "Open Sans", colour = "Gainsboro"),
                  plot.background = element_rect(fill = "#303030"),
                  plot.title = element_text(size = 14),
                  axis.text = element_text(size = 12, color = "Gainsboro"),
                  panel.grid.major.y = element_blank(),
                  panel.grid.minor.y = element_blank(),
                  panel.grid.major.x = element_blank(),
                  panel.grid.minor.x = element_blank(),
                  panel.background = element_rect(fill = "#303030"),
                  panel.spacing = unit(0.8, "lines"),
                  strip.background = element_blank(),
                  strip.background.y = element_blank(),
                  strip.placement = "inside",
                  strip.text = element_text(color = "Gainsboro"),
                  plot.title.position = "plot")
