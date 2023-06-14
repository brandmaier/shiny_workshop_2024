library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Value boxes"),
  dashboardSidebar(),
  dashboardBody(
    fluidRow(
      # A static valueBox
      valueBox(20, "New Orders", icon = icon("credit-card")),
      
      # Dynamic valueBox
      valueBoxOutput("progressBox"),
      
    ),
    fluidRow(
      # Clicking this will increment the progress amount
      box(width = 4, actionButton("count", "Do some work"))
    )
  )
)

server <- function(input, output) {
  output$progressBox <- renderValueBox({
    
    if (input$count < 10) {
      ic <- icon("thumbs-down")
      col <- "red"
    } else {
      ic <- icon("thumbs-up") 
      col <- "green"
    }
    
    valueBox(
      paste0(input$count, "%"), "Progress", icon = ic,
      color = col
    )
  })
  

}

shinyApp(ui, server)