library(googleVis)
library(shiny)
library(ggplot2)
fs <- read.csv("FlatSheets.csv", header=TRUE)
shinyServer(function(input, output) {
  myOptions <- reactive({
    list(
      chartid = "mytable",
      cssClassNames = 
      "{headerRow: 'myTableHeadrow', tableRow: 'myTablerow'}",
      width=1200,
      height=500
    )
  })
  output$table <- renderGvis({
    gvisTable(options=myOptions(), {
      data <- fs
      if (input$MWCO != "All"){
        data <- data[data$MWCO == input$MWCO,]
      }
      if (input$Process != "All"){
        data <- data[data$Process == input$Process,]
      }
      if (input$Feed != "All"){
        data <- data[data$Feed == input$Feed,]
      }
      data
      })
    })
  })