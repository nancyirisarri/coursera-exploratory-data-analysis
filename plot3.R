library(data.table)
library(dplyr)

obs <- fread("household_power_consumption.txt")
obs <- obs[which(obs$Date=="1/2/2007" | obs$Date == "2/2/2007"),]

png(filename="plot3.png")

y_lim <- range(c(min(as.numeric(obs$Sub_metering_1)), max(as.numeric(obs$Sub_metering_1))))

with(obs, plot(as.numeric(Sub_metering_1), type="l", ylim=y_lim, xaxt="n", xlab="", ylab="Energy sub metering"))

par(new=TRUE)
with(obs, plot(as.numeric(Sub_metering_2), type="l", ylim=y_lim, axes=FALSE, xlab="", ylab="", col="red"))

par(new=TRUE)
with(obs, plot(as.numeric(Sub_metering_3), type="l", ylim=y_lim, axes=FALSE, xlab="", ylab="", col="blue"))

legend("topright", lwd=2, lty=c(1,1,1), col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

axis(1, at=0, labels=c("Thu"))
axis(1, at=24*60, labels=c("Fri"))
axis(1, at=48*60, labels=c("Sat"))

dev.off()