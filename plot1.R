# Remove objects
rm(list=ls())

# get file and unzip
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "week1dataset.zip")
unzip("week1dataset.zip")

# read data
household_power_consumption <- read.table("household_power_consumption.txt", header = TRUE, sep =';', stringsAsFactors=FALSE, dec=".") # read txt to data.frame
# get only complete cases, filter by dates, set Global_active_power as numeric value
household_power_consumption <- household_power_consumption[complete.cases(household_power_consumption[,3:9]),]
household_power_consumption <- household_power_consumption[household_power_consumption$Date %in% c("1/2/2007","2/2/2007") ,]
household_power_consumption$Global_active_power <- as.numeric(household_power_consumption$Global_active_power,3)
# generate png file and create plot inside
png("plot1.png", width=480, height=480)
hist(household_power_consumption$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()