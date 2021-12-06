
library(plotly)

source("setup.R")

function(input, output, session) {

county=reactive({filter(read.csv("county_names.csv"), county==input$county)%>%
                  select(countyfips)%>%
    as.numeric()})


  
#### Components of Change ####
  output$components=renderPlotly({components_p(county())})
  
  comp_data=reactive({components_d(county(), input$county)})
  
  output$componentsData=downloadHandler(
    filename= function(){
      paste(unique(comp_data()$County), paste0("Births, Deaths, and Net Migration 1985 to ", max(comp_data()$year), ".csv"))
    },
    content= function(file){
      write.csv(comp_data(), file, row.names=FALSE)
    }
    
  )
  
}
