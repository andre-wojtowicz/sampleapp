server <- function(input, output, session) {

    exampleModuleServer("examplemodule1")
    exampleModuleServer("examplemodule2")

    output$distPlot <- renderPlot({
        dist <- rnorm(input$obs)
        hist(dist, col="purple", xlab="Random values")
    })

    output$table <- renderDataTable(df)

    output$build_app <- renderText({ paste("app:", build_yml$app) })
    output$build_data <- renderText({ paste("data:", build_yml$data) })

    data <- reactive({
        # lexical_sort from R/example.R
        lexical_sort(seq_len(input$size))
    })
    output$sequence <- renderText({
        paste(data(), collapse = " ")
    })
}
