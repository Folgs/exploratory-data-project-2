##Download and unzip the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "./data/d")
unzip("./data/d")

##Read the data
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

nei$Emissions<-as.numeric(nei$Emissions)

##How have emissions from motor vehicle sources changed from 1999-2008 in 
##Baltimore City?

##First we open the device in which we will save the image
png("./plot5.png")

##We want the data about the pollution on road in Baltimore (fips=24510)
nei2<-nei[(nei$type=="ON-ROAD")&(nei$fips=="24510"),]

##We calculate the total emissions for each year and graph them.
library(ggplot2)
library(dplyr)

sm<-summarise(group_by(nei2,year),sum(Emissions))
qplot(sm$year,sm$`sum(Emissions)`,geom="line")+xlab("year")+ylab("Total on road emissions")+ggtitle("On road emissions evolution")

dev.off()
