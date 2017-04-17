library(data.table)
library(dplyr)

obs <- fread("household_power_consumption.txt")
obs <- obs[which(obs$Date=="1/2/2007" | obs$Date == "2/2/2007"),]

png(filename="plot2.png")
with(obs, plot(as.numeric(Global_active_power), type="l", xaxt="n", xlab="", ylab="Global Active Power (kilowatts)"))
axis(1, at=0, labels=c("Thu"))
axis(1, at=24*60, labels=c("Fri"))
axis(1, at=48*60, labels=c("Sat"))

dev.off()