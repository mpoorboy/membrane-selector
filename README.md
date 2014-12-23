membrane-selector
=================
A styled Shiny/gVis datatable for the selection of flat sheet membrane filters.

* View app: https://mpoorboy.shinyapps.io/FS_Selector/

global.R:
      #dependencies
        library(googleVis)
        library(shiny)
        library(ggplot2)
      #get data
        fs <- read.csv("FlatSheets.csv", header=TRUE)

server.R

    shinyServer(function(input, output) {
    #style function
        myOptions <- reactive({list(chartid = "mytable", cssClassNames = 
         "{headerRow: 'myTableHeadrow', tableRow: 'myTablerow'}", width=1200, height=500)
                })
    #table object
          output$table <- renderGvis({  
              gvisTable(options=myOptions(), {
    #selectInput object
                data <- fs
                  if (input$MWCO != "All"){
                        data <- data[data$MWCO == input$MWCO,]}
                  if (input$Process != "All"){
                        data <- data[data$Process == input$Process,]}
                  if (input$Feed != "All"){
                        data <- data[data$Feed == input$Feed,]}
                        data})
                        })
                })

ui.R

    shinyUI(fluidPage(navbarPage(
    #navbar style
          div(class="navbar navbar-static-top navbar", 
          div(class = 'navbar-inner', span(class ='brand pull-left',
          list(img(src='scicon.jpg', width="30", height="30", 
          style="padding-right:10px;",'Flat Sheet Selector'))
                 ))),
    #dropdowns
        tabPanel("Table", fluidRow(
                column(3, selectInput("MWCO", "MWCO:",
                c("All", unique(as.character(fs$MWCO))
                 ))),
                column(3, selectInput("Process", "Process:",
                c("All", unique(as.character(fs$Process))
                 ))),
                column(3,selectInput("Feed", "Feed:", c("All",
                unique(as.character(fs$Feed))
                 )))
                 )),
    #table style
          fluidRow(
            htmlOutput("table"),tags$head(tags$style(
            type="text/css", ".myTableHeadrow {padding:1px; text-shadow: 1px 1px 1px #000000;
            font-weight: bold; color:#e3e3e3; font-size:1.05em;background: #fff
            url(img/ui-bg_diagonals-thick_22_3a5287_40x4.png) repeat-x left bottom;
            box-shadow: 10px 10px 5px #888888;} .myTablerow {background:linear-gradient(to bottom,
            #bdd2db 0%,#ffffff 100%);}"))
                )
            )
        ))
