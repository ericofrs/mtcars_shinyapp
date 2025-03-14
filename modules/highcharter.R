output$highchart <- renderHighchart({ 
  
  req(input$var)
  
  highchart()%>%
    
    hc_add_series(filtered_data(),
                  
                  "scatter", 
                  
                  hcaes(x = !!sym(input$var), y = hp, group = factor(cyl)),  # Dynamic x-axis
                  
                  marker = list(symbol = "circle")) %>%
    
    hc_tooltip(pointFormat = paste0("HP: {point.y} <br> ", input$var, ": {point.x}")) %>%
    
    hc_title(text = "MTcars Data") %>%
    
    hc_xAxis(title = list(text = input$var)) %>%  # Dynamic x-axis label
    
    hc_yAxis(title = list(text = "Horsepower (hp)"))
  
})
