library(dplyr)
library(tidyr)
library(plotly)

# load("county_forecast.rdata")
# load("county_profile.rdata")
load("county_migbyage.rdata")
# county_profile=read.csv("county_profile.csv")

county_choices=read.csv("county_names.csv", stringsAsFactors = FALSE)%>%
  select(county)




#### Components of Change Graph and Data ####


## Generates a Plotly Chart
components_p=function(fips){
  
  data=codemogAPI::county_profile(fips, 1985:2020, vars="births,deaths,netmigration")%>%
    mutate(births=as.numeric(births),
           deaths=as.numeric(deaths),
           netmigration=as.numeric(netmigration),
      naturalIncrease=births-deaths)%>%
    select(countyfips, year, births, deaths, netMigration=netmigration)
  
  
  plot_ly(data, x=~year,y=~(births-deaths+netMigration), type="scatter", marker=list(color="rgb(31,74,126)"), line=list(color="rgb(31,74,126)", width=2.5, dash="solid"), name= "Total Population Change")%>%
    add_trace(x=~year,y=~births, type="scatter", marker=list(color="rgb(92,102,112)"), line=list(color="rgb(92,102,112)", width=2.5, dash="dot"), name= "Births")%>%
    add_trace(x=~year,y=~deaths, type="scatter", marker=list(color="rgb(123,50,148)"), line=list(color="rgb(123,50,148)", width=2.5, dash="dot"), name= "Deaths")%>%
    add_trace(x=~year,y=~netMigration, type="scatter", marker=list(color="rgb(0,149,58)"), line=list(color = "rgb(0,149,58)", width=2.5, dash="dot"), name="Net Migration")%>%
    layout(
      barmode="stacked",
      title=paste("Births, Deaths, and Net Migration 1985 to", as.character(max(data$year))),
      xaxis=list(
        title=""),
      yaxis=list(
        title="Population Change"),
      height=list(700),
      margin=list(t=60),
      legend = list(orientation = 'v', x = 0.5, xanchor = "center", y = -0.1, yanchor = "top")
    )
  
}



## Generates the data download
components_d=function(fips, name){
  
  x=codemogAPI::county_profile(fips, 1985:2020, vars="births,deaths,netmigration")%>%
    mutate(births=as.numeric(births),
           deaths=as.numeric(deaths),
           netmigration=as.numeric(netmigration),
           naturalIncrease=births-deaths)%>%
    #bind_cols(data.frame(County=rep(name, length(unique(x$year)))))%>%
    select(County=county, year, births, deaths, naturalIncrease, netMigration=netmigration)
  
  
  
  return(x)
}







