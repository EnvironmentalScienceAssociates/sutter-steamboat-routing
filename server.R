
function(input, output) {
    
    # N at Chipps Island via Sutter route
    N_chipps_sut <- reactive({
        N * P_sut * input$S_sut * input$S_steam2 * input$S_sac4
    })
    
    N_chipps_steam <- reactive({
        N * (1 - P_sut) * input$S_sac1 * P_steam * input$S_steam1 * input$S_steam2 * input$S_sac4
    })
    
    N_chipps_sac <- reactive({
        N * (1 - P_sut) * input$S_sac1 * (1 - P_steam) * input$S_sac2 * (1 - input$P_geo) * input$S_sac3 * input$S_sac4
    })
    
    N_chipps_geo <- reactive({
        N * (1 - P_sut) * input$S_sac1 * (1 - P_steam) * input$S_sac2 * input$P_geo * input$S_geo
    })
    
    chipps_prop <- reactive({
        tibble(P_sut = P_sut,
               P_steam = P_steam,
               N_chipps = N_chipps_sut() + N_chipps_steam() + N_chipps_sac() + N_chipps_geo(),
               Prop_chipps = N_chipps/N) 
    })
    
    output$pchipps <- renderPlot({
        cp = chipps_prop()
        cp_max = filter(cp, Prop_chipps == max(Prop_chipps))
        ggplot(chipps_prop(), aes(x = P_sut, y = P_steam)) +
            geom_tile(aes(fill = Prop_chipps)) +
            geom_point(data = cp_max, shape = 18, size = 4) +
            scale_fill_viridis_c(name = "Proportion\nsurviving to\nChipps Island") +
            labs(x = "Proportion entrained in Sutter Slough",
                 y = "Proportion entrained in Steamboat Slough") +
            theme_minimal() + 
            theme(
                legend.text = element_text(size = 12),
                legend.title = element_text(size = 14),
                axis.title = element_text(size = 14),
                axis.text = element_text(size = 12)
            )
    })
}

