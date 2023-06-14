library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Calculator"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            numericInput("n1",
                        "Number", value=0),
            numericInput("n2",
                         "Number", value=0)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           textOutput("result")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$result <- renderText({
        return(input$n1+input$n2)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
