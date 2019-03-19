library(shiny)
library(scatterD3)

d <- mtcars
d$names <- rownames(mtcars)
d$cyl_cat <- paste(d$cyl, "cylinders")

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
    d[1:input$scatterD3_nb,]
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
    zoom_on <- if (input$scatterD3_zoomon == "None") {
      NULL 
    } else {
      c(data()[input$scatterD3_zoomon, input$scatterD3_x],
        data()[input$scatterD3_zoomon, input$scatterD3_y])
    }
    scatterD3(x = data()[,input$scatterD3_x],
              y = data()[,input$scatterD3_y],
              lab = data()[,"names"],
              xlab = input$scatterD3_x,
              ylab = input$scatterD3_y,
              x_log = input$scatterD3_x_log,
              y_log = input$scatterD3_y_log,
              col_var = col_var,
              col_lab = input$scatterD3_col,
              ellipses = input$scatterD3_ellipses,
              symbol_var = symbol_var,
              symbol_lab = input$scatterD3_symbol,
              size_var = size_var,
              size_lab = input$scatterD3_size,
              url_var = paste0("https://www.duckduckgo.com/?q=", rownames(data())),
              key_var = rownames(data()),
              zoom_on = zoom_on,
              zoom_on_level = 8,
              point_opacity = input$scatterD3_opacity,
              labels_size = input$scatterD3_labsize,
              transitions = input$scatterD3_transitions,
              left_margin = 90,
              lines = lines(),
              lasso = TRUE,
              caption = list(title = "Sample scatterD3 shiny app",
                             subtitle = "A sample application to show animated transitions",
                             text = "Yep, you can even use <strong>markup</strong> in caption text. <em>Incredible</em>, isn't it ?"),
              lasso_callback = "function(sel) {alert(sel.data().map(function(d) {return d.lab}).join('\\n'));}")
  })
}