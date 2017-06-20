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
    sidebarPanel( h4("Settings"),
                  sliderInput("nsize", "Number of names to list:", 1, 50, 15),
                  # Props are * 100 to display as a percentage
                  sliderInput("props", "Popularity (within a single year):",
                              min = 2e-04, 
                              max = 2,
                              value = c(2.2e-04, 2),
                              dragRange = TRUE,
                              #ticks = FALSE,
                              sep = '',
                              post = '%'),
                  radioButtons("sex", label = "Associated with:",
                               choices = list("Male births" = 'M',
                                              "Female births" = 'F',
                                              "Either" = 'E'),
                               selected = 'E'),
                  sliderInput("years", "Found in years:",
                              min = 1880,
                              max = 2014,
                              value = c(1880, 2014),
                              dragRange = TRUE,
                              ticks = FALSE,
                              sep = ''),
                  fixedRow (
                    column(width = 8,
                           textInput("pattern",
                                     "Matches pattern:",
                                     value = "")),
                    column(width = 1,
                           style='padding-top:25px;padding-left:0px;',
                           offset = 0,
                           actionButton("goPattern",
                               label = NULL,
                               icon = icon('filter')))
                    )
                  ),
    mainPanel( h4("Results"), 
              align = "center",
              tableOutput("nameList"))
  )
))
