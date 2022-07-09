ui <- fluidPage(
    mainPanel(
        verbatimTextOutput("build_app"),
        verbatimTextOutput("build_data"),
        dataTableOutput('table'),
        sliderInput("obs",
                    "Number of observations:",
                    min = 1,
                    max = 5000,
                    value = 100),
        plotOutput("distPlot"),
        h2("Modules example"),
        exampleModuleUI("examplemodule1", "Click counter #1"),
        exampleModuleUI("examplemodule2", "Click counter #2"),

        h2("Sorting example"),
        sliderInput("size", "Data size", min = 5, max = 20, value = 10),
        div("Lexically sorted sequence:"),
        verbatimTextOutput("sequence")
    )
)
