**RTakuzuGame**
RTakuzu is an R package that implements the core logic of the Takuzu puzzle game and offers an interactive Shiny application for gameplay. The objective of the game is to complete a grid using 0s and 1s, adhering to specific rules concerning adjacency, equal distribution, and row/column uniqueness.

### 🎮 **Game Rules**

### **-** Each row and column should have an equal number of 0s and 1s.
###**-** You can’t have more than two of the same number (0 or 1) in a row.
###**-** Every row and column must be different—no duplicates allowed.
###**-** Click a cell to cycle through: empty → 0 → 1 → back to empty.

### 🔧 **Installation**

To install the development version from your local project folder:

install.packages("devtools")  
devtools::install_github("yarahouhou/RTakuzuGame")


**Launch the Shiny App**

shiny::runApp()

### 👤 **Author**

Yara Houhou
GitHub: @yarahouhou
