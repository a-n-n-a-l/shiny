#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
fluidPage(

fluidRow(        
    # Application title
        absolutePanel(
                top = "0%", left = "0%", right = "0%", height = "10%",
                style = "background-color: #3c8dbc; 
                        color: white; 
                        text-align: center; 
                        padding: 20px; 
                        box-shadow: 0px 4px 6px rgba(0,0,0,0.2);
                        position: fixed;
                        z-index: 1000;",
                h1("Continental United States in 1975 and 2023 data")
        ),       
),       

div(style = "margin-top: 120px; margin-left:2%",
fluidRow(
    br(),
    p(HTML("
    
    This Shiny application uses several datasets to create a map of the continental United States 
      and colors it based on the data within those datasets.
    <br>       
    The data for this map was taken from the following sources: 
    <ul>
        <li>The 1975 data is from the <b>state.x77</b> dataset within R</li>
        <li>The 2023 population data is from the 
    <a href='https://www.census.gov/data/tables/time-series/demo/popest/2020s-state-total.html'>
            State Population Totals and Components of Change 2020-2024</a> on the US Census website.</li>
        <li>The 2023 income data is from <a href='https://fred.stlouisfed.org/release/tables?rid=110&eid=257197&od=2023-01-01#'>
            Release Tables: Per Capita Personal Income by State, Annual</a> on the The Federal Reserve Bank of St. Louis website.</li>
     </ul>
     To use this map, simply select the data you want to use to color the map:
     <ul>
     <li><b>Area</b> - to color the map by area of each state</li>
     <li><b>Population in 1975</b> - to color the map by the states' population in 1975</li>
     <li><b>Population in 2023</b> - to color the map by the states' population in 2023</li>
     <li><b>Per capita income in 1975</b> - to color the map by the states' per capita income in 1975, in 1975 dollars</li>
     <li><b>Per capita income in 2023</b> - to color the map by the states' per capita income in 2023, in 2023 dollars</li>
     </ul>
    Zoom in or out using the + and - icons in the top left corner of the map.<br><br>
    Use the legend in the lower right corner of the map to help you understand the coloring.<br><br>
    Click on the <img src='info.png' width=15 height=15> icon in the center of a state to get detailed
    information on the same items as listed above.
    <br><br>
    In addition, you will see the per capita income from 1975 in 2023 dollars 
    (calculated with the help of the <b><a href='https://cran.r-project.org/package=priceR'>priceR</a></b>
    package) and the percentage change in per capita income and 
    in population for the 48 years that have passed between 1975 and 2023.
    "))  
     
    
),

    # Selector
    div(style = "text-align: center; width: 300px; margin-left: auto; margin-right: auto; 
        margin-top: 10px; margin-bottom: 20px;",  
        selectInput(
                "param",
                "Color the map by:",
                choices = c(
                        "Area" = "Area",
                        "Population in 1975" = "Population",
                        "Population in 2023" = "Population.2023",
                        "Per Capita Income in 1975" = "Income",
                        "Per Capita Income in 2023" = "Per.capita.income.2023"
                ),
                selected = "Area",
                width = "300px"  # Fixed width for the selector
        )
    ),

    # Map 
    leafletOutput("map", width = "100%", height = "600px")

)
)
