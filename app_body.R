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
  
  # Stylesheet
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "app_style.css")
  ),
  
  # Header ----------------------------------------------------------------------
  fluidRow(
    h3(icon("education", lib="glyphicon")),
    h1("Education in Sweden"),
    p(paste(min(ub.en$year), "-", max(ub.en$year))),
    br(),
    align = 'center'
  ),
  
  hr(),
  
  fluidRow(
    tabBox(
      id = "se_edu_dashboard", 
      height = "100%",
      width = "100%",
      
      # Dashboard ----------------------------------------------------------------
      
      tabPanel(
        # tab tag
        tagList(icon("dashboard"), "Dashboard"),
        width = "100%",
        
        # Input column ---------------------------------------------------------
        column(
          width = 3,

          # Year input --------------------------------------------------------
          box(
            width = NULL, 
            status = "primary",
            solidHeader = TRUE,

            title = h4("Select year:"),
            sliderInput("sliderYear", "",
                        value = 2000,
                        min = min(ub.en$year), 
                        max = max(ub.en$year),
                        step = 1, 
                        sep = "",
                        width = "100%", 
                        animate = animationOptions(
                          interval = 1500, 
                          loop = TRUE))
            
          ),
          
          # Education level input ----------------------------------------------
          box(
            width = NULL, 
            status = "primary",
            solidHeader = TRUE,

            title = h4("Select education level:"), 
            pickerInput(
              inputId = "pickerLevel",
              choices = levels(ub.en$edu),
              selected = levels(ub.en$edu)[6]
            )
          ),
          
          # Age group input -------------------------------------------------------
          box(
            width = NULL, 
            status = "primary",
            solidHeader = TRUE,

            title = h4("Select age group:"), 
            sliderTextInput(
              inputId = "sliderAge",
              label = "",
              choices = unique(ub.en$age),
              selected = unique(ub.en$age)[3]
            )
          ),
          
          # Region input -----------------------------------------------------------
          box(
            width = NULL, 
            status = "primary",
            solidHeader = TRUE,

            title = h4("Select regions:"),
            prettyCheckboxGroup(
              inputId = "checkRegion",
              label = "",
              choices = unique(ub.en$region),
              selected = unique(ub.en$region),
              status = "warning"
            )
          )
        ),
        
        # Output column ----------------------------------------------------------------------
        column(
          width = 9,
          
          h2(textOutput("opYear")),
          hr(),
          
          # Value boxes output ----------------------------------------------------------------------
          box(
            width = NULL, 
            status = "primary",
            solidHeader = TRUE,
            
            valueBoxOutput(outputId = "vbTotal"), 
            valueBoxOutput(outputId = "vbMen"), 
            valueBoxOutput(outputId = "vbWomen")
          ),
          
          # Pie chart ----------------------------------------------------------------------
          box(
            width = NULL, 
            status = "primary",
            solidHeader = TRUE,
            
            plotlyOutput("piePlot")
          ),
          
          h2("Over time"),
          h4(textOutput("opEdu")),
          hr(),
          
          # Line chart ----------------------------------------------------------------------
          box(
            width = NULL, 
            status = "primary",
            solidHeader = TRUE,
            
            plotlyOutput(outputId = "linePlot")
          )
        )
      ),
      
      # Data source ----------------------------------------------------------------------
      
      tabPanel(
        # tab tag
        tagList(icon("database"), "Data"),
        width = "100%",
        
        box(
          width = NULL, 
          status = "primary",
          solidHeader = TRUE,
          
          includeMarkdown("data.Rmd"),
          
          fluidRow(
            box(width = NULL,
                status = "warning",
                title = h4("The data:"),
                tags$style(HTML("color: #303030")),
                dataTableOutput("table")
            ),
            
            box(
              width = NULL,
              h4("Educational levels translated:"),
              status = "warning",
              tags$style(HTML("color: #303030")),
              tableOutput("dict")
            )
          )
        )   
      ),
      
      # Source code ----------------------------------------------------------------------
      tabPanel(
        tagList(icon("github", "SOURCE CODE"), "Source code"),
        width = "100%", 
        
        box(
          width = NULL, 
          status = "primary",
          solidHeader = TRUE,
          
          p("Find the source code at: [some address]")
        )
        
      )
    )
  )
)
