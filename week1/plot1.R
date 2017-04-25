library(data.table)

data <- fread("household_power_consumption.txt")
data <- data[which(data$Date=="1/2/2007" | data$Date == "2/2/2007"),]

png(filename="plot1.png")
with(data, hist(as.numeric(Global_active_power), col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))

dev.off()