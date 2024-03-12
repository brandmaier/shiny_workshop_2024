library(shiny)
library(dplyr)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Is this normal?"),
  
  fluidRow(
    column(12,
           numericInput(inputId="n",label = "Sample size",value=100,min=5,max=100),
           plotOutput(outputId = "result"), 
           shiny::actionButton(inputId = "yes", label="Yes"),
           shiny::actionButton(inputId = "no", label="No"),
           htmlOutput(outputId = "msg")
    )
  )
  
  
)


server <- function(input, output) {
  

  values <- reactiveValues(normal = 1, status = "")
  
  observe({
    input$yes
    cat("YES\n")
    check(TRUE)
  })
  
  observe({
    input$no
    cat("NO\n")
    check(FALSE)
  })
  
  check <- function(user_choice) {
    if (user_choice == values$normal) {
      values$status <- "<p style='color:green;'>CORRECT!</p>"
    } else {
      values$status <- "<p style='color:red;'>WRONG!</p>"
    }
    
    values$normal <- sample(c(TRUE,FALSE),1)
   
  }
  
  output$result <- renderPlot({
   
   
    if ( values$normal ) {
      dat<-rnorm(input$n)
    } else {
      type = sample(c(1,2,3),1)
      if (type==1) {
        dat<-rchisq(input$n,df = 3)-1
      } else if (type==2) {
        dat<-runif(input$n,-2,2)
      } else if (type==3) {
        dat<-rlogis(input$n)
      }
    }
    dat <- data.frame(dat)
    names(dat) <- c("x")
    dat %>% ggplot(aes(x=x))+geom_density(fill="grey")+geom_point(y=0,size=4)
  })
  
  output$msg <- renderText({
    return(values$status)
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
