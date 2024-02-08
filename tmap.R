# Script for building maps based on country data
# 2024

# Tutorial
# https://r-tmap.github.io/tmap-book/visual-variables.html

# Install packages

install.packages("tmap")
install.packages("sf")
install.packages("rnaturalearth")

# Load 
require(sf)
require(tmap)
require(rnaturalearth)

# List relevant countries here

target <- ne_countries(type = "countries", country = c('Bangladesh',
                                                       'Bhutan',
                                                       'Brunei',
                                                       'Cambodia',
                                                       'China', 
                                                       'India',
                                                       'Indonesia',
                                                       'Laos',
                                                       'Malaysia',
                                                       'Myanmar',
                                                       'Nepal',
                                                       'Philippines',
                                                       'Singapore', 
                                                       'Sri Lanka',
                                                       'Thailand',
                                                       'Timor-Leste',
                                                       'Vietnam'))


target@data$name #check names

# Pick up colours of our preference here

colours()

# Map

worldmap_bat_coronavirus <-  tm_shape(World) +
  tm_polygons(col = "gray")+
    tm_shape(target) +
    tm_polygons(col = "maroon")+
    tm_text("name_en", size = 0.5)+
  tm_compass(type = "4star", size = 1, position = c("right", "top"))+
tm_scale_bar(breaks = c(0, 2000, 4000), text.size = 1) # meters

worldmap_bat_coronavirus

# Exporting map

setwd("C://Users//rdelaram//Documents//") # change it according to your folder path

tmap_save(worldmap_bat_coronavirus, "worldmap_bat_coronavirus.png",
          width = 3000, height = 2100, dpi = 300)

# Zoom in 


data("World")

bbox_zoom <- st_bbox(World %>% filter(name %in% c("Bhutan", "India",
                                                  "China", "Nepal",
                                                  'Indonesia', 'Papua New Guinea')))

worldmap_bat_coronavirus_zoom <-  tm_shape(World,  bbox = bbox_zoom) +
  tm_polygons(col = "gray")+
  tm_shape(target) +
  tm_polygons(col = "maroon")+
  tm_text("name_en", size = 0.5)+
  tm_compass(type = "4star", size = 1.2, position = c("right", "top"))+
  tm_scale_bar(breaks = c(0, 1000, 2000), text.size = 0.8,
               position = c("left", "bottom")) # meters

worldmap_bat_coronavirus_zoom

tmap_save(worldmap_bat_coronavirus_zoom, "zoomed_map_bat_coronavirus.png",
          width = 3000, height = 2100, dpi = 300)

#--------------------------------------------------