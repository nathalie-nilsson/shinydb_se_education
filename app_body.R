# =============================================================================
#   
#  Script name ...... app_body.R
#  Project .......... shinydb_se_education
#  Script purpose ... Define shiny dashboard body 
#
#  Author ........... Nathalie Nilsson
#
#  Date created ..... 2021-01-06
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

body <- dashboardBody(
  
  # Format
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "app_style.css")
  ),
  
  fluidRow(
    h3(icon("education", lib="glyphicon")),
    h1("Education in Sweden"),
    p(paste(min(ub.en$year), "-", max(ub.en$year))),
    br(),
    align = 'center'
  ),
  
  hr(),
  
  tabItems(
    
    # Dashboard ----------------------------------------------------------------
    
    tabItem(
      tabName = "db", 
      fluidRow(
        # input column
        column(
          width = 2,
          box(
            width = NULL,
            align = "center",
            status = "primary",
            solidHeader = TRUE,
            
            h3("Select educational level:"),
            selectInput("pickerLevel", "",
                        choices = unique(ub.en$edu), 
                        selected = "High school, 3 years", 
                        selectize = TRUE),
            br(),
            
            h3("Select age group:"),
            sliderTextInput(
              inputId = "sliderAge",
              label = "",
              grid = TRUE,
              selected = "45-54 years",
              #force_edges = TRUE,
              #value = "45-54 years",
              choices = unique(ub.en$age)
            ),
            br(),
            
            h3("Select regions:"),
            prettyCheckboxGroup(
              inputId = "checkRegion",
              label = "",
              status = "warning", 
              choices = unique(ub.en$region),
              selected = unique(ub.en$region)[c(1, 2, 3)]
            ),
            actionLink("selectAll", "Select All")
          )
        ),
        
        # Output column
        column(
          width = 10,
          
          box(
            width = NULL,
            status = "primary",
            solidHeader = TRUE,
            align = "center",
            h2("Education levels plotted over time:"),
            h4(textOutput("opEdu")),
            plotlyOutput(outputId = "linePlot")
          ),
          
          box(
            width = NULL,
            status = "primary",
            solidHeader = TRUE,
            align = "center",
            h2("Population proportional educational levels:"),
            h4(textOutput("opYear")),
            plotlyOutput("piePlot")
          ),
          
          box(
            width = NULL,
            status = "primary",
            solidHeader = TRUE,
            align = "center",
            h3("Select year:"),
            sliderInput("sliderYear", "Year",
                        value = 2000,
                        min = min(ub.en$year), 
                        max = max(ub.en$year),
                        step = 1, 
                        sep = "",
                        width = "100%", 
                        animate = animationOptions(
                          interval = 2000, 
                          loop = TRUE))
          )
        )
      )
    ),
    
    # Source data --------------------------------------------------------------
    tabItem(
      tabName = "sd",
      fluidRow(
        
        # Input column
        column(
          width = 12,
          box(
            title = "Title 1", 
            width = NULL, 
            solidHeader = TRUE, 
            status = "primary",
            "Box content"
          )
        )
      )
    ),
    
    # Source code --------------------------------------------------------------
    tabItem(tabName = "sc", 
            fluidRow(
              box("Here goes the code", 
                  status = "primary", 
                  solidHeader = TRUE)
            ))
  )
)
