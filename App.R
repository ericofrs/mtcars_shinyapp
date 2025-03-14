library(shiny)
library(plotly)
library(reactable)
library(DT)
library(highcharter)

#call modules

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
        tabPanel("Reactable", reactableOutput("reactable_table")),
        tabPanel("DT Table", DTOutput("dt_table")),
        tabPanel("Highcharter", highchartOutput("highchart_plot"))
      )
    )
  )
)

server <- function(input, output, session) {

  filtered_data <- reactive({
    mtcars %>%
      filter(mpg >= input$range[1], mpg <= input$range[2])
  })
  
  output$highchart_plot <- renderHighchart({  
  highchart()%>%
    hc_add_series(filtered_data(), "scatter", 
                  hcaes(x = mpg, y = hp, group = factor(cyl)),
                  marker = list(symbol = "circle")) %>%
      hc_tooltip(pointFormat = "HP: {point.y} <br> MPG: {point.x}") %>%
      hc_title(text = "MTcars Data") %>%
      hc_xAxis(title = list(text = "Consumption - Miles per Gallon (mpg)")) %>%
      hc_yAxis(title = list(text = "Horsepower (hp)"))
  })
}

shinyApp(ui, server)