# =============================================================================
#   
#  Script name ...... app_header.R
#  Project .......... shinydb_se_education
#  Script purpose ... Define shiny dashboard header 
#
#  Author ........... Nathalie Nilsson
#
#  Date created ..... 2021-01-06
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Packages ---------------------------------------------------------------------
library(shiny)
library(shinyWidgets)
library(shinydashboard)


# Header -----------------------------------------------------------------------
header <- dashboardHeader(
  # title = span(
  #   tagList(
  #     icon("education", lib = "glyphicon")
  #     )),
  titleWidth = "0px"
)
