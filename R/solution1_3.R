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
            selectInput("operator","Operator",c("+","-","/","*")),
            numericInput("n2",
                         "Number", value=0)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           shiny::h2("Result:"),
           htmlOutput("result")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$result <- renderText({
       result <- switch (input$operator,
          "+" = input$n1+input$n2,
          "-" = input$n1-input$n2,
          "/" = input$n1/input$n2,
          "*" = input$n1*input$n2
        )
       
       result <- paste0("<h2>",result,"</h2>")
       
        return(result)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
