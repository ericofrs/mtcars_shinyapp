# Definition of the mtcars in the reactable module
reactablefunction <- function(data) {
  reactable(data,
            striped = TRUE,
            highlight = TRUE,
            bordered = TRUE,
            #defaultSorted = input$var,
            showPageSizeOptions = TRUE,
            pageSizeOptions = c(5, 10, 15, 32),
            defaultPageSize = 10,
            theme = reactableTheme(
              borderColor = "lightgray",
              stripedColor = "lightgray",
              highlightColor = "lightblue",
              cellPadding = "8px 12px",
              style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif")
            )
  )
}
