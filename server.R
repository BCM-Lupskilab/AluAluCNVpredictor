library(shiny)
source("prediction.R")
source("prediction_hg38.R")

riskscore <- read.delim("data/Gene_level_prediction.txt",header = T)

shinyServer(function(input, output){
  
  allAlu <- reactive({
          as.character(riskscore[riskscore$genename==toupper(input$geneID),2])
  }) 
  
  CNVAlu <- reactive({
          as.character(riskscore[riskscore$genename==toupper(input$geneID),3])
  }) 
  MIMID<- reactive({
            as.character(riskscore[riskscore$genename==toupper(input$geneID),8])
          })     
  
  MIMscore <- reactive({
          round(as.numeric(riskscore[riskscore$genename==toupper(input$geneID),6]),digits = 3)
  }) 
  
  MIMrank <- reactive({
            as.numeric(riskscore[riskscore$genename==toupper(input$geneID),5])
          })
  
  allscore <- reactive({
          round(as.numeric(riskscore[riskscore$genename==toupper(input$geneID),4]), digits= 3)
  })
  
  allrank <- reactive({
          as.numeric(riskscore[riskscore$genename==toupper(input$geneID),11])
  })
  
  output$textallAlu <- renderText({ 
          paste("Count of total intersecting Alu pairs: ", allAlu(), sep="") 
  }) 
  output$textCNVAlu <- renderText({ 
          paste("Count of predicted CNV-Alu pairs: ", CNVAlu(), sep="") 
  }) 
  
  output$textMIMID <- renderText({ 
            paste("MIM number: ", MIMID(), sep="") 
          })      
  output$textMIMscore <- renderText({ 
            paste("AAMR risk score for MIM genes: ", MIMscore(), sep="") 
          })      
  output$textMIMrnk <- renderText({
            paste("Rank in MIM genes: ",MIMrank(), "/12,074", sep="")
          })      
  output$textallscore <- renderText({ 
          paste("AAMR risk score for available RefSeq genes: ", allscore(), sep="") 
  })         
  
  output$textallrank <- renderText({
          paste("Rank in available RefSeq genes: ",allrank(), "/23,637", sep="")
  })    
  
  
  output$hist1 <- renderPlot({
          par(mar=c(2.5,2.5,1,1)+0.1, mgp = c(1.5, 0.5, 0))
          hist(unique(riskscore[,c(1,6)])[,2],breaks=100, xlab="AAMR risk scores for OMIM genes", main=NULL)
  
          abline(v=MIMscore(),col="red")
  
  
  })      
        
  output$hist2 <- renderPlot({
          par(mar=c(2.5,2.5,1,1)+0.1, mgp = c(1.5, 0.5, 0))
          hist(unique(riskscore[,c(1,4)])[,2],breaks=100, xlab="AAMR risk scores for RefSeq genes", main=NULL)
          
          abline(v=allscore(),col="red")
          
          
  })      
        
        
   
        
  ###interval level
  my_data <- eventReactive(input$go,{
          if(input$hg=="GRCh37_hg19"){
          df <-  prediction_hg19(input$GI5,input$GI3)
          
          }else {
          df <- prediction_hg38(input$GI5,input$GI3)
          
          }
          })

  output$table1 <- renderTable({
       my_data()       
     }, include.rownames = FALSE)
  
  
  
})

