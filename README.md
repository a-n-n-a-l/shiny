# Continental United States in 1975 and 2023 data
## Shiny Application and Reproducible Pitch
## Developing Data Products Course

### Anna H
### 2025-4-7
  
This application will display a map of the continental United States during 2 time periods - 1975 and 2023.  
  
The dropdown box will allow you to select the color based on the data for:  
- the area of each state  
- the population of each state in 1975 and in 2023  
- the per capita income in each state in 1975 and 2023  
  
The map will be updated automatically based on your selection.

If you hover over a state, its name will pop-up for easier identification.  

You can understand the meaning of each color by looking at the legend on the bottom right of the map.  
The numbers will change depending on your dropdown box selection, but the color scheme will stay the same.  

In addition to the information that was color coded, the pop-up will include some calculated values:  
- the change in the state population  
- the adjusted 1975 income in 2023 dollars  
- the change in the income from 1975 to 2023

You can find this Shiny app with more documentation in my repository on the <a href='https://a-n-n-a-l.shinyapps.io/shiny/'>Shiny server</a>.  
The reproducible pitch presentation can been seen on <a href='https://a-n-n-a-l.github.io/shiny/'>GitHub Pages</a>.  
The *server.R* and *ui.R* files are available in my <a href='https://github.com/a-n-n-a-l/shiny'>GitHub</a> repository.  
  
The data for this map was taken from the following sources: 
    <ul>
        <li>The 1975 data is from the <b>state.x77</b> dataset within R</li>
        <li>The 2023 population data is from the 
    <a href='https://www.census.gov/data/tables/time-series/demo/popest/2020s-state-total.html'>
            State Population Totals and Components of Change 2020-2024</a> on the US Census website.</li>
        <li>The 2023 income data is from <a href='https://fred.stlouisfed.org/release/tables?rid=110&eid=257197&od=2023-01-01#'>
            Release Tables: Per Capita Personal Income by State, Annual</a> on the The Federal Reserve Bank of St. Louis website.</li>
     </ul>
