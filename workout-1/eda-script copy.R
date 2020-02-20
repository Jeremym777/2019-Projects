#install.packages("readr")
library('readr')
ibtracs=read_csv("/Users/jeremymartinez/Desktop/Stat133/workout1/data/ibtracs-2010-2015.csv",skip = 1,col_names = c("serial_num",'season',"num","basin",'sub_basin','name','iso_time','nature','latitude','longitude','wind','press'), col_types = list(serial_num=col_character(),season=col_integer(),num=col_character(),basin= col_factor(),sub_basin=col_character(),name=col_character(),iso_time=col_character(),nature=col_character(),latitude=col_double(),longitude=col_double(),wind=col_double(),press=col_double()), na = c("-999.","-1.0","0.0"))
ibtracs

sink(file = "/Users/jeremymartinez/Desktop/Stat133/workout1/output/data-summary.txt")
summary(ibtracs)
sink()

library("maps")
library("ggplot2")
library("ggmap")
#5A
png(file='/Users/jeremymartinez/Desktop/Stat133/workout1/images/map-all-storms.png')
map('world', fill = TRUE, col = "green", bg='blue')
points(x=ibtracs$longitude, y=ibtracs$latitude, col= "red",cex= .9)
points(abline(h=0,col="purple"), type = "p")
points(title(main= "map of all stroms"))
points(geom_text(data=ibtracs, aes(x=longitude, y= latitude)))
dev.off()



pdf(file='/Users/jeremymartinez/Desktop/Stat133/workout1/images/map-all-storms.pdf')
map('world', fill = TRUE, col = "green", bg='blue')
points(x=ibtracs$longitude, y=ibtracs$latitude, col= "red",cex= .9)
points(abline(h=0,col="purple"), type = "p")
points(title(main= "map of all stroms"))
dev.off()

#5B
require("dplyr")
png(file='/Users/jeremymartinez/Desktop/Stat133/workout1/images/map-ep-na-storms-by-year.png')
ibtracs_basin=filter(select(ibtracs,name,season,basin), basin=="EP" | basin=="NA")
ggplot(data = ibtracs_basin, aes(x=basin,col=basin, fill= basin))+geom_density()+facet_grid(.~season)
dev.off()

pdf(file='/Users/jeremymartinez/Desktop/Stat133//workouts/workout1/images/map-ep-na-storms-by-year.pdf')
ibtracs_basin=filter(select(ibtracs,name,season,basin), basin=="EP" | basin=="NA")
ggplot(data = ibtracs_basin, aes(x=basin,col=basin, fill= basin))+geom_density()+facet_grid(.~season)
dev.off()

#5C
require("lubridate")
png(file='/Users/jeremymartinez/Desktop/Stat133/workout1/images/map-ep-na-storms-by-month.png')
ibtracs_month=filter(select(ibtracs,name,season,basin,iso_time, nature,wind ,press), basin=="EP" | basin=="NA")
ibtracs_month=mutate(ibtracs_month, month=month(iso_time, label = TRUE))
ggplot(data = ibtracs_month, aes(x=basin, y= nature,col=nature, fill= wind))+geom_point()+facet_grid(.~month)
dev.off()


pdf(file='/Users/jeremymartinez/Desktop/Stat133/workout1/images/map-ep-na-storms-by-month.pdf')
ibtracs_month=filter(select(ibtracs,name,season,basin,iso_time), basin=="EP" | basin=="NA")
ibtracs_month=mutate(ibtracs_month, month=month(iso_time, label = TRUE))
ggplot(data = ibtracs_month, aes(x=basin,col=month, fill= basin))+geom_density()+facet_grid(.~month)
dev.off()



ibtracs2=ibtracs
ibtracs2=na.omit(ibtracs)
mapWorld= borders("world", colour="purple", fill="green")
ggplot(data=ibtracs2, aes(x=longitude, y= latitude))+mapWorld+geom_point(aes(color=nature,shape=nature,size=wind,alpha=press))+ggtitle("Map all storms")+xlab("Longitude")+ylab('Latitude')
