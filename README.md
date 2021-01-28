# decatur_neighborhood_boundaries

This repository stores the code, images, and data that were used to create neighborhood boundaries for the city of Decatur, Georgia. 

These are the neighborhood boundaries as defined by Zillow, which may differ from other sources like Google Maps. Since a shapefile was not available from Zillow, I reconstructed the boundaries by scraping screenshots (available in this repository) of each boundary on Zillow's website. I then used WebPlotDigitizer (https://automeris.io/WebPlotDigitizer/) to identify the coordinates of each boundary and exported these values as csv files (available in this repository). The included script converts the coordinates to a shapefile.

The boundaries are far from perfect because they were reconstructed in a relatively crude way. They can probably be improved by generating more careful screenshots and digitizing the images more carefully.

![alt text](https://github.com/nskaff/decatur_neighborhood_boundaries/blob/master/screenshots/Decatur%20Shapefile%20Image.png?raw=true)
