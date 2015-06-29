library(shiny)
library(scatterD3)

fluidPage(
    sidebarLayout(
      sidebarPanel(
        numericInput("scatterD3-size", "Labels size :", min = 2, max = 30, value = 10),
        numericInput("scatterD3-opacity", "Opacity :", min = 0, max = 1, value = 1, step=0.05),
        actionButton("scatterD3-resetzoom", "Reset Zoom"),
        tags$a(id="scatterD3-download", href="#", class="btn btn-default", "Download SVG")
      ),
      mainPanel(scatterD3Output("scatterPlot"))
    )
  )