# ui.R
#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Randonym"),
  
  sidebarLayout( position = "left",
    sidebarPanel( "Settings",
                  sliderInput("nsize", "Number of names to list:", 1, 50, 15)#,
                  #textInput("pattern", "Contains...", value = "")
                  ),
    mainPanel("Results", 
              align = "center",
              textOutput("nameList"))
  )
))
