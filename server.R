library(shiny)
library(scatterD3)

default_lines <- data.frame(slope = c(0, Inf), 
                            intercept = c(0, 0),
                            stroke = "#000",
                            stroke_width = 1,
                            stroke_dasharray = c(5, 5))
threshold_line <- data.frame(slope = 0, 
                             intercept = 30, 
                             stroke = "#F67E7D",
                             stroke_width = 2,
                             stroke_dasharray = "")

function(input, output) {
  
  data <- reactive({
    mtcars[1:input$scatterD3_nb,]
  })
  
  lines <- reactive({
    if (input$scatterD3_threshold_line) {
      return(rbind(default_lines, threshold_line))
    }
    default_lines
  })
  
  output$scatterPlot <- renderScatterD3({
    col_var <- if (input$scatterD3_col == "None") NULL else data()[,input$scatterD3_col]
    symbol_var <- if (input$scatterD3_symbol == "None") NULL else data()[,input$scatterD3_symbol]
    size_var <- if (input$scatterD3_size == "None") NULL else data()[,input$scatterD3_size]
    scatterD3(x = data()[,input$scatterD3_x],
              y = data()[,input$scatterD3_y],
              lab = rownames(data()),
              xlab = input$scatterD3_x,
              ylab = input$scatterD3_y,
              col_var = col_var,
              col_lab = input$scatterD3_col,
              ellipses = input$scatterD3_ellipses,
              symbol_var = symbol_var,
              symbol_lab = input$scatterD3_symbol,
              size_var = size_var,
              size_lab = input$scatterD3_size,
              url_var = paste0("https://www.duckduckgo.com/?q=", rownames(data())),
              key_var = rownames(data()),
              point_opacity = input$scatterD3_opacity,
              labels_size = input$scatterD3_labsize,
              transitions = input$scatterD3_transitions,
              lines = lines(),
              lasso = TRUE,
              lasso_callback = "function(sel) {alert(sel.data().map(function(d) {return d.lab}).join('\\n'));}")
  })
}