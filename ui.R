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


####################################
# User interface                   #
####################################

ui <- fluidPage(theme = shinytheme("spacelab"),
                navbarPage('2021-2022 NBA Projections',
                           tabPanel('Individual',
                                    
                                    # Page header
                                    
                                    headerPanel('Player Projections (last updated 1-15-2022)'),
                                    
                                    # Input values for player stats
                                    
                                    sidebarPanel(
                                      
                                      tags$img(src = 'LaMelo.jpg', height = 200, width = 290),
                                      HTML("<h3> Pick a Player </h3>"),
                                      
                                      selectInput("player", label = "Player:", 
                                                  choices = names_sorted, 
                                                  selected = "LaMelo Ball"),
                                      selectInput("stat", label = "Stat:",
                                                  choices = stats,
                                                  selected = 'Assists'),
                                      selectInput('projections', label = 'Actual or Projected?',
                                                  choices = c('Actual', 'Projected', 'Both'),
                                                  selected = 'Both'),
                                      
                                      actionButton("submitbutton", "Submit", class = "btn btn-primary")
                                    ),
                                    
                                    mainPanel(
                                      tags$label(h3('Output')), # Status/Output Text Box
                                      verbatimTextOutput('contents'),
                                      tableOutput('tabledata'), # Prediction results table
                                      plotOutput(outputId = 'distPlot'
                                      )
                                    )
                                    
                           ),              
                           tabPanel('Team',
                                    # Page header
                                    headerPanel('Team Projections'),
                                    
                                    # Input values for team stats
                                    sidebarPanel(
                                      
                                      tags$img(src = 'Jazz.jpg', height = 200, width = 290),
                                      HTML("<h3> Pick a Team </h3>"),
                                      selectInput("team", label = "Team:", 
                                                  choices = teams_sorted, 
                                                  selected = "UTA"),
                                      selectInput("stat2", label = "Stat:",
                                                  choices = stats,
                                                  selected = 'Blocks'),
                                      selectInput('projections2', label = 'Actual or Projected?',
                                                  choices = c('Actual', 'Projected'),
                                                  selected = 'Actual'),
                                      actionButton("submitbutton2", "Submit", class = "btn btn-primary")
                                    ),
                                    
                                    mainPanel(
                                      tags$label(h3('Output')), # Status/Output Text Box
                                      verbatimTextOutput('contents2'),
                                      tableOutput('tabledata2'), # Prediction results table
                                      
                                    )
                           ),
                           
                           tabPanel('Position',
                                    headerPanel('Position Projections'),
                                    sidebarPanel(
                                      tags$img(src = 'Giannis.jpeg', height = 200, width = 290),
                                      HTML("<h3> Pick a Position </h3>"),
                                      
                                      # Input values for position stats
                                      
                                      selectInput("position", label = "Position:", 
                                                  choices = c('PG', 'SG', 'SF', 'PF', 'C', 'ALL'), 
                                                  selected = "PF"),
                                      selectInput("stat3", label = "Stat:",
                                                  choices = stats,
                                                  selected = 'Points'),
                                      selectInput('projections3', label = 'Actual or Projected?',
                                                  choices = c('Actual', 'Projected'),
                                                  selected = 'Projected'),
                                      actionButton("submitbutton3", "Submit", class = "btn btn-primary")
                                    ),
                                    
                                    mainPanel(
                                      tags$label(h3('Output')), # Status/Output Text Box
                                      verbatimTextOutput('contents3'),
                                      tableOutput('tabledata3'), # Prediction results table
                                      
                                    )
                           ),
                           
                           tabPanel('All-Star',
                                    # Page header
                                    headerPanel('All-Star Projections'),
                                    
                                    # Input values for all star information
                                    sidebarPanel(
                                      tags$img(src = 'allstar.jpg', height = 200, width = 290),
                                      HTML("<h3> Select Season Stats </h3>"),
                                      sliderInput(inputId = "points",
                                                  label = "Points",
                                                  min = 0,
                                                  max = 50,
                                                  value = 25, step = 0.5),
                                      sliderInput(inputId = "rebounds",
                                                  label = "Rebounds",
                                                  min = 0,
                                                  max = 20,
                                                  value = 10, step = 0.25),
                                      sliderInput(inputId = "assists",
                                                  label = "Assists",
                                                  min = 0,
                                                  max = 20,
                                                  value = 10, step = 0.25),
                                      sliderInput(inputId = "steals",
                                                  label = "Steals",
                                                  min = 0,
                                                  max = 5,
                                                  value = 2, step = 0.1),
                                      sliderInput(inputId = "blocks",
                                                  label = "Blocks",
                                                  min = 0,
                                                  max = 5,
                                                  value = 2, step = 0.1),
                                      sliderInput(inputId = "winning",
                                                  label = "Team Winning %",
                                                  min = 0,
                                                  max = 1,
                                                  value = 0.5, step = 0.01)
                                    ),
                                    mainPanel(
                                      tags$label(h3('Output')), # Status/Output Text Box
                                      verbatimTextOutput('contents4'),
                                      tableOutput('tabledata4'), # Prediction results table
                                      tableOutput('tabledata5')
                                      
                                    )
                           )
                           
                           
                )
)


