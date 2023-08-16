library(shiny)

# Define UI
ui <- fluidPage(
  titlePanel("Planificador de Eventos"),
  sidebarLayout(
    sidebarPanel(
      width = 4,
      textInput("nombre", "Nombre del Evento:"),
      selectInput("tema", "Tema de Evento:", c("Boda", "Fiesta de Cumpleaños", "Conferencia", "Otro")),
      numericInput("invitados", "Número de Invitados:", min = 25, max = 120, value = 25),
      selectInput("provincia", "Provincia:", c("San José", "Alajuela", "Cartago", "Heredia", "Guanacaste", "Puntarenas", "Limón")),
      actionButton("submit", "Planificar Evento")
    ),
    mainPanel(
      width = 7,
      div(style = "text-align: center;",
          h2(style = "color: blue;", "Vamos a planificar tu día especial!"),
          tags$hr(style = "border-color: blue;")
      ),
      div(style = "display: inline-block; margin-left: 20px; background-color: #EBF5FB; padding: 10px; border-radius: 5px;",
          h4(style = "font-size: 25px;", HTML("<strong>Detalles del evento:</strong>")),
          div(style = "display: inline-block;",
              h4("Nombre del Evento:"),
              span(style = "display: inline; font-weight: bold;", textOutput("nombre_output"))
          ),
          fluidRow(
            column(6,
                   h4("Tema del Evento:"),
                   textOutput("tema_output")
            )
          ),
          h4("Número de invitados y ubicación:"),
          textOutput("invitados_ubicacion_output")
      )
    )
  )
)

# Define server
server <- function(input, output) {
  observeEvent(input$submit, {
    output$nombre_output <- renderText({ input$nombre })
    output$tema_output <- renderText({ input$tema })
    output$invitados_ubicacion_output <- renderText({
      paste("El evento '", input$nombre, "' con el tema '", input$tema, "' tendrá", input$invitados, "invitados y se llevará a cabo en", input$provincia, ".")
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)
