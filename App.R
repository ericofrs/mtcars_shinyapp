library(shiny)
library(plotly)
library(reactable)
library(DT)
library(highcharter)

data("mtcars")

ui <- fluidPage(
  titlePanel("MTcars Shiny App"),

  sidebarLayout(
    sidebarPanel(
      selectInput("var", "Choose a variable:", choices = names(mtcars)[1:4]),
      sliderInput("range", "Filter by mpg:", min = min(mtcars$mpg), max = max(mtcars$mpg), value = c(min(mtcars$mpg), max(mtcars$mpg))),
      actionButton("apply_filter", "Apply Filters")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Plotly", plotlyOutput("plotly_plot")),
        tabPanel("Reactable", reactableOutput(" reactable_table")),
        tabPanel("DT Table", DTOutput("dt")),
        tabPanel("Highcharter", highchartOutput("highcharter_plot"))
      ),
    )
  )
)

server <- function(input, output, session) {
    # Reactive filtered data
    filtered_data <- reactive({
      input$apply_filter
      isolate({
        mtcars[mtcars$mpg >= input$range[1] & mtcars$mpg <= input$range[2], ]
      })
    })
    
    # Source the visualization scripts
    source("modules/dt.R", local = TRUE)
   
    
     output$reactable_table <- renderReactable({
      reactablefunction(data)
    })  
}

shinyApp(ui, server)
