#launch application /lancer l'application
library(shiny)
source("solution.R")
source("grid_helpers.R")
source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server)
