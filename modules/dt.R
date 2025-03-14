output$dt <- renderDT({
  req(filtered_data())  # Ensure data is not NULL
  df <- as.data.frame(filtered_data())  # Force it to be a data frame
  datatable(df, options = list(pageLength = 5, autoWidth = TRUE))
})  # Client-side rendering
