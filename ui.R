library(shiny)
shinyUI(fluidPage(
  h1("AluAluCNVpredictor", style="color:darkcyan"),  #darkcyan
  p("Lupski lab",style="color:dimgray;font-size: 20px"),
  hr(),
  
  p("Gene-level prediction",style="color:darkcyan;font-size: 15px"),
 
  wellPanel(fluidRow(
          column(2,textInput('geneID', 'Gene Name', value = "")),
          column(3,br(),
                 textOutput('textallAlu'),
                 textOutput('textCNVAlu'),
                 br(),
                 textOutput('textMIMID'),
                 textOutput('textMIMscore'),
                 textOutput('textMIMrnk'),
                 br(),
                 textOutput('textallscore'),
                 textOutput('textallrank')),
          column(3, plotOutput('hist1', height="200px")),
          column(3, plotOutput('hist2', height="200px")))),
       
              
  p("Interval-level prediction",style="color:darkcyan;font-size: 15px"),
         
          
          sidebarLayout(
                sidebarPanel(
                        selectInput('hg',"Reference Genome Assembly:", 
                                    choices=c("GRCh37_hg19","GRCh38_hg38")),
                        helpText("Query any predicted CNV-Alu pairs intersecting your regions of interest"),
                        helpText("format:chr:start-end"),
                        tags$style(type="text/css", "textarea {width:100%}") ,
                        tags$textarea(id="GI5", rows=5, placeholder = c("Enter the 5' Genomic Interval:")),
                        tags$style(type="text/css", "textarea {width:100%}") ,
                        tags$textarea(id="GI3", rows=5, placeholder = c("Enter the 3' Genomic Interval:")),
                        actionButton('go', 'Search'),width = 3) ,
                mainPanel(
                        tableOutput('table1')  )
         
  )))

        
        
        
        
        
        
