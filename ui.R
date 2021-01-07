# =============================================================================
#   
#  Script name ...... ui.R
#  Project .......... shinydb_se_education
#  Script purpose ... Define shiny dashboard layout
#
#  Author ........... Nathalie Nilsson
#
#  Date created ..... 2021-01-06
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Source elements
source('./app_header.R')
source('./app_sidebar.R')
source('./app_body.R')

# Build interface
ui <- dashboardPage(
  header,
  sidebar,
  body,
)