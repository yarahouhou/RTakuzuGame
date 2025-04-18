library(shiny)

solution <- matrix(c(
  0, 1, 0, 1, 0, 1, 1, 0,
  1, 1, 0, 1, 0, 1, 0, 0,
  0, 0, 1, 0, 1, 0, 1, 1,
  1, 0, 1, 0, 1, 1, 0, 0,
  0, 1, 0, 1, 0, 0, 1, 1,
  0, 1, 1, 0, 0, 1, 1, 0,
  1, 0, 0, 1, 1, 0, 0, 1,
  1, 0, 1, 0, 1, 0, 0, 1
), nrow = 8, byrow = TRUE)

create_initial_grid <- function() {
  grid <- solution
  empty_cells <- sample(1:64, size = 20, replace = FALSE)
  for (cell in empty_cells) {
    row <- ((cell - 1) %/% 8) + 1
    col <- ((cell - 1) %% 8) + 1
    grid[row, col] <- NA
  }
  return(grid)
}

validate_grid <- function(grid) {
  if (any(is.na(grid))) {
    return("Grid is incomplete. Fill all cells first!")
  }

  for (i in 1:8) {
    row <- grid[i, ]
    col <- grid[, i]
    
    if (sum(row == 0) != 4 || sum(row == 1) != 4) {
      return(paste("Row", i, "has incorrect balance of 0s and 1s!"))
    }
    if (sum(col == 0) != 4 || sum(col == 1) != 4) {
      return(paste("Column", i, "has incorrect balance of 0s and 1s!"))
    }
  }
  
  for (i in 1:8) {
    for (j in 1:6) {
      if (grid[i, j] == grid[i, j+1] && grid[i, j+1] == grid[i, j+2]) {
        return(paste("Row", i, "has three consecutive identical numbers!"))
      }
    }
    for (j in 1:6) {
      if (grid[j, i] == grid[j+1, i] && grid[j+1, i] == grid[j+2, i]) {
        return(paste("Column", i, "has three consecutive identical numbers!"))
      }
    }
  }
  
  for (i in 1:7) {
    for (j in (i+1):8) {
      if (all(grid[i, ] == grid[j, ])) {
        return(paste("Rows", i, "and", j, "are identical!"))
      }
    }
  }
  

  for (i in 1:7) {
    for (j in (i+1):8) {
      if (all(grid[, i] == grid[, j])) {
        return(paste("Columns", i, "and", j, "are identical!"))
      }
    }
  }
  
  return("Your solution is correct!")
}

ui <- fluidPage(
  titlePanel("Takuzu Puzzle"),
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
    uiOutput("grid"),
    actionButton("solve", "Solve Puzzle"),
    actionButton("check", "Check Solution"),
    actionButton("new", "New Puzzle"),
    textOutput("result")
  )
)

server <- function(input, output, session) {
  grid_state <- reactiveVal(create_initial_grid())
  
  output$grid <- renderUI({
    grid_ui <- tagList()
    for (i in 1:8) {
      row <- tagList()
      for (j in 1:8) {
        cell_value <- grid_state()[i, j]
        input_id <- paste0("cell_", i, "_", j)
        
        if (is.na(cell_value)) {
          row <- tagList(row, 
            tags$div(
              tags$select(
                id = input_id,
                onchange = paste0("Shiny.setInputValue('", input_id, "', this.value)"),
                tags$option(value = "", ""),
                tags$option(value = "0", "0"),
                tags$option(value = "1", "1")
              ),
              class = "cell"
            )
          )
        } else {
          row <- tagList(row, 
            tags$div(cell_value, 
                     class = "cell fixed-cell"
            )
          )
        }
      }
      grid_ui <- tagList(grid_ui, div(class = "row", row))
    }
    grid_ui
  })

  observe({
    grid_state_val <- grid_state()
    for (i in 1:8) {
      for (j in 1:8) {
        input_id <- paste0("cell_", i, "_", j)
        if (!is.null(input[[input_id]])) {
          if (input[[input_id]] != "") {
            grid_state_val[i, j] <- as.numeric(input[[input_id]])
          }
        }
      }
    }
    grid_state(grid_state_val)
  })
  observeEvent(input$solve, {
    grid_state(solution)
    output$result <- renderText({ "" })
  })
  
  observeEvent(input$check, {
    grid_val <- grid_state()
    output$result <- renderText({ validate_grid(grid_val) })
  })
  observeEvent(input$new, {
    grid_state(create_initial_grid())
    output$result <- renderText({ "" })
  })
}

shinyApp(ui = ui, server = server)