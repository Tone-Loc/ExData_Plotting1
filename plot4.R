#This script creates plot4

z <- "coursera/household_power_consumption.zip"
t <- "coursera/household_power_consumption.txt"
p <- "coursera/plot4.png"

##download the data file if it doesn't already exist
if(!file.exists(t)){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, z)
        unzip(z, exdir = "coursera")
}

##read data into a data frame
cClass <- c(rep("character", 2), rep("numeric", 7))
d <- read.table(t, sep = ";", header = TRUE, na.strings = "?", colClasses = cClass)

##subset data to relevant time frame
d <- d[d$Date == "1/2/2007" | d$Date == "2/2/2007", ]

##create datetime object
dateTime <- strptime(paste(d$Date, d$Time), format = "%d/%m/%Y%H:%M:%S")

##explicitly launch graphics device
png(p, width = 480, height = 480)

#set paramater for multiple graphs on one canvas
par(mfcol = c(2, 2))

##call plotting functions to make plots & annotate
##1st plot
plot(dateTime, d$Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")

##2nd plot
with(d, plot(dateTime, d$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering",))
lines(dateTime, d$Sub_metering_1)
lines(dateTime, d$Sub_metering_2, col = "red")
lines(dateTime, d$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = "solid", bty = "n")

##3rd plot
plot(dateTime, d$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

##4th plot
plot(dateTime, d$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

##explicitly close device
dev.off()