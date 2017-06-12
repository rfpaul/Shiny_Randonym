# server.R
#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(babynames)

# Define server logic for displaying randomly generated names
shinyServer(function(input, output) {
  buildNames <- unique(babynames$name)
  # buildNames <- buildNames[grep(input$pattern, buildNames)]
  output$nameList <- renderText({
    sort(sample(buildNames, input$nsize))
  })
})
