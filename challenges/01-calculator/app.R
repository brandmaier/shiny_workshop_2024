#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

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
                         "Number", value=0),
            selectInput("operation","Operator",c("+","-"))
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
