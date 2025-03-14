library(shiny)
library(plotly)
library(reactable)
library(DT)
library(highcharter)

data("mtcars")
source("modules/reactable.R", local = TRUE)

ui <- fluidPage(
  titlePanel("MTcars Shiny App"),

  sidebarLayout(
    sidebarPanel(
      selectInput("var", "Choose a variable:", choices = names(mtcars)[c(1,3)]),
      sliderInput("range", "Filter by:", min = min(mtcars$mpg), max = max(mtcars$mpg), value = c(min(mtcars$mpg), max(mtcars$mpg))),
      actionButton("apply_filter", "Apply Filters")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Plotly", plotlyOutput("plotlyPlot")),
        tabPanel("Reactable", reactableOutput("reactable_table")),
        tabPanel("DT Table", DTOutput("dt")),
        tabPanel("Highcharter", highchartOutput("highchart"))
      ),
    )
  )
)

server <- function(input, output, session) {
  
  # Update sliderInput dynamically when `input$var` changes
  observeEvent(input$var, {
    updateSliderInput(session, "range", 
                      min = min(mtcars[[input$var]]), 
                      max = max(mtcars[[input$var]]),
                      label = paste("Filter by", input$var,":"),
                      value = c(min(mtcars[[input$var]]), max(mtcars[[input$var]])))
  })
  

  
    # Reactive filtered data
  filtered_data <- reactive({
    input$apply_filter  # Trigger reactivity on button click
    isolate({
      req(input$var, input$range)  # Ensure values exist
      
      # Ensure input$var correctly refers to a column
      var_name <- input$var  # Extract the selected variable as a string
      df <- mtcars  # Use the full dataset
      
      # Filter data dynamically
      df <- df[df[[var_name]] >= input$range[1] & df[[var_name]] <= input$range[2], ]
      
      return(df)  # Return the filtered dataframe
    })
  })
  
    
    # Source the visualization scripts
    source("modules/dt.R", local = TRUE)
    source("modules/highcharter.R", local = TRUE)
    source("modules/plotly.R", local = TRUE)
    
    output$reactable_table <- renderReactable({
      reactablefunction(filtered_data())
    })  
}

shinyApp(ui, server)
