##Download and unzip the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "./data/d")
unzip("./data/d")

##Read the data
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

##Have total emissions from PM2.5 decreased in the United States from 1999 to
##2008? Using the base plotting system, make a plot showing the total PM2.5 
##emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#Open the device we will use

png('./plot1.png')

nei$Emissions<-as.numeric(nei$Emissions)

library(dplyr)

#Calculate the total pollution emissions split by year

sm<-summarise(group_by(nei,year),sum(Emissions))
sm<-as.data.frame(sm)

plot(sm,type="l",main="Pollution emissions evolution",ylab="Total pollution emissions",lwd=2)
#Yes, the total number of pollution emissions decreass.

dev.off()