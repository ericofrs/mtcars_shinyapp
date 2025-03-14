## Plotly function

output$plotlyPlot <- renderPlotly({
  # Create the scatter plot dynamically based on user inputs
  plot_ly(
    data = filtered_data(),
    x = ~get(input$var),             # X-axis variable
    y = ~hp,            # Y-axis variable
    color = ~factor(cyl),# Color points by the number of cylinders
    type = "scatter",    # Specify scatter plot
    mode = "markers",    # Use markers for points
    marker = list(size = 10) # Adjust marker size
  ) %>%
    layout(
      title = paste("Scatter Plot:", input$var, "vs Horsepower"),
      xaxis = list(title = input$var),  # Y-axis label
      yaxis = list(title = "Horsepower"),  # X-axis label
      legend = list(title = list(text = "Cylinders"))  # Legend title
    )
})