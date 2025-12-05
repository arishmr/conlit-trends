# Define vector of package names
packages <- c(
  "dplyr", "tidyverse", "stringr", "lubridate", # data wrangling
  "psych", "Kendall", "trend", "lmtest", # statistical analysis
  "ggplot2", "RColorBrewer", # visualisation
  "summarytools" # descriptive stats
)

# Load packages
for (package in packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package)
    library(package, character.only = TRUE)
  } else {
    library(package, character.only = TRUE)
  }
}

rm(packages, package)

