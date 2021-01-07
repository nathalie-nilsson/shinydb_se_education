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
        column(width = 7, 
               align = "center", 
               h2("Population proportional educational levels:")
        ), 
        
        column(width = 5, 
               align = "center", 
               h2("Education levels plotted over time:"),
               h4(textOutput("opEdu")),
        )
      ), 
      
      fluidRow(
        
        column(
          width = 7,

          box(
            width = NULL, 
            align = "center", 
            status = "primary", 
            solidHeader = TRUE, 
            
            h4("Select year:"),
            sliderInput("sliderYear", "",
                        value = 2000,
                        min = min(ub.en$year), 
                        max = max(ub.en$year),
                        step = 1, 
                        sep = "",
                        width = "100%", 
                        animate = animationOptions(
                          interval = 2000, 
                          loop = TRUE))
          ),
          
          box(
            width = NULL, 
            status = "primary", 
            solidHeader = TRUE,
            align = "center",

            h2(textOutput("opYear")),
            hr(),
            
            # Value boxes ------------------------------------------------------
            fluidRow(
              column(
                width = 7/3,
                align = "left",
                valueBoxOutput(outputId = "vbTotal")
              ),
              column(
                width = 7/3,
                align = "left", 
                valueBoxOutput(outputId = "vbMen")
              ),
              column(
                width = 7/3, 
                align = "left", 
                valueBoxOutput(outputId = "vbWomen")
              )
            )
          ), 
            
            # Pie plot -------------------------------------------------------
          box(
            width = NULL,
            status = "primary",
            solidHeader = TRUE,
            align = "center",

            plotlyOutput("piePlot")
          )
        ),
        
        column(
          width = 3,

          # Line plot ----------------------------------------------------------
          box(
            width = NULL,
            status = "primary",
            solidHeader = TRUE,
            align = "center",

            plotlyOutput(outputId = "linePlot", height = "600px")
          )
        ),
        
        column(
          width = 2,
          box(
            width = NULL, 
            status = "primary", 
            solidHeader = TRUE, 
            
            h3("Select education level:"),
            pickerInput(
              inputId = "pickerLevel",
              choices = unique(ub.en$edu),
              selected = unique(ub.en$edu)[5]
            ),
            h3("Select age group:"),
            sliderTextInput(
              inputId = "sliderAge",
              label = "",
              choices = unique(ub.en$age),
              selected = unique(ub.en$age)[3]
            ),
            h3("Select regions:"),
            prettyCheckboxGroup(
              inputId = "checkRegion",
              label = "",
              choices = unique(ub.en$region),
              selected = unique(ub.en$region),
              status = "warning"
            )
          )
        )
      )
    ),
    
    # Source data --------------------------------------------------------------
    tabItem(
      tabName = "sd",
      fluidRow(
        
        # Population column
        column(
          width = 7,
          
          # Value boxes
          box(
            width = NULL, 
            solidHeader = TRUE,
            status = "primary", 
            column(width = 7/3,
                   valueBox(250, "total")), 
            column(width = 7/3,
                   valueBox(100, "male")), 
            column(width = 7/3, 
                   valueBox(150, "female"))
          ),
          
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
