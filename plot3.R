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

## Plot 3
png(filename = "plot3.png", 
	width = 480, height = 480,
	units = "px", bg = "transparent")
plot(date_time, Sub_metering_1, 
	type = "l",
	col = "black",
	xlab = "", ylab = "Energy sub metering")
lines(date_time, Sub_metering_2, col = "red")
lines(date_time, Sub_metering_3, col = "blue")
legend("topright", 
	col = c("black", "red", "blue"),
	c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
	lwd = 1)
dev.off()
