#Ibtracs data dictionary

serial_num: storm identifier 

season: year of storm

num: Thel number of the system for that season.
The count includes all basins, so this will not be continuous for basin files.

basin: Types of basins throughout the wrold
*NA - North Atlantic
*EP - Eastern North Pacific
*WP - Western North Pacific 
*NI - North Indian
*SI - South Indian
*SP - Southern Pacific
*SA - South Atlantic

sub-basin: Types of sub-basins throughout the world
*CS - Caribbean Sea
*GM - Gulf of Mexico
*CP - Central Pacific
*BB - Bay of Bengal
*AS - Arabian Sea
*WA - Western Australia
*EA - Eastern Australia

name: name of the storm                               

iso_time: ISO Time provided in Universal Time Coordinates (UTC).
*Format is YYYY-MM-DD HH:mm:ss
*Most points are provided at 6 hour intervals.
*Some points are provided at 3 hour intervals
*Other points are provided during important times/ events that occured during the storm

nature: nature of the storm
*DS - Disturbance
*TS - Tropical
*ET - Extratropical
*SS - Subtropical
*NR - Not reported
*MX - Mixture (contradicting reports of what the storm nature was)

longitude:The angular distance of a place east or west of the earth's equator

latitude: The angular distance of a place north or south of the earth's equator

wind: Wind speeds of the storms

press: The pressure of the storm