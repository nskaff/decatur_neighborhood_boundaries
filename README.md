# decatur_neighborhood_boundaries

This repository stores the code that was used to create neighborhood boundaries for the city of Decatur, Georgia. 

These are the neighborhood boundaries as defined by Zillow. Since a shapefile is not available from Zillow, I reconstructed their boundaries by scraping screenshots (available in this repository) of each boundary on Zillow's website. I then used WebPlotDigitizer (https://automeris.io/WebPlotDigitizer/) to identify the coordinates of each boundary (available in this repository). The included script converts the coordinates to a shapefile.
