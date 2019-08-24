#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  titlePanel("Lab1-Part3"),
  
  navlistPanel(
    "Comparisions",
    tabPanel("Influenza Vs CDC",
             h6("Influenza Vs CDC", br(), 
                tags$img(src="Capture2.JPG", height=400, width=500),
                tags$img(src="Capture1.JPG",height=400, width=500)
             )
             
    ),
    tabPanel("Flu Vs CDC",
             h6("Flu Vs CDC", br(), 
                tags$img(src="Capture3.JPG", height=400, width=500),
                tags$img(src="Capture1.JPG",height=400, width=500)
             )
             
    ),
    tabPanel("All keywords Vs CDC",
             # h3("This is the third panel")
             h6("All keywords Vs CDC", br(), 
                tags$img(src="Capture4.JPG", height=400, width=500),
                tags$img(src="Capture1.JPG",height=400, width=500)
             )
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
}

# Run the application 
shinyApp(ui = ui, server = server)

