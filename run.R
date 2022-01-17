####################################
# Casey Opiela                  #
####################################


# Import libraries
library(shiny)
library(shinythemes)
library(data.table)
library(dplyr)
library(tidyverse)

# Read data
basketball <- read.csv('2022_NBA_PredictionsV3 1-15.csv')
allstar <- read.csv('2022_AllStar_Coef 1-15.csv')
names_sorted <- sort(unique(basketball$Name))
teams_sorted <-  sort(unique(basketball$Team))
stats <- c('Points', 'FTM', 'FTA', 'FGM2', 'FGA2', 'FGM3', 'FGA3', 
           'Total Rebounds', 'Offensive Rebounds', 'Defensive Rebounds',
           'Assists', 'Steals', 'Blocks', 'Turnovers', 'Fouls',
           'ESPN Fantasy Score', 'Yahoo Fantasy Score')
port <- Sys.getenv('PORT')

shiny::runApp(
  appDir = getwd(),
  host = '0.0.0.0',
  port = as.numeric(port)
)
