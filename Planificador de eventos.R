library(shiny)


ui <- fluidPage(
  titlePanel("Planificador de Eventos"),
  sidebarLayout(
    sidebarPanel(
      textInput("nombre", "Nombre del Evento:"),
      selectInput("tema", "Tema de Evento:", c("Boda", "Fiesta de Cumpleaños", "Conferencia", "Otro")),
      numericInput("invitados", "Número de Invitados:", min = 25, max = 120, value = 25),
      selectInput("provincia", "Provincia:", c("San José", "Alajuela", "Cartago", "Heredia", "Guanacaste", "Puntarenas", "Limón")),
      actionButton("submit", "Planificar Evento")
    ),
    mainPanel(
      div(style = "text-align: center;",
      h2(style = "color: blue;", "Vamos a planificar tu día especial!"),
      tags$hr(style = "border-color: blue;")),
      div(style = "display: inline-block; margin-left: 20px;",
          h4(style = "font-size: 25px;","Detalles del evento:"),
          h4("Nombre del Evento:"),
          textOutput("nombre_output"),
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


server <- function(input, output) {
  observeEvent(input$submit, {
    output$nombre_output <- renderText({ input$nombre })
    output$tema_output <- renderText({ input$tema })
    output$invitados_ubicacion_output <- renderText({
      paste("El evento ", input$nombre, "con el tema ", input$tema, "tendrá", input$invitados, "invitados y se llevará a cabo en", input$provincia, ".")
    })
  })
}


shinyApp(ui = ui, server = server)
.