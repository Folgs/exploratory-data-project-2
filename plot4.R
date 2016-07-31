##Download and unzip the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "./data/d")
unzip("./data/d")

##Read the data
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

nei$Emissions<-as.numeric(nei$Emissions)

##Across the United States, how have emissions from coal combustion-related sources
##changed from 1999-2008?

#Open the device

png("./plot4.png")

library(dplyr)
library(ggplot2)

#We choose every pollution related with coal.

sccoal<-scc[grepl("[Cc]oal",scc$Short.Name),]
merged<-merge(nei,sccoal,by="SCC")

sm<-summarise(group_by(merged,year),sum(Emissions))
qplot(year,sm$"sum(Emissions)",data=sm,geom="line")+ggtitle("Total emissions coal")

dev.off()
