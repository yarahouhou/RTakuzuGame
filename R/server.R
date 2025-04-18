server <- function(input, output, session) {
  grid_state <- reactiveVal(create_initial_grid())
  
  # Grid rendering / rendu de la grille
  output$grid <- renderUI({
    grid_ui <- tagList()     # container for UI elements / conteneur d'éléments UI
    # build 8x8 grid / construction grille
    for (i in 1:8) {
      row <- tagList() # initialize row / initialiser la ligne
      for (j in 1:8) { 
        cell_value <- grid_state()[i, j] # Get cell value / obtenir valeur case
        input_id <- paste0("cell_", i, "_", j) # unique ID for each cell / ID unique
        
        # empty cell handling / gestion des cellules vides
        if (is.na(cell_value)) {
          row <- tagList(row, 
            tags$div(   # dropdown menu for empty cells / dérouler cellules vides
              tags$select(
                id = input_id,
                onchange = paste0("Shiny.setInputValue('", input_id, "', this.value)"),
                tags$option(value = "", ""),   # empty option /option vide
                tags$option(value = "0", "0"), #0 option / option 0
                tags$option(value = "1", "1")   # 1 option / option1
              ),
              class = "cell"
            )
          )
        } else {
           # pre filled cell / case pré remplie
          row <- tagList(row, 
            tags$div(cell_value, 
                     class = "cell fixed-cell"
            )
          )
        }
      }
      # add completed row to the grid / ajouter la ligne complétee
      grid_ui <- tagList(grid_ui, div(class = "row", row))
    }
    grid_ui   #return final grid /retourner la grille finale
  })

   # grid state observer /observer état grille
  observe({
    grid_state_val <- grid_state()   #get current state /obtenir l'état actuel
     # Update grid from user inputs / mise à jour de la grille depuis les entrees de l'utilisateur
    for (i in 1:8) {
      for (j in 1:8) {
        input_id <- paste0("cell_", i, "_", j)
        # check if input exist / vérifier si l'entrée existe
        if (!is.null(input[[input_id]])) { 
          #update only if value selected /mettre à jour si valeur sélectionnee

          if (input[[input_id]] != "") { 
            grid_state_val[i, j] <- as.numeric(input[[input_id]]) 
          }
        }
      }
    }
    grid_state(grid_state_val)  #update reactive state /metre à jour l'état réactif
  })
  #handler of solve button/ gestionnaire bouton sol°
  observeEvent(input$solve, {
    grid_state(solution)   #set to solution /définir la sol°
    output$result <- renderText({ "" })   #clear result message/ effacer le message de la sol°
  })
  #handler of check button/ Gestionnaire de vérificat°
  observeEvent(input$check, {
    grid_val <- grid_state()  # get current grid / obtenir la grille actuelle
    output$result <- renderText({ validate_grid(grid_val) }) #validate
  })
  #new game handler button/gestionnaire boutton d'une nouvelle partie
  observeEvent(input$new, {
    grid_state(create_initial_grid()) #reset grid /réinitialiser
    output$result <- renderText({ "" }) #clear result /effacer résultat
  })
}
