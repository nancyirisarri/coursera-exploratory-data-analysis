# plot changes in emissions from coal combustion-related sources from 1999-2008 across the United States

library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

sourceCodes <- SCC[grep("Coal", SCC$Short.Name),1:3]
sourceCodes <- sourceCodes[grep("Comb", sourceCodes$Short.Name),]
sourceCodes <- sourceCodes[,1]

totals <- NEI %>% filter(SCC %in% sourceCodes) %>% group_by(year) %>% summarize(total = sum(Emissions, na.rm=TRUE))

png(filename="plot4.png")

with(totals, {
  plot(year, total, type="l", xaxt="n", xlab="Year", ylab="PM2.5 Emissions (tons)", lwd=2)
  points(1999, total[1], col="red", pch=16)
  points(2002, total[2], col="blue", pch=16)
  points(2005, total[3], col="green", pch=16)
  points(2008, total[4], col="magenta", pch=16)
})

axis(1, at=1999, labels=c("1999"))
axis(1, at=2002, labels=c("2002"))
axis(1, at=2005, labels=c("2005"))
axis(1, at=2008, labels=c("2008"))

title(main="PM2.5 Emissions from Coal Combustion Sources in the USA")

dev.off()