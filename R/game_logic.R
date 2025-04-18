# function to create initial playable grid with empty cells            # fonction pour créer la grille initiale avec des cases vides
create_initial_grid <- function() {
  grid <- solution
  # Randomly select 20 cells to empty                                 # sélection aléatoire de 20 cellules à vider
  empty_cells <- sample(1:64, size = 20, replace = FALSE)
  for (cell in empty_cells) {
    row <- ((cell - 1) %/% 8) + 1       # calculate row index              # calcul de l'indice de ligne
    col <- ((cell - 1) %% 8) + 1        # calculate column index           # calcul de l'indice de colonne
    grid[row, col] <- NA                # Replace with NA for empty cell (NA in R for missing/undefined values)  # Remplacer par NA pour case vide        
  }
  return(grid)
}

# validation function checking puzzle rules
validate_grid <- function(grid) { 
  # check for empty cells      
  if (any(is.na(grid))) {
    return("Grid is incomplete. Fill all cells first!")
  }

  # Validate row/column balance (4 zeros and 4 ones)          # Vérification de l'équilibre 0/1 dans les lignes et colonnes
  for (i in 1:8) {    #iterate through all 8 rows/columns     # parcours des 8 lignes et colonnes
    row <- grid[i, ]  # get current row                       # Extraction de la ligne i
    col <- grid[, i]  # get current column                    # extraction de la colonne i
    
    # row validation: must have exactly 4 zeros and 4 ones       #vérification de la ligne: doit contenir exactement 4 zeros et 4 uns
    if (sum(row == 0) != 4 || sum(row == 1) != 4) {
      return(paste("Row", i, "has incorrect balance of 0s and 1s!"))
    }
    # Column validation: must have exactly 4 zeros and 4 ones     #vérfification identique pour la colonne
    if (sum(col == 0) != 4 || sum(col == 1) != 4) {
      return(paste("Column", i, "has incorrect balance of 0s and 1s!"))
    }
  }
  # Check for horizontal triplets   # Vérification des triplets consécutifs dans les lignes
  for (i in 1:8) {
    for (j in 1:6) {  # check columns 1-6 (need 3 consecutive cells)  #parcours de lignes de 1-6
      if (grid[i, j] == grid[i, j+1] && grid[i, j+1] == grid[i, j+2]) {
        return(paste("Row", i, "has three consecutive identical numbers!"))
      }
    }
    # Check for vertical triplets   # Vérification des triplets consécutifs dans les colonnes
    for (j in 1:6) {
      if (grid[j, i] == grid[j+1, i] && grid[j+1, i] == grid[j+2, i]) {
        return(paste("Column", i, "has three consecutive identical numbers!"))
      }
    }
  }
  # check for duplicate rows    # Vérification des lignes dupliquées
  for (i in 1:7) {
    for (j in (i+1):8) {    #avoid duplicate comparisons   # évite les comparaisons redondantes
      if (all(grid[i, ] == grid[j, ])) {
        return(paste("Rows", i, "and", j, "are identical!"))
      }
    }
  }
  
  # Check for duplicate columns (same logic as rows)  # Vérification des colonnes dupliquées
  for (i in 1:7) {
    for (j in (i+1):8) {
      if (all(grid[, i] == grid[, j])) {
        return(paste("Columns", i, "and", j, "are identical!"))
      }
    }
  }
  # Final success message if all checks pass  #sii toutes les vérifications sont passées
  return("Your solution is correct!")
}
