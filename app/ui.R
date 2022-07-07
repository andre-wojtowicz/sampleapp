ui <- fluidPage(
    mainPanel(
        dataTableOutput('table'),
        sliderInput("obs",
                    "Number of observations [DEV]",
                    min = 1,
                    max = 5000,
                    value = 100),
        plotOutput("distPlot")
    )
)
