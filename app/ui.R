library(shiny)
shinyUI(fluidPage(
  titlePanel("Predict Total Violent Crimes from Urban Population"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderPOP", "What is the percentage of urban population?", 20, 100, value = 50),
      checkboxInput("showModel1", "Show/Hide crimes model 1", value = T),
      checkboxInput("showModel2", "Show/Hide crimes model 2", value = T),
      submitButton("Submit")
    ),
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", br(), plotOutput("plot1"),
                  h3("Predicted crimes from model 1:"),
                  textOutput("pred1"),
                  h3("Predicted crimes from model 2:"),
                  textOutput("pred2")
                  ),
                  tabPanel("Info", br(), 
                           "This app predicts total arrest for violent crimes 
                           (assauld, rape and murder) per 100,000 people in the US using urban population 
                           percent as predictor.", br(),
                           "The USArrest data set is used, and refers to data of each of the 50 US 
                           states in 1973.", br(),
                           "Two linear models are fitted. Model 1 fit a straigth line and Model 2
                           uses a one node spline. One can compare the fitted curves and total predicted
                           arrests.", br(),
                           "By moving the slider one can define the the urban population percent and by hitting the 
                           \"Submit\" buton the app gives the prediction", br(),
                           "Besides, one can decide to show or hide the fitted curves."
                  )
      )
    )
  )
))