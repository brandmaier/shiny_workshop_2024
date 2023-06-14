library(shiny)
library(tidyverse)
library(palmerpenguins)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Penguins"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            # <-------   here go input elements
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("plot1"),
           plotOutput("plot2"),
           textOutput("text1")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$plot1 <- renderPlot({
       penguins %>% ggplot(aes(x=body_mass_g,y=bill_length_mm))+
        geom_point()+
        geom_smooth(method = "lm")
    })
    
    output$plot2 <- renderPlot({
      penguins %>% ggplot(aes(x=flipper_length_mm))+geom_histogram()
    })
    
    output$text1 <- renderText({
      paste0("There are ",nrow(penguins), " penguins in the data set")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
