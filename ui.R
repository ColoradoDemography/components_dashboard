library(plotly)
library(shiny)

source("setup.R")  


function(req) {
  htmlTemplate("index.html",
               county=selectInput("county","Select a county:", choices = unique(county_choices$county), selected = 'Colorado'),

               components_plot=plotlyOutput("components"),
               components_dl=downloadButton('componentsData', 'Download Data (CSV)'),

               )
}

