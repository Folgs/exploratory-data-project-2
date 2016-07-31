##Download and unzip the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "./data/d")
unzip("./data/d")

##Read the data
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

nei$Emissions<-as.numeric(nei$Emissions)


##Of the four types of sources indicated by the type (point, nonpoint, onroad,
##nonroad) variable, which of these four sources have seen decreases in emissions
##from 1999-2008 for Baltimore City? Which have seen increases in emissions from 
##1999-2008? Use the ggplot2 plotting system to make a plot answer this question.


#Open the device
png("./plot3.png")

library(ggplot2)
library(dplyr)

#We only need Baltimore City data
dt2<-nei[nei$fips=="24510",]

#We need to know the total sums by year in each type, as we want to graph them.

sm<-summarise(group_by(group_by(dt2,year),type,add=T),sum(Emissions))
names(sm)<-c("year","type","totalemissions")
qplot(year,totalemissions,data=sm,col=type,geom="line")
##As we can perfectly see, the only one that have higher levels now is the point type.

dev.off()
