library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Simulation"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            numericInput("N",
                        "Sample Size", value=100),
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
   # <----- create a simulated dataset here
  })
  
  # return the dataset as file
  output$download = downloadHandler(
    filename = function() {
      "simulation.csv"
    },
    content = function(file) {
      readr::write_csv(sim(), file)
    }
  )
  
    output$graph <- renderPlot({
      
      # <------ do some plotting here
      
    })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
