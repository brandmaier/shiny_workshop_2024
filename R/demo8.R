library(shiny)
library(tidyverse)
library(ggraph)
library(tidygraph)



# Define UI for application
ui <- fluidPage(

    # Application title
    titlePanel("Social Network"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("radius",
                        "Node radius",
                        min = 1,
                        max = 50,
                        value = 30),
            
            selectInput("style","Layout",c("dendrogram","stress","circlepack"))
        ),

        # Show  outputs
        mainPanel(
           plotOutput("graphPlot",width = "600px"),
           textOutput("description")
        )
    )
)


server <- function(input, output) {

  # load data
  graph <- as_tbl_graph(highschool)
  
  output$graphPlot <- renderPlot({
       
      ggraph(graph(), layout = "dendrogram") + 
        geom_edge_link() + 
        geom_node_circle(aes(r=input$radius/100.0),fill="black")+
        ggraph::theme_graph()
      
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
