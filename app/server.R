server <- function(input, output) {
    output$distPlot <- renderPlot({
        dist <- rnorm(input$obs)
        hist(dist, col="purple", xlab="Random values")
    })

    output$table <- renderDataTable(df)

    output$build_app <- renderText({ paste("app:", build_yml$app) })
    output$build_data <- renderText({ paste("data:", build_yml$data) })
}
