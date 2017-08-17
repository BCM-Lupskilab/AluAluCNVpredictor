library(shiny)
source("prediction.R")
riskscore <- read.delim("data/AAMR_risk_score.txt", header = T)


shinyServer(function(input, output){
  ###gene level
  score <- reactive({
    as.numeric(unique(riskscore[riskscore$Gene_name==toupper(input$geneID),2]))
  })
  rank <- reactive({
    as.numeric(unique(riskscore[riskscore$Gene_name==toupper(input$geneID),1]))
  })
  output$textscr <- renderText({ 
    paste("AAMR risk score: ",score(), sep="") 
  })
  output$textrnk <- renderText({
    paste("Rank: ",rank(), "/12074", sep="")
  })
  
  output$hist <- renderPlot({
          par(mar=c(2.5,2.5,1,1)+0.1, mgp = c(1.5, 0.5, 0))
          hist(unique(riskscore[,2:3])[,1],breaks=100, xlab="AAMR risk score", main=NULL)
          
          abline(v=score(),col="red")
          
          
  })
  
  ###interval level
  
  df <- eventReactive(input$go,{prediction(input$GI5,input$GI3)})
  
  output$table1 <- renderTable({
    df()
  }, include.rownames = FALSE)
  
  
  
})

