# Install and load the Plotly library
library(plotly)
library(shiny)

# Example data: using the built-in `mtcars` dataset
data(mtcars)
head(mtcars) 

# Load required libraries
library(shiny)
library(plotly)

# Define UI
ui <- fluidPage(
  titlePanel("Interactive Plotly Visualization with mtcars"),
  sidebarLayout(
    sidebarPanel(
      # Dropdown to select the x-axis variable
      selectInput("xvar", "Choose X-axis:",
                  choices = colnames(mtcars), selected = "hp"),
      # Dropdown to select the y-axis variable
      selectInput("yvar", "Choose Y-axis:",
                  choices = colnames(mtcars), selected = "mpg"),
      # Dropdown to select variable for coloring points
      selectInput("colorvar", "Color By:",
                  choices = c("cyl", "gear", "carb"), selected = "cyl")
    ),
    mainPanel(
      plotlyOutput("plotlyPlot")  # Output for the Plotly scatter plot
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  output$plotlyPlot <- renderPlotly({
    # Create the scatter plot dynamically based on user inputs
    plot_ly(
      data = mtcars,
      x = ~hp,             # X-axis variable
      y = ~mpg,            # Y-axis variable
      color = ~factor(cyl),# Color points by the number of cylinders
      type = "scatter",    # Specify scatter plot
      mode = "markers",    # Use markers for points
      marker = list(size = 10) # Adjust marker size
    ) %>%
      layout(
        title = "Dynamic Scatter Plot with mtcars Dataset",
        xaxis = list(title = "Horsepower"),  # X-axis label
        yaxis = list(title = "Miles per Gallon"),  # Y-axis label
        legend = list(title = list(text = "Cylinders"))  # Legend title
      )
  })
}

# Run the app
shinyApp(ui = ui, server = server)

