# MyShinyApp
This Shiny application is part of the Coursera Data Products course Assignment for Week 4

### Instructions

This application gives the user the possibility to visualize and understand the impact of different parameters on the quality of a fitted Gradient Boosted Trees (GBM) model for a multi-classification problem. The plot shows the training and validation error for the fitted GBM model.

The parameters one can change in the left-side panel with the sliders are:

* Data selection parameters:  
    - _**Sample ratio of observations**_: the ratio of the observations to fit and validate the model  
    - _**Number of predictors**_: the number of predictors to fit the model  
* Model parameters:  
    - _**Number of trees**_: the maximum number of trees/iterations to fit the model  
    - _**Interaction depth**_: the depth of each individual tree in the model. This is a measure for the interaction complexity in an individual tree  
    - _**Learning rate**_: the learning rate aka shrinkage, defines the coefficient of the gradient step in the boosting algorithm (or how fast does each iteration step correct for the remaining error)

It is required to push the _**Refresh Plot**_ button to update the plot for the changed parameters.

### Background

The underlying data is part of an assignment in the Coursera course [Practical Machine Learning](https://www.coursera.org/learn/practical-machine-learning), can be downloaded from [here](https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv) and was originally part of the [MLE dataset](http://groupware.les.inf.puc-rio.br/har#weight_lifting_exercises) (see reference below).

As described in the [GBM Vignette](http://finzi.psych.upenn.edu/R/library/gbm/doc/gbm.pdf) for the GBM model in R, the  model parameters in this application have an impact on the quality of the fitted model:

- Number of trees: needs to be high enough to reach the minimum validation error. Can be increased if required, but also increases the computational time.  
- Interaction depth: increasing the depth of each individual tree increases the risk of overfitting, thus increases the validation error. Also increases computational time.   
- Learning rate (aka shrinkage): a smaller learning rate avoids overfitting, but increases the number of trees required, and thus the computational time.

We also give the user the possibility to observe the impact of the number of training samples and features on the fitness of the model:

- Sample ratio of observations: higher ratios (thus more samples) considerably improve the accuracy of the model up to a certain point  
- Number of features (N): We already ordered the features according to their importance (based on a RFE with random forests). This parameter lets the user take into account only the N most important features in the model. Increasing the number of relevant features in the model tends to improve the quality of the model

<u>Note:</u> the training and validation error in this plot represent the multinomial log loss, for which the calculation is described [here](https://www.kaggle.com/wiki/MultiClassLogLoss)

### References

Velloso, E.; Bulling, A.; Gellersen, H.; Ugulino, W.; Fuks, H. Qualitative Activity Recognition of Weight Lifting Exercises. Proceedings of 4th International Conference in Cooperation with SIGCHI (Augmented Human '13) . Stuttgart, Germany: ACM SIGCHI, 2013.  
[Document](http://groupware.les.inf.puc-rio.br/public/papers/2013.Velloso.QAR-WLE.pdf)


