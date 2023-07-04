library(shiny)

# Define UI for application
ui <- fluidPage(

    # Application title
    titlePanel("Simulation"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            numericInput("N",
                        "Sample Size", value=100),
            numericInput("r",
                         "Correlation", value=0),
            downloadButton("download")
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("graph")
        )
    )
)

# Define server logic 
server <- function(input, output) {

  sim <- reactive({
    r = input$r
    N = input$N
    
    df <- MASS::mvrnorm(n=N, mu=c(0,0),
                        Sigma=matrix(c(1,r,
                                       r,1),
                                     nrow=2))
    
    df <- data.frame(df)
    names(df) <- c("x","y")
    
    return(df)
  })
  
  output$download = downloadHandler(
    filename = function() {
      "simulation.csv"
    },
    content = function(file) {
      readr::write_csv(sim(), file)
    }
  )
  
    output$graph <- renderPlot({
      
       sim() %>% ggplot(aes(x=x,y=y))+ geom_point()+geom_smooth(method = "lm")
      
    })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
