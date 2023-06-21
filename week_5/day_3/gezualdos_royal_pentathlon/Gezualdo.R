

library(shiny)
library(ggplot2)
library(fmsb)
library(plotly)
library(tidyverse)


champions <- read_csv("champions.csv")

colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4) )





ui <- fluidPage(
  
  
  titlePanel("Gezualdo's Royal Pentathlon"),
  
  sidebarLayout(
    sidebarPanel(
      
      radioButtons(inputId = "season_input",
                   label = "Bootus or Lootus?!?!",
                   choiceNames = c("Bootus", "Lootus"),
                   choiceValues = c("Summer", "Winter"),),
      
      br(),
      
      selectInput(inputId = "fighter_input",
                  label = "Choose Your Fighter",
                  choices = c("Glimbus", "Dorply-Lwyd", "Ghengis", "Shmebuloc")
                  
      )
    ), 
    
    mainPanel(
      "shebedee bloo",
      
      plotOutput("champion_plot")
    )
  ),
  
  
  mainPanel(
    
  )
)



server <- function(input, output) {
  output$champion_plot <- renderPlot({
    
    champions %>% 
      filter(name %in% c("0","20",input$fighter_input)) %>% 
      select(2:6) %>% 
      radarchart(axistype=1 , 
                 pcol =colors_border , pfcol=colors_in , plwd=4 , plty=1,
                 cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,20,5), cglwd=0.8,
                 vlcex=0.8 
      )
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
