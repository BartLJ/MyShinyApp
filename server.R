library(shiny)
library(gbm)
library(caret)

## prepare the data set
## unfortunately this takes some time
training <- read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv",
                     na.strings=c("","NA","#DIV/0!"))

## permute training set to break grouping of similar data
## and only keep the 15 most predictive features (according to a RFE with
## random forest with 5-fold CV which was done separately before)
cols <- c("classe", "roll_belt", "magnet_dumbbell_z", "yaw_belt", "pitch_belt",
          "magnet_dumbbell_y", "pitch_forearm", "accel_dumbbell_y", "roll_dumbbell",
          "roll_forearm", "roll_arm", "magnet_forearm_z", "magnet_dumbbell_x",
          "accel_dumbbell_z", "magnet_belt_z", "gyros_belt_z")
set.seed(1234)
training <- training[sample(nrow(training)), cols]

shinyServer(function(input, output) {
    
    interaction_depth <- reactive({
        input$interaction_depth
    })
    shrinkage <- reactive({
        input$shrinkage
    })
    n_trees <- reactive({
        input$n_trees
    })
    model <- reactive({
        set.seed(1234)
        trainingSet <- training[createDataPartition(training$classe, p = input$sample_ratio)[[1]],
                                names(training)[1:(input$n_features + 1)]]
        gbm(formula = classe ~ .,
             distribution = "multinomial",
             data = trainingSet,
             n.trees = n_trees(),
             interaction.depth = interaction_depth(),
             n.minobsinnode = 10,
             shrinkage = shrinkage(),
             train.fraction = 0.9)
    })
    min_val_err <- reactive({
        round(min(model()$valid.error),3)
    })
    trees_min_val_err <- reactive({
        which.min(model()$valid.error)
    })
    
    ### output variables
    
    output$min_val_err <- reactive({
        min_val_err()
    })
    output$trees_min_val_err <- reactive({
        trees_min_val_err()
    })
    output$plot <- renderPlot({
        plot(x = model()$train.error,
             type = "l",
             col = "blue",
             xlab = "number of trees",
             ylab = "Classificiation error",
             ylim = c(0, 1.6))
        lines(x= model()$valid.error, col = "red")
        abline(h = min_val_err(), lty = "dotted", col = "red")
        abline(v = trees_min_val_err(), lty = "dotted", col = "red")
        legend(x = "topright", legend = c("training error", "validation error"),
               pch = "_", col=c("blue", "red"))
        points(trees_min_val_err(), min_val_err(), pch = 16, col = "red")
        text(trees_min_val_err(), min_val_err(),
             labels = paste0("(", trees_min_val_err(), ",\n ", min_val_err(), ")"),
             pos = 3, col="red", offset = 0.75)
    })
})
