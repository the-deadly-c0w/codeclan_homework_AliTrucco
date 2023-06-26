library(shiny)
library(tidyverse)

gamermode <- CodeClanData::game_sales

ui <- fluidPage(
  
  br(),
  
  fluidRow(
    column(width = 6,
           selectInput("year_in",
                       "Select Year",
                       choices = sort(unique(gamermode$year_of_release)))
           
    ),
    
    
    # change the x axis of the graph to a new column
    column(width = 6,
           radioButtons("category_in",
                        "Select Category",
                        choices = c("genre", "publisher", "developer", "platform"))
           
           
    )
  ),
  fluidRow(
    plotOutput("developer_barplot")
  ),
  
  
  fluidRow(
    radioButtons("score_in",
                 "Which Score?",
                 choices = c("user_score", "critic_score"))
  ),
  
  fluidRow(
    plotOutput("score_pointplot")
  )
)

server <- function(input, output, session) {
  
  output$developer_barplot <- renderPlot({
    gamermode %>% 
      filter(year_of_release == input$year_in) %>% 
      
    # .by input$category_in with aes(input$category_in) was not working as I 
    # could not find a way to turn the input from a string to an object name.
      summarise(total_sales = sum(sales), .by = developer) %>% 
      ggplot() +
      aes(developer, total_sales) +
      geom_col()
  })
  
  
  output$score_pointplot <- renderPlot({
    gamermode %>% 
      ggplot() + 
      aes(log(sales), user_score) +
      geom_point() +
      geom_smooth(method = "lm")
  })
}

shinyApp(ui, server)