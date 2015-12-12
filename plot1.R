#This script creates plot1

z <- "coursera/household_power_consumption.zip"
t <- "coursera/household_power_consumption.txt"
p <- "coursera/plot1.png"

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

##explicitly launch graphics device
png(p, width = 480, height = 480)

##call plotting function to make device & annotate
hist(d$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

##explicitly close device
dev.off()