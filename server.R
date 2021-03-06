# =============================================================================
#   
#  Script name ...... server.R
#  Project .......... shinydb_se_education
#  Script purpose ... Define shiny dashboard server
#
#  Author ........... Nathalie Nilsson
#
#  Date created ..... 2021-01-06
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

server <- function(input, output, session) {
  
  # Value boxes ----------------------------------------------------------------
  output$vbTotal <- renderValueBox({
    ub_t <- ub.en %>%
      filter(year == input$sliderYear) %>%
      select(number) %>%
      sum()
    valueBox(value = ub_t, 
             icon = icon("users"),
             subtitle = "Total", 
             color = "orange")
  })
  
  output$vbMen <- renderValueBox({ 
    ub_m <- ub.en %>%
      filter(year == input$sliderYear, 
             gender == "Men") %>%
      select(number) %>%
      sum()
    valueBox(value = ub_m, 
             icon = icon("mars"),
             subtitle = "Number of men", 
             color = "navy")
  })
  
  output$vbWomen <- renderValueBox({
    ub_f <- ub.en %>%
      filter(year == input$sliderYear, 
             gender == "Women") %>%
      select(number) %>%
      sum()
    valueBox(value = ub_f,
             icon = icon("venus"), 
             subtitle = "Number of women", 
             color = "fuchsia")
  })
  
  # Pie chart ------------------------------------------------------------------
  # Annotation format
  a <- list(y = 1, showarrow = FALSE, 
            xref = "paper", yref = "paper", 
            font = list(family = "Open Sans", size = 18, face="bold", color = "Gainsboro"), 
            xanchor = "left")
  
  # Title font format
  output$piePlot <- renderPlotly({
    
    # Define population sizes for the selected year
    year_pop <- sum(filter(pop, year == input$sliderYear)$population)
    year_pop_f <- sum(filter(pop, year == input$sliderYear & gender == "Women")$population)
    year_pop_m <- sum(filter(pop, year == input$sliderYear & gender == "Men")$population)
    
    # Data for the selected year
    year_data <- ub.en %>%
      filter(year == input$sliderYear) %>%
      group_by(edu) %>%
      summarise(tot_number = sum(number)) %>%
      mutate(perc = tot_number/year_pop)
    
    year_data_f <- ub.en %>%
      filter(year == input$sliderYear & gender == "Women") %>%
      group_by(edu) %>%
      summarise(tot_number = sum(number)) %>%
      mutate(perc = tot_number/year_pop_f)
    
    year_data_m <- ub.en %>%
      filter(year == input$sliderYear & gender == "Men") %>%
      group_by(edu) %>%
      summarise(tot_number = sum(number)) %>%
      mutate(perc = tot_number/year_pop_m)
    
    # Plot
    fig <- plot_ly()
    fig <- fig %>% add_pie(data = year_data, labels = ~edu, values = ~perc,
                           name = "Total", domain = list(row = 0, column = 0), 
                           sort = FALSE, 
                           marker = list(colors = viridis(8, option = "B")),
                           outsidetextfont = list(color = "Gainsboro"))
    fig <- fig %>% add_pie(data = year_data_m, labels = ~edu, values = ~perc,
                           name = "Males", domain = list(row = 0, column = 1),
                           sort = FALSE, 
                           marker = list(colors = viridis(8, option = "B")),
                           outsidetextfont = list(color = "Gainsboro"))
    fig <- fig %>% add_pie(data = year_data_f, labels = ~edu, values = ~perc,
                           name = "Females", domain = list(row = 0, column = 2), 
                           sort = FALSE, 
                           marker = list(colors = viridis(8, option = "B")),
                           outsidetextfont = list(color = "Gainsboro"))
    fig <- fig %>% layout(margin = list(t=50, b=50, r=0, l=0),
                          plot_bgcolor = "rgba(0,0,0,0)",
                          paper_bgcolor = "rgba(0,0,0,0)",
                          fig_bgcolor = "rgba(0,0,0,0)",
                          legend = list(orientation = "v", y=0.5, font = list(color = "Gainsboro")),
                          grid=list(rows=1, columns=3),
                          xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                          yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE), 
                          annotations = list(
                            append(list(x = 0, text = "Total"), a),
                            append(list(x = 1/3, text = "Men"), a),
                            append(list(x = 2/3, text = "Women"), a))) 
    
    # Render plot
    fig
  })
  
  # Action buttons -------------------------------------------------------------
  observeEvent(input$buttonSelectAll, {
    
      updatePrettyCheckboxGroup(
        session,
        inputId = "checkRegion",
        label = "",
        choices = unique(ub.en$region),
        selected = unique(ub.en$region),
        prettyOptions = list(status="warning")
      )
  })

  observeEvent(input$buttonDeSelectAll, {
    
    updatePrettyCheckboxGroup(
      session,
      inputId = "checkRegion",
      label = "",
      choices = unique(ub.en$region), 
      prettyOptions = list(status="warning")
    )
  })
  
  # Output: Selected year ------------------------------------------------------
  output$opYear <- renderText({
    paste("Year", input$sliderYear)
  })
  
  # Output: Selected educational level & age group -----------------------------
  output$opEdu <- renderText({
    paste("Educational level:", input$pickerLevel, 
          "\t|\t Age group:", input$sliderAge)
  })
  
  # Line chart  ---------------------------------------------------------------- 
  output$linePlot <- renderPlotly({
    
    # data
    ub_plot <- ub.en %>%
      filter(edu == input$pickerLevel,
             region %in% input$checkRegion,
             age == input$sliderAge)

    # ggplot2 plot
    plot_ub <- ggplot(ub_plot, aes(year, number, group = region, color = region)) +
      geom_line(size=1) +
      geom_point(size=1.5) +
      facet_grid(~gender) +
      labs(x = "Year") +
      geom_vline(xintercept = input$sliderYear, linetype = "dashed", color = "Gainsboro") +
      scale_color_viridis_d("D", begin = 0.1) +
      scale_y_continuous(expand = c(0, 0), limits = c(0, 1.10*max(ub_plot$number))) +
      my.theme

    # plotly plot
    ggplotly(plot_ub)

  })
  
  # Data table -----------------------------------------------------------------
  output$table <- renderDataTable(
    ub.en, 
    options = list(paging =TRUE, pageLength =  10)
    )
  
  # Dictionary -----------------------------------------------------------------
  output$dict <- renderTable(edu_dict)
  
  # GitHub link ----------------------------------------------------------------
  url <- a("shinydb_se_education code", 
           href="https://github.com/nathalie-nilsson/shinydb_se_education/", 
           style = "color: orange; font-family: 'Source Sans Pro")
  output$githubLink <- renderUI({
    tagList(icon("github"), url)
  })
  
}