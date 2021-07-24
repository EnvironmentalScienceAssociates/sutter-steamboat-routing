library(shiny)
library(dplyr)
library(plotly)

N_court = 1e6
# pss = prob sutter steamboat
pss = expand.grid(P_sut = seq(0.01, 0.99, 0.01),
                  P_steam = seq(0.01, 0.99, 0.01))
P_sut = pss$P_sut
P_steam = pss$P_steam

slider_min = 0.01
slider_max = 0.99
slider_step = 0.01