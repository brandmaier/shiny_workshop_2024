library(shiny)
library(tidyverse)
library(ggraph)
library(tidygraph)



# Define UI for application that draws a histogram
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
            
            selectInput("style","Layout",c("dendrogram","stress"))
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("graphPlot",width = "600px"),
           textOutput("description")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  graph <- reactive({
    
    set.seed(39548)
    
    play_erdos_renyi(n = 10, p = 0.2) %>% 
      activate(nodes) %>% 
      mutate(class = sample(letters[1:4], n(), replace = TRUE)) %>% 
      activate(edges) %>% 
      arrange(.N()$class[from]) %>%
      mutate(class = sample(letters[1:2], n(), replace = TRUE))
  })
  
    output$graphPlot <- renderPlot({
       
      ggraph(graph(), layout = "dendrogram") + 
        geom_edge_link() + 
        geom_node_circle(aes(r=input$radius/100.0),fill="black")+
        ggraph::theme_graph()
      
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
