library(shiny)

# We want to show the accuracy of a gradient boosted tree fitting for
# the classification of XXXXXXXX (data to decide, see previous exercises)
# in terms of the number of trees (x-axis)
# and for specific values of the meta-parameters (sliders)
#


shinyUI(fluidPage(
  
  # Application title
  titlePanel("Gradient Boosted Tree Classification"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       h3(tags$u("Data selection")),
       sliderInput("sample_ratio",
                   "Sample ratio of observations",
                   min = 0.1,
                   max = 1.0,
                   value = 0.1,
                   step = 0.1),
       sliderInput("n_features",
                   "Number of predictors",
                   min = 2,
                   max = 15,
                   value = 2,
                   step = 1),
       hr(),
       h3(tags$u("GBM model parameters")),
       sliderInput("n_trees",
                   "Maximum number of trees:",
                   min = 1000,
                   max = 10000,
                   value = 1000,
                   step = 1000),
       sliderInput("interaction_depth",
                   "Interaction depth",
                   min = 1,
                   max = 15,
                   value = 2,
                   step = 1),
       sliderInput("shrinkage",
                   "Learning rate",
                   min = 0.01,
                   max = 0.5,
                   value = 0.1,
                   step = 0.01),
       submitButton("Refresh Plot", icon("refresh"))
    ),
    
    # Show the plot and documentation in 2 tabs
    mainPanel(
       tabsetPanel(
           tabPanel("Plot",
                    h3("Classification Error for GBM"),
                    plotOutput("distPlot"),
                    hr(),
                    p("Minimum validation error: ", tags$b(textOutput("min_val_err", container = span))),
                    p("for", tags$b(textOutput("trees_min_val_err", container = span)), "trees.")
           ),
           tabPanel("Documentation", includeHTML("documentation.html"))
       )
    )
  )
))
