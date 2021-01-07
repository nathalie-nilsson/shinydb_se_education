# =============================================================================
#   
#  Script name ...... app_sidebar.R
#  Project .......... shinydb_se_education
#  Script purpose ... Define shiny dashboard sidebar
#
#  Author ........... Nathalie Nilsson
#
#  Date created ..... 2021-01-06
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sidebar <- dashboardSidebar(
  width = "250px",
  collapsed = TRUE,
  sidebarMenu(
    br(),
    menuItem("Dashboard", tabName = "db", icon = icon("dashboard")), 
    menuItem("Data", tabName = "sd", icon = icon("database")), 
    menuItem("Source code", tabName = "sc", icon = icon("code"))
  )
)
