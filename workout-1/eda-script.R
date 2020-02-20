#install.packages("readr")
library('readr')
ibtracs=read_csv("/Users/jeremymartinez/Desktop/Stat133//workouts/workout1/data/ibtracs-2010-2015.csv",skip = 1,col_names = c("serial_num",'season',"num","basin",'sub_basin','name','iso_time','nature','latitude','longitude','wind','press'), col_types = list(serial_num=col_character(),season=col_integer(),num=col_character(),basin= col_factor(),sub_basin=col_character(),name=col_character(),iso_time=col_character(),nature=col_character(),latitude=col_double(),longitude=col_double(),wind=col_double(),press=col_double()), na = c("-999.","-1.0","0.0"))
ibtracs

sink(file = "/Users/jeremymartinez/Desktop/Stat133/workouts/workout1/output/data-summary.txt")
summary(ibtracs)
sink()

library("maps")
library("ggplot2")
library("ggmap")
#5A
png(file='/Users/jeremymartinez/Desktop/Stat133/workouts/workout1/images/map-all-storms.png')
ibtracs2=ibtracs
ibtracs2=na.omit(ibtracs)
mapWorld= borders("world", colour="purple", fill="green")
ggplot(data=ibtracs2, aes(x=longitude, y= latitude))+
mapWorld+geom_point(aes(col=nature,shape=nature,size=wind,alpha=press))+
ggtitle("Map of all storms")+xlab("Longitude")+ylab('Latitude')+
geom_hline(yintercept = 0, col='red', linetype=2)+
theme(plot.background = element_rect(fill='gray', colour='black'), panel.background = element_rect(fill = "lightblue",
colour = "lightblue",size = 0.5, linetype = "solid"), 
legend.title = element_text(color = "blue",size = 12),
legend.text = element_text(color = "red", size=12),
legend.key.size = unit(.10,'cm'))
dev.off()



pdf(file='/Users/jeremymartinez/Desktop/Stat133/workouts/workout1/images/map-all-storms.pdf', width = 30,height = 30)
mapWorld= borders("world", colour="purple", fill="green")
ggplot(data=ibtracs2, aes(x=longitude, y= latitude))+
mapWorld+geom_point(aes(col=nature,shape=nature,size=wind,alpha=press))+
ggtitle("Map of all storms")+xlab("Longitude")+ylab('Latitude')+
geom_hline(yintercept = 0, col='red', linetype=2)+
theme(plot.background = element_rect(fill='gray', colour='black'), 
panel.background = element_rect(fill = "lightblue",
colour = "lightblue",size = 0.5, linetype = "solid"), 
legend.title = element_text(color = "blue",size = 12),
legend.text = element_text(color = "red", size=12),
legend.key.size = unit(.10,'cm'))
dev.off()

#5B
require("dplyr")
png(file='/Users/jeremymartinez/Desktop/Stat133/workouts/workout1/images/map-ep-na-storms-by-year.png')
ibtracs2=mutate(ibtracs, month = month(iso_time, label = TRUE))
ibtracs3=filter(ibtracs2, basin=="EP" | basin=="NA")
ibtracs3=na.omit(ibtracs2)
ggplot(ibtracs3, aes(longitude, latitude)) + geom_point() + mapWorld + facet_wrap(~season)+coord_fixed(1.3)
dev.off()

pdf(file='/Users/jeremymartinez/Desktop/Stat133//workouts/workout1/images/map-ep-na-storms-by-year.pdf')
ggplot(ibtracs3, aes(longitude, latitude)) + geom_point() + mapWorld + facet_wrap(~season)+coord_fixed(1.3)
dev.off()

#5C
require("lubridate")
png(file='/Users/jeremymartinez/Desktop/Stat133/workouts/workout1/images/map-ep-na-storms-by-month.png')
ggplot(ibtracs3, aes(longitude, latitude)) + geom_point() + mapWorld + facet_wrap(~month)+coord_fixed(1.3)
dev.off()


pdf(file='/Users/jeremymartinez/Desktop/Stat133/workouts/workout1/images/map-ep-na-storms-by-month.pdf')
ggplot(ibtracs3, aes(longitude, latitude)) + geom_point() + mapWorld + facet_wrap(~month)+coord_fixed(1.3)
dev.off()

