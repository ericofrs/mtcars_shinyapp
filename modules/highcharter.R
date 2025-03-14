output$highchart <- renderHighchart({  
  highchart()%>%
    hc_add_series(filtered_data(), "scatter", 
                  hcaes(x = mpg, y = hp, group = factor(cyl)),
                  marker = list(symbol = "circle")) %>%
    hc_tooltip(pointFormat = "HP: {point.y} 
 MPG: {point.x}") %>%
    hc_title(text = "MTcars Data") %>%
    hc_xAxis(title = list(text = "Consumption - Miles per Gallon (mpg)")) %>%
    hc_yAxis(title = list(text = "Horsepower (hp)"))
})