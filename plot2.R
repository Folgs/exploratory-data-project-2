##Download and unzip the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "./data/d")
unzip("./data/d")

##Read the data
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

nei$Emissions<-as.numeric(nei$Emissions)

##Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
##(fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
##plot answering this question.

library(dplyr)

#Open the device

png("./plot2.png")

#As we will work by years, we split the data, and then calculate the total sums of emissions by years.
nei1<-group_by(nei,year)
sm<-summarise(group_by(nei1,fips,add=TRUE),sum(Emissions))
sm<-as.data.frame(sm)
sm<-sm[sm$fips=="24510",]
plot(x=sm$year,y=sm$`sum(Emissions)`,xlab="Year",ylab="Total emissions",main="Evolution pollution emissions in Maryland",lwd=2,type="l")

dev.off()