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
  # Restrict by proportions, note that percentages are being divided by 100
  propFiltered <- reactive({
    babynames[babynames$prop >= (input$props[1] / 100) & 
              babynames$prop <= (input$props[2] / 100),]
  })
  
  # Restrict by associated sex
  
  sexFiltered <- reactive({
    if (input$sex != 'E')
      propFiltered()[propFiltered()$sex == input$sex,]
    else
      propFiltered()
  })
  
  # Restrict by year
  yearFiltered <- reactive(
    sexFiltered()$name[sexFiltered()$year >= (input$years[1]) & 
                       sexFiltered()$year <= (input$years[2])]
  )
  
  # Unique names only
  uniqueNames <- reactive({
    unique(yearFiltered())
  })
  
  # Grep the input name pattern
  # Reactive to the pattern input box
  grepNames <- eventReactive (input$goPattern, ignoreNULL = FALSE, {
    uniqueNames()[grep(input$pattern, uniqueNames())]
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
      # Fill out each empty columnS at the end with an empty string
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
