# predefined solution matrix for 8x8 Takuzu puzzle                                # matrice solution prédéfinie pour le puzzle Takuzu 8x8
solution <- matrix(c(             # initialize the solution matrix                # initialisation de la matrice solution
  0, 1, 0, 1, 0, 1, 1, 0,
  1, 1, 0, 1, 0, 1, 0, 0,
  0, 0, 1, 0, 1, 0, 1, 1,
  1, 0, 1, 0, 1, 1, 0, 0,
  0, 1, 0, 1, 0, 0, 1, 1,
  0, 1, 1, 0, 0, 1, 1, 0,
  1, 0, 0, 1, 1, 0, 0, 1,
  1, 0, 1, 0, 1, 0, 0, 1
), nrow = 8, byrow = TRUE)
