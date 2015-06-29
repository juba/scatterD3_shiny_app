library(shiny)
library(scatterD3)

function(input, output) {
    output$scatterPlot <- renderScatterD3({
      scatterD3(x=mtcars$wt,
                y=mtcars$mpg,
                lab=rownames(mtcars),
                col_var=mtcars$cyl)
    })
  }
