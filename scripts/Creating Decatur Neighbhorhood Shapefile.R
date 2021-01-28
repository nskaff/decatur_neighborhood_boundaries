#convert scraped coordinates to polygon
library(sf)
library(tidyverse)
library(mapview)
library(rgdal)
library(sp)

#axis locations on webplot digitizer
# x1=-84.2963 corner of dougherty and mconough
# x2=-84.2926 corner of dougherty and s candler
# y1=33.7756 corner of church and ponce
# y2=33.7778 corner of church and commerce

#In webplot digitizer https://apps.automeris.io/wpd/, you must organize the points by nearest neighbor in order to create usable csv

lenox<-read_csv("neighborhood_polygon_verticies/Lenox\ Place.csv", 
                col_names = c("lon","lat"))
adair<-read_csv("neighborhood_polygon_verticies/Adair\ Park.csv", 
                col_names = c("lon","lat"))
east.ponce<-read_csv("neighborhood_polygon_verticies/East Ponce de Leon Corridor.csv", 
                     col_names = c("lon","lat"))
medlock.north<-read_csv("neighborhood_polygon_verticies/Medlock_North\ Decatur.csv",
                        col_names = c("lon","lat"))
clairemont.ave<-read_csv("neighborhood_polygon_verticies/Clairemont\ Ave.csv",
                         col_names = c("lon","lat"))
downtown<-read_csv("neighborhood_polygon_verticies/Downtown.csv",
                   col_names = c("lon","lat"))
decatur.heights<-read_csv("neighborhood_polygon_verticies/Decatur\ Heights.csv",
                          col_names = c("lon","lat"))
chelsea.heights<-read_csv("neighborhood_polygon_verticies/Chelsea\ Heights.csv",
                          col_names = c("lon","lat"))
candler.agnes<-read_csv("neighborhood_polygon_verticies/South Candler_Agnes Scott.csv",
                        col_names = c("lon","lat"))
greenwood<-read_csv("neighborhood_polygon_verticies/Greenwood_Pattillo_Howard.csv",
                    col_names = c("lon","lat"))
oakhurst<-read_csv("neighborhood_polygon_verticies/Oakhurst.csv",
                   col_names = c("lon","lat"))
westchester.hills<-read_csv("neighborhood_polygon_verticies/Westchester Hills.csv",
                            col_names = c("lon","lat"))
winnona.park<-read_csv("neighborhood_polygon_verticies/Winnona Park.csv",
                       col_names = c("lon","lat"))
mak<-read_csv("neighborhood_polygon_verticies/MAK Historic District.csv",
              col_names = c("lon","lat"))
ponce.court<-read_csv("neighborhood_polygon_verticies/Ponce de Leon Court.csv",
                      col_names = c("lon","lat"))
west.clairemont<-read_csv("neighborhood_polygon_verticies/West Clairemont.csv",
                          col_names = c("lon","lat"))
old.decatur<-read_csv("neighborhood_polygon_verticies/Old Decatur.csv",
                      col_names = c("lon","lat"))
great.lakes<-read_csv("neighborhood_polygon_verticies/Great Lakes.csv",
                      col_names = c("lon","lat"))
parkwood<-read_csv("neighborhood_polygon_verticies/Parkwood.csv",
                   col_names = c("lon","lat"))
glenwood<-read_csv("neighborhood_polygon_verticies/Glenwood Estates.csv",
                   col_names = c("lon","lat"))

verticies_df<-bind_rows("Lenox Place" =lenox, "Adair Park"=adair, 
                   "East Ponce de Leon Court"=east.ponce, 
                   "Medlock/North Decatur"=medlock.north, 
                   "Clairemont Ave"=clairemont.ave, "Downtown Decatur"=downtown, 
                   "Decatur Heights"=decatur.heights, 
                   "Chelsea Heights"=chelsea.heights,
                   "South Candler/Agnes Scott"=candler.agnes,
                   "Greenwood/Pattillo/Howard"=greenwood, "Oakhurst"=oakhurst,
                   "Westchester Hills"=westchester.hills, 
                   "Winnona park"=winnona.park,
                   "MAK Historic District"= mak, 
                   "Ponce de Leon Court"=ponce.court, 
                   "West Clairemont"=west.clairemont, 
                   "Old Decatur"=old.decatur, "Great Lakes"=great.lakes, 
                   "Parkwood"=parkwood, "Glenwood Estates"=glenwood, .id="RegionName")


#converting neighborhood verticies to spatial polygon
spatial_neigh <- data.frame(verticies_df) %>%
  group_by(RegionName) %>%
  st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
  dplyr::summarise(geometry = st_combine(geometry)) %>%
  st_cast("POLYGON")


spatial_neigh_sp<-as_Spatial(spatial_neigh)

writeOGR(obj=spatial_neigh_sp, dsn="decatur_neighborhoods_shp/", layer="decatur_neighborhoods", driver="ESRI Shapefile")

# adair<- data.frame(adair) %>%
#   st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
#   dplyr::summarise(geometry = st_combine(geometry)) %>%
#   st_cast("POLYGON")
# 
# east.ponce<- data.frame(east.ponce) %>%
#   st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
#   dplyr::summarise(geometry = st_combine(geometry)) %>%
#   st_cast("POLYGON")
# 
# medlock.north<- data.frame(medlock.north) %>%
#   st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
#   dplyr::summarise(geometry = st_combine(geometry)) %>%
#   st_cast("POLYGON")
# 
# clairemont.ave<- data.frame(clairemont.ave) %>%
#   st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
#   dplyr::summarise(geometry = st_combine(geometry)) %>%
#   st_cast("POLYGON")
# 
# downtown<- data.frame(downtown) %>%
#   st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
#   dplyr::summarise(geometry = st_combine(geometry)) %>%
#   st_cast("POLYGON")
# 
# decatur.heights<- data.frame(decatur.heights) %>%
#   st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
#   dplyr::summarise(geometry = st_combine(geometry)) %>%
#   st_cast("POLYGON")
# 
# chelsea.heights<- data.frame(chelsea.heights) %>%
#   st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
#   dplyr::summarise(geometry = st_combine(geometry)) %>%
#   st_cast("POLYGON")
# 
# candler.agnes<- data.frame(candler.agnes) %>%
#   st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
#   dplyr::summarise(geometry = st_combine(geometry)) %>%
#   st_cast("POLYGON")
# 
# greenwood<- data.frame(greenwood) %>%
#   st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
#   dplyr::summarise(geometry = st_combine(geometry)) %>%
#   st_cast("POLYGON")
# 
# oakhurst<- data.frame(oakhurst) %>%
#   st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
#   dplyr::summarise(geometry = st_combine(geometry)) %>%
#   st_cast("POLYGON")
# 
# westchester.hills<- data.frame(westchester.hills) %>%
#   st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
#   dplyr::summarise(geometry = st_combine(geometry)) %>%
#   st_cast("POLYGON")
# 
# winnona.park<- data.frame(winnona.park) %>%
#   st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
#   dplyr::summarise(geometry = st_combine(geometry)) %>%
#   st_cast("POLYGON")
# 
# mak<- data.frame(mak) %>%
#   st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
#   dplyr::summarise(geometry = st_combine(geometry)) %>%
#   st_cast("POLYGON")
# 
# ponce.court<- data.frame(ponce.court) %>%
#   st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
#   dplyr::summarise(geometry = st_combine(geometry)) %>%
#   st_cast("POLYGON")
# 
# west.clairemont<- data.frame(west.clairemont) %>%
#   st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
#   dplyr::summarise(geometry = st_combine(geometry)) %>%
#   st_cast("POLYGON")
# 
# old.decatur<- data.frame(old.decatur) %>%
#   st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
#   dplyr::summarise(geometry = st_combine(geometry)) %>%
#   st_cast("POLYGON")
# 
# great.lakes<- data.frame(great.lakes) %>%
#   st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
#   dplyr::summarise(geometry = st_combine(geometry)) %>%
#   st_cast("POLYGON")
# 
# parkwood<- data.frame(parkwood) %>%
#   st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
#   dplyr::summarise(geometry = st_combine(geometry)) %>%
#   st_cast("POLYGON")
# 
# glenwood<- data.frame(glenwood) %>%
#   st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
#   dplyr::summarise(geometry = st_combine(geometry)) %>%
#   st_cast("POLYGON")
# 
# 
