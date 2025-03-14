dtModule <- function(input, output, session, data) {
  output$dt <- renderDT({
    req((data())) # Ensure data exists before rendering
    datatable(data(), options = list(pageLength = 5, autoWidth = TRUE))
  })
}
