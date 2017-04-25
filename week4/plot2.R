# plot total emissions from PM2.5 in Baltimore City, Maryland (fips == "24510") from 1999 to 2008
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")

totals <- NEI %>% filter(fips == "24510") %>% group_by(year) %>% summarize(total = sum(Emissions, na.rm=TRUE))

png(filename="plot2.png")

with(totals, {
  plot(year, total, type="l", xaxt="n", xlab="Year", ylab="Total PM2.5 (tons)", lwd=2)
  points(1999, total[1], col="red", pch=16)
  points(2002, total[2], col="blue", pch=16)
  points(2005, total[3], col="green", pch=16)
  points(2008, total[4], col="magenta", pch=16)
})

axis(1, at=1999, labels=c("1999"))
axis(1, at=2002, labels=c("2002"))
axis(1, at=2005, labels=c("2005"))
axis(1, at=2008, labels=c("2008"))

title(main="Total PM2.5 Emissions in Baltimore City From All Sources")

dev.off()