library(shiny)
library(scatterD3)

fluidPage(
  titlePanel("Sample scatterD3 shiny app"),
  div(class="row",
      div(class="col-md-12",
          div(class="alert alert-warning alert-dismissible",
              HTML('<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'),
              HTML("<strong>What you can try here :</strong>
<ul>
<li>Zoom on the chart with the mousewheel</li>
<li>Pan the plot</li>
<li>Drag text labels</li>
<li>Hover over a dot to display tooltips</li>
<li>Hover over the color or symbol legends items</li>
<li>Change data settings to see transitions</li>
<li>Resize the window to test for responsiveness</li>
<li>Try the lasso plugin with the toggle button or by using Shift+click</li>
</ul>")))),
  sidebarLayout(
    sidebarPanel(
    sliderInput("scatterD3_nb", "Number of observations",
                 min = 3, max = nrow(mtcars), step = 1, value = nrow(mtcars)),
    selectInput("scatterD3_x", "x variable :",
                choices = c("Miles/(US) gallon" = "mpg",
                            "Displacement (cu.in.)" = "disp",
                            "Gross horsepower" = "hp",
                            "Rear axle ratio" = "drat",
                            "Weight (lb/1000)" = "wt",
                            "1/4 mile time" = "qsec"),
                selected = "wt"),
    selectInput("scatterD3_y", "y variable :",
                choices = c("Miles/(US) gallon" = "mpg",
                            "Displacement (cu.in.)" = "disp",
                            "Gross horsepower" = "hp",
                            "Rear axle ratio" = "drat",
                            "Weight (lb/1000)" = "wt",
                            "1/4 mile time" = "qsec"),
                selected = "mpg"),
    selectInput("scatterD3_col", "Color mapping variable :",
                choices = c("None" = "None",
                            "Number of cylinders" = "cyl",
                            "V/S" = "vs",
                            "Transmission" = "am",
                            "Miles/(US) gallon" = "mpg",
                            "Displacement (cu.in.)" = "disp",
                            "Gross horsepower" = "hp",
                            "Rear axle ratio" = "drat",
                            "Weight (lb/1000)" = "wt",
                            "1/4 mile time" = "qsec"),
                selected = "cyl"),
    checkboxInput("scatterD3_ellipses", "Confidence ellipses", value = FALSE),
    selectInput("scatterD3_symbol", "Symbol mapping variable :",
                choices = c("None" = "None",
                            "Number of cylinders" = "cyl",
                            "V/S" = "vs",
                            "Transmission" = "am",
                            "Number of forward gears" = "gear",
                            "Number of carburetors" = "carb"),
                selected = "am"),
    selectInput("scatterD3_size", "Size mapping variable :",
                choices = c("None" = "None",
                            "Miles/(US) gallon" = "mpg",
                            "Displacement (cu.in.)" = "disp",
                            "Gross horsepower" = "hp",
                            "Rear axle ratio" = "drat",
                            "Weight (lb/1000)" = "wt",
                            "1/4 mile time" = "qsec"),
                selected = "hp"),
    sliderInput("scatterD3_labsize", "Labels size :",
                 min = 5, max = 25, value = 11),
    sliderInput("scatterD3_opacity", "Points opacity :", min = 0, max = 1, value = 1, step = 0.05),
    checkboxInput("scatterD3_transitions", "Use transitions", value = TRUE),
    tags$p(actionButton("scatterD3-reset-zoom", HTML("<span class='glyphicon glyphicon-search' aria-hidden='true'></span> Reset Zoom")),
           actionButton("scatterD3-lasso-toggle", HTML("<span class='glyphicon glyphicon-screenshot' aria-hidden='true'></span> Toggle Lasso"), "data-toggle" = "button"),
           tags$a(id = "scatterD3-svg-export", href = "#",
                  class = "btn btn-default", HTML("<span class='glyphicon glyphicon-save' aria-hidden='true'></span> Download SVG"))),
    tags$ul(tags$li(tags$a(href = "https://github.com/juba/scatterD3", "scatterD3 on GitHub")),
            tags$li(tags$a(href = "https://github.com/juba/scatterD3_shiny_app", "This app on GitHub")))
  ),
  mainPanel(scatterD3Output("scatterPlot", height = "700px"))
))

