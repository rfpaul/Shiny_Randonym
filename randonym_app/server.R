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
  # Unique names only
  uniqueNames <- unique(babynames$name)
  
  # Grep the input name pattern
  grepNames <- reactive ({
  uniqueNames[grep(input$pattern, uniqueNames)]
  })
  
  # Set the sample size ceiling if input list N size is larger 
  # than grepNames length
  sampleSize <- reactive(
    if (input$nsize > length(grepNames())) length(grepNames()) else input$nsize
    )
  
  # Create the sorted sample list of names
  buildNames <- reactive ({
    sort(sample(grepNames(), sampleSize()))
  })
  
  # Padding to add to vector to break evenly into 3 columns
  padCells <- reactive( 
    if (sampleSize() %% 3 > 0) 3 - (sampleSize() %% 3) else 0
    )
  
  # Put names into a 3 column matrix
  formatNames <- reactive ({
    matrix(
      # Fill out each empty columns at the end with an empty string
      c(buildNames(), rep("", padCells())), 
      ncol = 3, 
      byrow = TRUE)
  })
  
  # Render name matrix as a table
  output$nameList <- renderTable(
    formatNames(),
    colnames = FALSE
  )
})
