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

# Define UI for application that draws random names based on user input
shinyUI(fluidPage(theme = "bootstrap.min.css",
  # Application title
  titlePanel(h2("Randonym",
                h6("Filter and randomly select first names from the US Social Security database",
                   align = "center"),
                align = "center"),
             windowTitle = "Randonym"),
  # Input sidebar
  sidebarLayout( position = "right",
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
                              step = 1,
                              sep = ''),
                  fluidRow (
                    column(width = 10,
                           class = "col-sm-9 col-xs-9",
                           textInput("pattern",
                                     "Matches pattern:",
                                     value = NULL)),
                    column(width = 1,
                           class = "col-xs-1",
                           style='padding-top:25px;padding-left:0px;',
                           offset = 0,
                           actionButton("goPattern",
                               label = NULL,
                               icon = icon('filter')))
                    )
                  ),
    # Results panel
    mainPanel( h4("Results"), 
              align = "center",
              strong(tableOutput("nameList")))
  )
))
