# =============================================================================
#   
#  Script name ...... app.R 
#  Project .......... shinydb_se_education
#  Script purpose ... Run shiny dashboard
#
#  Author ........... Nathalie Nilsson
#
#  Date created ..... 2021-01-06
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Layout
source('./ui.R')

# Server
source('./server.R')

# Run app
shinyApp(ui, server)