# Compare emissions from motor vehicle sources in Baltimore City with those in Los Angeles County, California (fips == "06037")

library(dplyr)

SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

extractTotals <- function(fipsIn) {
  # extract a city's emissions for the relevant sources, grouped by year

  sourceCodes <- SCC[grep("Motor", SCC$Short.Name),1:3]
  sourceCodes <- sourceCodes[grep("Highway Veh|Off-highway", sourceCodes$Short.Name),]
  sourceCodes <- sourceCodes[,1]
  
  NEI %>% filter(fips == fipsIn & SCC %in% sourceCodes) %>% group_by(year) %>% summarize(total = sum(Emissions, na.rm=TRUE))
}

calcChange <- function(fipsIn) {
  # calculate the proportion of emissions per year, each relative to 1999
  
  # get all the data
  totals <- extractTotals(fipsIn)
  
  propChange <- numeric()
  propChange[1] <- 0
  
  for (i in 1:nrow(totals)-1) {
    propChange[i+1] <- (((totals[i+1,2] -  totals[1,2]) / totals[1,2]))[[1]]
  }
  
  years <- c("1999", "2002", "2005", "2008")
  
  data.frame(propChange, years)
}

baltimore <- calcChange("24510")

losangeles <- calcChange("06037")

png(filename="plot6.png", width=640, height=480)

# set all plotting clipped to the figure region and set some margins
par(xpd=TRUE, mar=c(5, 8, 4, 16))

# find a common y-axis range
rng <- range(baltimore$propChange, losangeles$propChange, na.rm = T)

plot(baltimore$propChange, type="l", xaxt="n", xlab="Year", ylab="Proportion Change in PM2.5 Emissions", lwd=2, col="magenta", ylim=rng)
for (i in 1:length(baltimore$propChange)){
  points(i, baltimore$propChange[i], col="magenta", pch=16)
}

lines(losangeles$years, losangeles$propChange, type="l", xaxt="n", yaxt="n", lwd=2, col="blue", ylim=rng)
for (i in 1:length(losangeles$propChange)){
  points(i, losangeles$propChange[i], col="blue", pch=16)
}

abline(h=0, lty=2, xpd=FALSE)

axis(1, at=1, labels=c("1999"))
axis(1, at=2, labels=c("2002"))
axis(1, at=3, labels=c("2005"))
axis(1, at=4, labels=c("2008"))

legend("topright", inset=c(-0.7,0), lwd=2, lty=c(1,1), col=c("magenta", "blue"), 
       legend=c("Baltimore City, MD", "Los Angeles County, CA"))

title(main="Change Relative to 1999 in\nPM2.5 Emissions from Motor Vehicle Sources")

dev.off()