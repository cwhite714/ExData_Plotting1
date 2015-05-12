setwd("H:\\exploratory_data_analysis")

if(!file.exists("data")) {
        dir.create("data")
}

filename <- "./data/household_power_consumption.txt"
data <- read.table(filename,
	header = TRUE,
	sep = ";",
	colClasses = c("character", "character", rep("numeric",7)),
	na = "?")
attach(data)

## Only need 2 days
subset <- Date == "1/2/2007" | Date == "2/2/2007"
newData <- data[subset, ]
attach(newData)
x <- paste(Date, Time)
newData$date_time <- strptime(x, "%d/%m/%Y %H:%M:%S")
rownames(newData) <- 1:nrow(newData)
attach(newData)

## Plot 4
png(filename = "plot4.png", 
    width = 480, height = 480,
    units = "px", bg = "transparent")
par(mfrow = c(2, 2))
## Top-left
plot(date_time, Global_active_power, 
     type = "l",
     xlab = "", ylab = "Global Active Power")
## Top-right
plot(date_time, Voltage,
     type = "l",
     xlab = "datetime", ylab = "Voltage")
## Bottom-left
plot(date_time, Sub_metering_1, 
     type = "l",
     col = "black",
     xlab = "", ylab = "Energy sub metering")
lines(date_time, Sub_metering_2, col = "red")
lines(date_time, Sub_metering_3, col = "blue")
## Remove legend border
legend("topright", 
       bty = "n",
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)
## Bottom-right
plot(date_time, Global_reactive_power, 
     type = "l",
     col = "black",
     xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
