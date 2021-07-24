
navbarPage("Sutter-Steamboat Routing",
           tabPanel("App",
                    sidebarLayout(
                      sidebarPanel(
                        checkboxInput("sac_sliders", "Sacramento sliders"),
                        conditionalPanel(condition = 'input.sac_sliders',
                                         sliderInput("S_sac1", "Sac1 Survival", min = slider_min, 
                                                     max = slider_max, value = 0.9, step = slider_step),
                                         sliderInput("S_sac2", "Sac2 Survival", min = slider_min, 
                                                     max = slider_max, value = 0.9, step = slider_step),
                                         sliderInput("S_sac3", "Sac3 Survival", min = slider_min, 
                                                     max = slider_max, value = 0.7, step = slider_step),
                                         sliderInput("S_sac4", "Sac4 Survival", min = slider_min, 
                                                     max = slider_max, value = 0.7, step = slider_step)),
                        checkboxInput("ss_sliders", "Sutter-Steamboat sliders"),
                        conditionalPanel(condition = 'input.ss_sliders',
                                         sliderInput("S_sut", "Sutter Survival", min = slider_min, 
                                                     max = slider_max, value = 0.7, step = slider_step),
                                         sliderInput("S_steam1", "Steam1 Survival", min = slider_min, 
                                                     max = slider_max, value = 0.7, step = slider_step),
                                         sliderInput("S_steam2", "Steam2 Survival", min = slider_min, 
                                                     max = slider_max, value = 0.7, step = slider_step)),
                        checkboxInput("geo_sliders", "Georgiana sliders"),
                        conditionalPanel(condition = 'input.geo_sliders',
                                         sliderInput("S_geo", "Georgiana/Interior Delta Survival", min = slider_min, 
                                                     max = slider_max, value = 0.15, step = slider_step),
                                         sliderInput("P_geo", "Georgiana Entrainment", min = slider_min, 
                                                     max = slider_max, value = 0.4, step = slider_step))
                      ),
                      
                      # Show a plot of the generated distribution
                      mainPanel(
                        plotOutput("pchipps"),
                        br(),
                        helpText("Diamond symbol indicates maximum survival to Chipps Island given survival 
                                     and routing settings in the sidebar panel.")
                      )
                    )
           ),
           tabPanel("About",
                    withMathJax(),
                    fluidRow(
                      column(width = 3, offset = 1,
                             img(src = "SutterSteamboatDiagram.png", width = 250, height = 495)
                      ),
                      column(8,
                             helpText('Sutter Route
                             $$N_{Sutter} = N * P_{Sutter} * S_{Sutter} * S_{Steam2} * S_{Sac4}$$'),
                             helpText('Steamboat Route
                             $$N_{Steam} = N * (1 - P_{Sutter}) * S_{Sac1} * P_{Steam} * 
                             S_{Steam1} * S_{Steam2} * S_{Sac4}$$'),
                             helpText('Sacramento Route
                             $$N_{Sac} = N * (1 - P_{Sutter}) * S_{Sac1} * (1 - P_{Steam}) * 
                             S_{Sac2} * (1 - P_{Geo}) * S_{Sac3} * S_{Sac4}$$'),
                             helpText('Georgiana/Interior Delta Route
                             $$N_{Geo/ID} = N * (1 - P_{Sutter}) * S_{Sac1} * (1 - P_{Steam}) * 
                             S_{Sac2} * P_{Geo} * S_{Geo/ID}$$'),
                             helpText('Proportion Surviving to Chipps Island
                             $$(N_{Sutter} + N_{Steam} + N_{Sac} + N_{Geo/ID}) / N$$')
                      )
                    )
           )
)

