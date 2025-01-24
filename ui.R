
page_sidebar(
  title = "Sutter-Steamboat Routing Calculator",
  window_title = "Sutter-Steamboat Routing",
  sidebar = sidebar(
    accordion(
      open = c("Sutter-Steamboat"),
      accordion_panel(
        "Sacramento",
        sliderInput("S_sac1", "Sac1 Survival", min = slider_min, 
                    max = slider_max, value = 0.95, step = slider_step),
        sliderInput("S_sac2", "Sac2 Survival", min = slider_min, 
                    max = slider_max, value = 0.95, step = slider_step),
        sliderInput("S_sac3", "Sac3 Survival", min = slider_min, 
                    max = slider_max, value = 0.85, step = slider_step),
        sliderInput("S_sac4", "Sac4 Survival", min = slider_min, 
                    max = slider_max, value = 0.75, step = slider_step)
      ),
      accordion_panel(
        "Sutter-Steamboat",
        sliderInput("S_sut", "Sutter Survival", min = slider_min, 
                    max = slider_max, value = 0.77, step = slider_step),
        sliderInput("S_steam1", "Steam1 Survival", min = slider_min, 
                    max = slider_max, value = 0.8, step = slider_step),
        sliderInput("S_steam2", "Steam2 Survival", min = slider_min, 
                    max = slider_max, value = 0.77, step = slider_step)
      ),
      accordion_panel(
        "Georgiana",
        sliderInput("S_geo", "Georgiana/Interior Delta Survival", min = slider_min, 
                    max = slider_max, value = 0.24, step = slider_step),
        sliderInput("P_geo", "Georgiana Entrainment", min = slider_min, 
                    max = slider_max, value = 0.35, step = slider_step)
      )
    )
  ),
  navset_card_pill(
    nav_panel(
      title = "Plot",
      layout_columns(
        card(plotlyOutput("chippsSurvival")),
        card(
          card_header("Route-Specific Survival"),
          textOutput("sutterSurvival"),
          textOutput("steamSurvival"),
          textOutput("sacSurvival"),
          textOutput("geoSurvival")
        ),
        col_widths = c(9, 3)
      )
    ),
    nav_panel(
      title = "About",
      withMathJax(),
      # section below allows in-line LaTeX via $ in mathjax.
      HTML("<script type='text/x-mathjax-config' >
                    MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});
                    </script >"),
      layout_columns(
        card(
          helpText('Sutter Route
                             $$N_{Sutter} = N_{Court} * P_{Sutter} * S_{Sutter} * S_{Steam2} * S_{Sac4}$$'),
          helpText('Steamboat Route
                             $$N_{Steam} = N_{Court} * (1 - P_{Sutter}) * S_{Sac1} * P_{Steam} * 
                             S_{Steam1} * S_{Steam2} * S_{Sac4}$$'),
          helpText('Sacramento Route
                             $$N_{Sac} = N_{Court} * (1 - P_{Sutter}) * S_{Sac1} * (1 - P_{Steam}) * 
                             S_{Sac2} * (1 - P_{Geo}) * S_{Sac3} * S_{Sac4}$$'),
          helpText('Georgiana/Interior Delta Route
                             $$N_{Geo/ID} = N_{Court} * (1 - P_{Sutter}) * S_{Sac1} * (1 - P_{Steam}) * 
                             S_{Sac2} * P_{Geo} * S_{Geo/ID}$$'),
          helpText('Overall Survival to Chipps Island
                             $$(N_{Sutter} + N_{Steam} + N_{Sac} + N_{Geo/ID}) / N_{Court}$$'),
          helpText('$N_{Court}$ is the number of fish passing Courtland'),
          helpText('$N_{X}$ is the number of fish arriving at Chipps Island via the 
                                      route specified in the subscript'),
          helpText('$P_{X}$ is the probability of entrainment into the 
                                      distributary specified in the subscript'),
          helpText('$S_{X}$ is the survival through the reach specified in the subscript')
        ),
        card(img(src = "SutterSteamboatDiagram.png", width = 250, height = 495)),
        col_widths = c(9, 3)
      )
    )
  )
)

