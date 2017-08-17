library(shiny)
shinyUI(fluidPage(
  h1("AAMR-Predictor", style="color:darkcyan"),
  p("Lupski lab",style="color:dimgray;font-size: 20px"),
  hr(),
  
  p("Gene-level prediction",style="color:darkcyan;font-size: 15px"),
 
  wellPanel(fluidRow(
          column(3,textInput('geneID', 'Gene Name', value = "")),
          column(2,br(),
                 textOutput('textscr'),
                 textOutput('textrnk')),
          column(3, plotOutput('hist', height="200px")))),
       
             

                  
             
  
  p("Interval-level prediction",style="color:darkcyan;font-size: 15px"),
  

  sidebarLayout(
    sidebarPanel(tags$style(type="text/css", "textarea {width:100%}") ,
                 tags$textarea(id="GI5", rows=5, placeholder = paste("Enter the 5' Genomic Interval:","\n", "e.g. chr7:6030502-6030513", sep="")) ,
                 tags$style(type="text/css", "textarea {width:100%}") ,
                 tags$textarea(id="GI3", rows=5, placeholder = paste("Enter the 3' Genomic Interval:","\n", "e.g. chr7:6046140-6046151", sep="")),
                 actionButton('go', 'Search'),width = 3) ,
    mainPanel(
      tableOutput('table1')  )
  )))

