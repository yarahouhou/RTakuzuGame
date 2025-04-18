ui <- fluidPage(   # UI components / composants UI
  titlePanel("Takuzu Puzzle"),    # title / titre 
  mainPanel(
    tags$head(
      tags$style(HTML("
        .cell {
          width: 60px;      
          height: 60px;
          text-align: center;  
          font-size: 24px;
          display: flex;
          justify-content: center;
          align-items: center;
          border: 2px solid black;
          box-sizing: border-box;
        }
        .row {
          display: flex;
          margin-bottom: 5px;
        }
        select {
          width: 100%;
          height: 100%;
          font-size: 24px;
          text-align: center;
          border: none;
          background-color: #f0f0f0;
        }
        .fixed-cell {
          background-color: white;
        }
      "))
    ),
    uiOutput("grid"),           # dynamic grid display / affichage dynamique de la grille
    actionButton("solve", "Solve Puzzle"),     # solution button / bouton solution
    actionButton("check", "Check Solution"),   # Check button / Bouton de vérification de la solution
    actionButton("new", "New Puzzle"),         #new game button / #bouton nouvelle partie
    textOutput("result")                       # Validation result display / affichage du résultat
  )
)
