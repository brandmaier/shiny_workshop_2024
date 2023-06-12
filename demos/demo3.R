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
            sliderInput("rng", "Range ",value=c(3000,5000),min=2700, max=6300),
            selectInput("size", label="Size", choices=c("flipper_length_mm","bill_length_mm")),
            checkboxInput("grp",label="Subgroups", value=TRUE)
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

    penguins_filtered <- reactive({
      penguins %>% filter(body_mass_g >= input$rng[1] & body_mass_g <= input$rng[2])
    })
  
    output$plot1 <- renderPlot({
      
      wf <- NULL
      if (input$grp) {
        wf <- facet_wrap(~species)
      }
      
       penguins_filtered() %>% ggplot(aes(x=body_mass_g,y=bill_length_mm))+
        geom_point(aes_string(size=input$size))+
        geom_smooth(method = "lm")+
        wf
    })
    
    output$plot2 <- renderPlot({
      if (input$grp) {
        penguins_filtered() %>% ggplot(aes(x=flipper_length_mm,fill=species))+geom_histogram()
      } else {
        penguins_filtered() %>% ggplot(aes(x=flipper_length_mm))+geom_histogram()
      }

    })
    
    output$text1 <- renderText({
      paste0("There are ",nrow(penguins_filtered()), " penguins in the data set")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
