#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(priceR)
library(tidyr)
library(leaflet)
library(sf)
library(dplyr)
library(spData)


# Load data
data("us_states")
state_data <- data.frame(state.x77[,c(1,2,7,8)]) %>% mutate(State = state.name) 
state_centers <- data.frame(state.center, State = state.name) 
state_2023 <- read.csv("2023 Income and population data.csv", header = T,
                       colClasses = c("character", "numeric", "numeric", rep("NULL", 5)))

usStates <- us_states %>%
        left_join(state_data, by = c("NAME" = "State")) %>%
        left_join(state_2023, by = c("NAME" = "State")) %>%
        left_join(state_centers, by = c("NAME" = "State")) %>%
        drop_na() %>%
        st_as_sf()


# Define server logic required to draw a histogram
function(input, output, session) {
        output$map <- renderLeaflet({

req(input$param)

# Precompute popup content and calculations
usStates <- usStates %>%
        mutate(
                formatArea = format((Area), big.mark = ","),
                formatPopulation1975 = format(Population, big.mark = ","),
                formatPopulation2023 = format(Population.2023, big.mark = ","),
                formatIncome1975 = format((Income), big.mark = ","),
                adjustIncome1975 = adjust_for_inflation(Income, 1975, "US", 2023),
                formatAdjustIncome1975 = format(adjustIncome1975, big.mark = ","),
                formatIncome2023 = trimws(format((Per.capita.income.2023), big.mark = ",")),
                populationChange = sprintf("%.2f%%",(Population.2023/1000 - Population)/100),
                incomeChange = sprintf("%.2f%%",(Per.capita.income.2023 - adjustIncome1975)/100),
                popupContent = paste0(
                        "<b>", NAME, "</b><br>",
                        "<b>Area</b>: ", formatArea, " sq.m.<br>",
                        "<b>Population</b><br>&nbsp;&nbsp;&nbsp; In 1975: ", formatPopulation1975, ",000<br>",
                        "&nbsp;&nbsp;&nbsp; In 2023: ", formatPopulation2023, " (Change: ", populationChange, ")<br>",
                        "<b>Per Capita Income</b><br>&nbsp;&nbsp;&nbsp; In 1975: $", 
                        formatIncome1975, "<br>",
                        "&nbsp;&nbsp;&nbsp; Equivalent to $", formatAdjustIncome1975, " in 2023<br>",
                        "&nbsp;&nbsp;&nbsp; In 2023: $", formatIncome2023, 
                        " (Change: ", incomeChange, ")<br>"
                )
        )


pal <- colorNumeric("YlGnBu", domain = usStates[[input$param]])

infoIcon <- icons(  
        iconUrl = "www/info.png",  
        iconWidth = 20,  
        iconHeight = 20  
)  


usStates %>%
        leaflet() %>%
        addTiles() %>%  # Add base map
        addPolygons(
                fillColor = ~pal(usStates[[input$param]]),  # Color by selected variable
                weight = 1,
                color = "white",
                fillOpacity = 0.7,
                label = ~NAME
        ) %>%
        addMarkers(
                lng = ~x, lat = ~y,  # Use longitude (x) and latitude (y) from merged dataset
                icon = infoIcon,
                popup = ~popupContent
                
        ) %>%
        
        addLegend(
                "bottomright",
                pal = pal,
                values = usStates[[input$param]],
                title = input$param,
                opacity = 0.7
        )

         })
        }
