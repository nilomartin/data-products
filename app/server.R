library(shiny)
shinyServer(function(input, output) {
  USArrests$total<-USArrests$Murder+USArrests$Assault+USArrests$Rape
  USArrests$pop.sp<- ifelse(USArrests$UrbanPop - 50 > 0, USArrests$UrbanPop - 50, 0)
  model1 <- lm(total~UrbanPop, data=USArrests)
  model2 <- lm(total ~ pop.sp+UrbanPop, data = USArrests)
  
  model1pred <- reactive({
    popInput <- input$sliderPOP
    predict(model1, newdata = data.frame(UrbanPop = popInput))
  })
  
  model2pred <- reactive({
    popInput <- input$sliderPOP
    predict(model2, newdata = data.frame(UrbanPop = popInput,
                                         pop.sp = ifelse(popInput - 50 > 0,
                                                         popInput - 50, 0)))
  })
  
  output$plot1 <- renderPlot({
    popInput <- input$sliderPOP
    
    plot(USArrests$UrbanPop, USArrests$total, xlab = "Percent urban population (%)", 
         ylab = "Total violent crime arrests", bty = "n", pch = 16, xlim=c(20,100), cex=2)
    if(input$showModel1){
      abline(model1, col = "red", lwd = 2)
    }
    if(input$showModel2){
      model2lines <- predict(model2, newdata = data.frame(
        UrbanPop = 20:100, pop.sp = ifelse(20:100 - 50 > 0, 20:100 - 50, 0)
      ))
      lines(20:100, model2lines, col = "blue", lwd = 2)
    }
    legend(20, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
           col = c("red", "blue"), bty = "n", cex = 1.2)
    points(popInput, model1pred(), col = "red", pch = 16, cex = 2)
    points(popInput, model2pred(), col = "blue", pch = 16, cex = 2)
  })
  
  output$pred1 <- renderText({
    model1pred()
  })
  
  output$pred2 <- renderText({
    model2pred()
  })
})