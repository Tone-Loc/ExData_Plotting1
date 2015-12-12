#This script creates plot3

z <- "coursera/household_power_consumption.zip"
t <- "coursera/household_power_consumption.txt"
p <- "coursera/plot3.png"

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

##call plotting function to make device & annotate
with(d, plot(dateTime, d$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering",))
lines(dateTime, d$Sub_metering_1)
lines(dateTime, d$Sub_metering_2, col = "red")
lines(dateTime, d$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = "solid")

##explicitly close device
dev.off()