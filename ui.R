
navbarPage("Sutter-Steamboat Routing",
           tabPanel("App",
                    sidebarLayout(
                      sidebarPanel(
                        checkboxInput("sac_sliders", "Sacramento sliders"),
                        conditionalPanel(condition = 'input.sac_sliders',
                                         sliderInput("S_sac1", "Sac1 Survival", min = slider_min, 
                                                     max = slider_max, value = 0.95, step = slider_step),
                                         sliderInput("S_sac2", "Sac2 Survival", min = slider_min, 
                                                     max = slider_max, value = 0.95, step = slider_step),
                                         sliderInput("S_sac3", "Sac3 Survival", min = slider_min, 
                                                     max = slider_max, value = 0.85, step = slider_step),
                                         sliderInput("S_sac4", "Sac4 Survival", min = slider_min, 
                                                     max = slider_max, value = 0.75, step = slider_step)),
                        checkboxInput("ss_sliders", "Sutter-Steamboat sliders"),
                        conditionalPanel(condition = 'input.ss_sliders',
                                         sliderInput("S_sut", "Sutter Survival", min = slider_min, 
                                                     max = slider_max, value = 0.77, step = slider_step),
                                         sliderInput("S_steam1", "Steam1 Survival", min = slider_min, 
                                                     max = slider_max, value = 0.8, step = slider_step),
                                         sliderInput("S_steam2", "Steam2 Survival", min = slider_min, 
                                                     max = slider_max, value = 0.77, step = slider_step)),
                        checkboxInput("geo_sliders", "Georgiana sliders"),
                        conditionalPanel(condition = 'input.geo_sliders',
                                         sliderInput("S_geo", "Georgiana/Interior Delta Survival", min = slider_min, 
                                                     max = slider_max, value = 0.24, step = slider_step),
                                         sliderInput("P_geo", "Georgiana Entrainment", min = slider_min, 
                                                     max = slider_max, value = 0.35, step = slider_step))
                      ),
                      
                      mainPanel(
                        plotlyOutput("chippsSurvival"),
                        br(),
                        h4("Route-Specific Survival"),
                        textOutput("sutterSurvival"),
                        textOutput("steamSurvival"),
                        textOutput("sacSurvival"),
                        textOutput("geoSurvival")
                      )
                    )
           ),
           tabPanel("About",
                    withMathJax(),
                    # section below allows in-line LaTeX via $ in mathjax.
                    tags$div(HTML("<script type='text/x-mathjax-config' >
                    MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});
                    </script >")),
                    fluidRow(
                      column(width = 3, offset = 1,
                             img(src = "SutterSteamboatDiagram.png", width = 250, height = 495)
                      ),
                      column(width = 8,
                             helpText('Sutter Route
                             $$N_{Sutter} = N_{Court} * P_{Sutter} * S_{Sutter} * S_{Steam2} * S_{Sac4}$$'),
                             hr(),
                             helpText('Steamboat Route
                             $$N_{Steam} = N_{Court} * (1 - P_{Sutter}) * S_{Sac1} * P_{Steam} * 
                             S_{Steam1} * S_{Steam2} * S_{Sac4}$$'),
                             hr(),
                             helpText('Sacramento Route
                             $$N_{Sac} = N_{Court} * (1 - P_{Sutter}) * S_{Sac1} * (1 - P_{Steam}) * 
                             S_{Sac2} * (1 - P_{Geo}) * S_{Sac3} * S_{Sac4}$$'),
                             hr(),
                             helpText('Georgiana/Interior Delta Route
                             $$N_{Geo/ID} = N_{Court} * (1 - P_{Sutter}) * S_{Sac1} * (1 - P_{Steam}) * 
                             S_{Sac2} * P_{Geo} * S_{Geo/ID}$$'),
                             hr(),
                             helpText('Overall Survival to Chipps Island
                             $$(N_{Sutter} + N_{Steam} + N_{Sac} + N_{Geo/ID}) / N_{Court}$$'),
                             hr(),
                             br(),
                             helpText('$N_{Court}$ is the number of fish passing Courtland'),
                             helpText('$N_{X}$ is the number of fish arriving at Chipps Island via the 
                                      route specified in the subscript'),
                             helpText('$P_{X}$ is the probability of entrainment into the 
                                      distributary specified in the subscript'),
                             helpText('$S_{X}$ is the survival through the reach specified in the subscript')
                      )
                    )
           )
)

