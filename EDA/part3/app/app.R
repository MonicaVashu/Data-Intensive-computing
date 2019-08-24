#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(dplyr)
library(choroplethr)
library(choroplethrMaps)
library(ggplot2)
library(maptools)
library(ggpubr)


dt1<-read.csv("fluORInfluenzaKeywordCleanData.csv")
flu_data1 <- data.frame(STATENAME=dt1$State)
occurences1 <- data.frame(table(unlist(flu_data1)))
occurences1$Var1 <- tolower(occurences1$Var1)

dt2<-read.csv("influenzaKeywordCleanData.csv")
flu_data2 <- data.frame(STATENAME=dt2$State)
occurences2 <- data.frame(table(unlist(flu_data2)))
occurences2$Var1 <- tolower(occurences2$Var1)

dt3<-read.csv("fluKeywordCleanData2.csv")
flu_data3 <- data.frame(STATENAME=dt3$State)
occurences3 <- data.frame(table(unlist(flu_data3)))
occurences3$Var1 <- tolower(occurences3$Var1)

dt4FluVaccine<-read.csv("MyDataforfluvaccineCleaned.csv")
flu_data4FluVaccine <- data.frame(STATENAME=dt4FluVaccine$State)
occurences4FluVaccine <- data.frame(table(unlist(flu_data4FluVaccine)))
occurences4FluVaccine$Var1 <- tolower(occurences4FluVaccine$Var1)

dt5InfluenzaVirus<-read.csv("MyDataforinfluenzavirusCleaned.csv")
flu_data5InfluenzaVirus <- data.frame(STATENAME=dt5InfluenzaVirus$State)
occurences5InfluenzaVirus <- data.frame(table(unlist(flu_data5InfluenzaVirus)))
occurences5InfluenzaVirus$Var1 <- tolower(occurences5InfluenzaVirus$Var1)

dt5<-read.csv("StateDataforMap_2018-19week4.csv")
occurences5 <- data.frame(state=dt5$STATENAME, ACTIVITY.LEVEL = dt5$ACTIVITY.LEVEL)
occurences5$state <- tolower(occurences5$state)
occurences5$ACTIVITY.LEVEL <- as.character(occurences5$ACTIVITY.LEVEL)
occurences5$ACTIVITY.LEVEL[occurences5$ACTIVITY.LEVEL == "Level 1"] <- "1"
occurences5$ACTIVITY.LEVEL[occurences5$ACTIVITY.LEVEL == "Level 2"] <- "2"
occurences5$ACTIVITY.LEVEL[occurences5$ACTIVITY.LEVEL == "Level 3"] <- "3"
occurences5$ACTIVITY.LEVEL[occurences5$ACTIVITY.LEVEL == "Level 4"] <- "4"
occurences5$ACTIVITY.LEVEL[occurences5$ACTIVITY.LEVEL == "Level 5"] <- "5"
occurences5$ACTIVITY.LEVEL[occurences5$ACTIVITY.LEVEL == "Level 6"] <- "6"
occurences5$ACTIVITY.LEVEL[occurences5$ACTIVITY.LEVEL == "Level 7"] <- "7"
occurences5$ACTIVITY.LEVEL[occurences5$ACTIVITY.LEVEL == "Level 8"] <- "8"
occurences5$ACTIVITY.LEVEL[occurences5$ACTIVITY.LEVEL == "Level 9"] <- "9"
occurences5$ACTIVITY.LEVEL[occurences5$ACTIVITY.LEVEL == "Level 10"] <- "10"
occurences5$ACTIVITY.LEVEL <- as.numeric(occurences5$ACTIVITY.LEVEL)
colnames(occurences5) <- c("region", "value")

# Define UI for application that draws a histogram
ui <- fluidPage(title = 'Comparisions of Charts',
                # theme = shinythemes::shinytheme('flatly'),
                navlistPanel(
                  "Comparisions",
                  tabPanel('All Keywords VS CDC Heatmap',br(),
                            plotOutput(outputId = "map1"), br(),
                           plotOutput(outputId = "map5")),
                  tabPanel('Influenza VS CDC',br(),
                                plotOutput(outputId = "map2"), br(),
                           plotOutput(outputId = "map6")),
                  tabPanel('Flu VS CDC',br(),
                           plotOutput(outputId = "map3"), br(),
                           plotOutput(outputId = "map7")),
                  tabPanel('Flu VS Influenza',br(),
                           plotOutput(outputId = "map4"), br(),
                           plotOutput(outputId = "map8")),
                  tabPanel('Flu Vaccine VS Flu',br(),
                           plotOutput(outputId = "map9"), br(),
                           plotOutput(outputId = "map10")),
                  tabPanel('Influenza Virus VS Influenza',br(),
                           plotOutput(outputId = "map11"), br(),
                           plotOutput(outputId = "map12"))
                
                ))
               
# Define server logic required 
server <- function(input, output) {
  output$map1 <- renderPlot({
    colnames(occurences1) <- c("region", "value")
    state_choropleth(occurences1, title = "All Keywords HeatMap", num_colors = 9, 
                     legend = "Frequency of Tweets")
  })
  output$map2 <- renderPlot({
    colnames(occurences2) <- c("region", "value")
    state_choropleth(occurences2, title = "Influenza Keywords HeatMap", num_colors = 9, 
                     legend = "Frequency of Tweets")
  })
  output$map3 <- renderPlot({
    colnames(occurences3) <- c("region", "value")
    state_choropleth(occurences3, title = "Flu Keywords HeatMap", num_colors = 9, 
                     legend = "Frequency of Tweets")
  })
  output$map4 <- renderPlot({
    colnames(occurences3) <- c("region", "value")
    state_choropleth(occurences3, title = "Flu Keywords HeatMap", num_colors = 9, 
                     legend = "Frequency of Tweets")
  })
  output$map5 <- renderPlot({
    colnames(occurences5) <- c("region", "value")
    state_choropleth(occurences5, title = "CDC Heatmap(Week 4)", num_colors = 9, 
                     legend = "ILI activity level")
  })
  output$map6 <- renderPlot({
    colnames(occurences5) <- c("region", "value")
    state_choropleth(occurences5, title = "CDC Heatmap(Week 4)", num_colors = 9, 
                     legend = "ILI activity level")
  })
  output$map7 <- renderPlot({
    colnames(occurences5) <- c("region", "value")
    state_choropleth(occurences5, title = "CDC Heatmap(Week 4)", num_colors = 9, 
                     legend = "ILI activity level")
  })
  output$map8 <- renderPlot({
    colnames(occurences2) <- c("region", "value")
    state_choropleth(occurences2, title = "Influenza Keywords HeatMap", num_colors = 9, 
                     legend = "Frequency of Tweets")
  })
  output$map9 <- renderPlot({
    colnames(occurences4FluVaccine) <- c("region", "value")
    state_choropleth(occurences4FluVaccine, title = "Flu Vaccine Keywords HeatMap", num_colors = 9, 
                     legend = "Frequency of Tweets")
  })
  output$map10 <- renderPlot({
    colnames(occurences3) <- c("region", "value")
    state_choropleth(occurences3, title = "Flu Keyword HeatMap", num_colors = 9, 
                     legend = "Frequency of Tweets")
  })
  output$map11 <- renderPlot({
    colnames(occurences5InfluenzaVirus) <- c("region", "value")
    state_choropleth(occurences5InfluenzaVirus, title = "Influenza Virus Keywords HeatMap", num_colors = 9, 
                     legend = "Frequency of Tweets")
  })
  output$map12 <- renderPlot({
    colnames(occurences2) <- c("region", "value")
    state_choropleth(occurences2, title = "Influenza Keyword HeatMap", num_colors = 9, 
                     legend = "Frequency of Tweets")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

