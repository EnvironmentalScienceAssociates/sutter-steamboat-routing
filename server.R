
function(input, output) {
    
    S_sutter <- reactive({
        input$S_sut * input$S_steam2 * input$S_sac4
    })
    
    # N at Chipps Island via Sutter route
    N_chipps_sut <- reactive({
        N_court * P_sut * S_sutter()
    })
    
    S_steam <- reactive({
        input$S_sac1 * input$S_steam1 * input$S_steam2 * input$S_sac4
    })
    
    N_chipps_steam <- reactive({
        N_court * (1 - P_sut) * P_steam * S_steam()
    })
    
    S_sac <- reactive({
        input$S_sac1 * input$S_sac2 * input$S_sac3 * input$S_sac4
    })
    
    N_chipps_sac <- reactive({
        N_court * (1 - P_sut) * (1 - P_steam) * (1 - input$P_geo) * S_sac()
    })
    
    S_geo <- reactive({
        input$S_sac1 * input$S_sac2 * input$S_geo
    })
    
    N_chipps_geo <- reactive({
        N_court * (1 - P_sut) * (1 - P_steam) * input$P_geo * S_geo()
    })
    
    chipps_prop <- reactive({
        tibble(P_sut = P_sut,
               P_steam = P_steam,
               N_chipps = N_chipps_sut() + N_chipps_steam() + N_chipps_sac() + N_chipps_geo(),
               Prop_chipps = round(N_chipps/N_court, 2)) 
    })
    
    output$chippsSurvival <- renderPlotly({
        cp = chipps_prop()
        plot_ly(x = cp$P_sut, y = cp$P_steam, z = cp$Prop_chipps, type = "heatmap") |> 
            layout(title="Overall Survival to Chipps Island",
                   xaxis = list(title = "Sutter Slough Entrainment"),
                   yaxis = list(title = "Steamboat Slough Entrainment"))
    })
    
    output$sutterSurvival <- renderText({
        glue::glue("Sutter: {round(S_sutter(), 2)}")
    })
    
    output$steamSurvival <- renderText({
        glue::glue("Steamboat: {round(S_steam(), 2)}")
    })
    
    output$sacSurvival <- renderText({
        glue::glue("Sacramento: {round(S_sac(), 2)}")
    })
    
    output$geoSurvival <- renderText({
        glue::glue("Georgiana/Interior Delta: {round(S_geo(), 2)}")
    })
}

