##Download and unzip the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "./data/d")
unzip("./data/d")

##Read the data
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

nei$Emissions<-as.numeric(nei$Emissions)

##Compare emissions from motor vehicle sources in Baltimore City with emissions
##from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
##Which city has seen greater changes over time in motor vehicle emissions?


#First que open the device we will use for the image
png("./plot6.png")

#We need the data on road in Baltimore or Los Angeles
nei2<-nei[(nei$type=="ON-ROAD")&((nei$fips=="24510")|(nei$fips=="06037")),]

library(dplyr)

sm<-summarise(group_by(group_by(nei2,year),fips,add=T),sum(Emissions))

#Change the names for a better look of the graph
sm$fips<-gsub("06037","Los Angeles Country",sm$fips)
sm$fips<-gsub("24510","Baltimore City",sm$fips)

library(ggplot2)

qplot(sm$year,sm$`sum(Emissions)`,data=sm,fill=fips,geom="line")+xlab("year")+ylab("Total on road emissions")+ggtitle("On road emissions evolution by city")+geom_bar(stat="identity")

dev.off()
