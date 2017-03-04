# Remove objects
rm(list=ls())

# get file and unzip
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "week1dataset.zip")
unzip("week1dataset.zip")

# read data
household_power_consumption <- read.table("household_power_consumption.txt", header = TRUE, sep =';', stringsAsFactors=FALSE, dec=".") # read txt to data.frame

# get only complete cases, filter by dates,convert data
household_power_consumption <- household_power_consumption[complete.cases(household_power_consumption[,3:9]),]
household_power_consumption <- household_power_consumption[household_power_consumption$Date %in% c("1/2/2007","2/2/2007") ,]
household_power_consumption$Global_active_power <- as.numeric(household_power_consumption$Global_active_power,3)
household_power_consumption$Global_reactive_power <- as.numeric(household_power_consumption$Global_reactive_power,3)
household_power_consumption$Voltage <- as.numeric(household_power_consumption$Voltage,3)
household_power_consumption$Sub_metering_1 <- as.numeric(household_power_consumption$Sub_metering_1,3)
household_power_consumption$Sub_metering_2 <- as.numeric(household_power_consumption$Sub_metering_2,3)
household_power_consumption$datetime <- strptime(paste(household_power_consumption$Date, household_power_consumption$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

# generate png file and create plots inside
png("plot4.png", width=480, height=480)
par(mfcol=c(2,2))
plot(household_power_consumption$datetime,household_power_consumption$Global_active_power,type="l", xlab="", ylab="Global Active Power")
plot(household_power_consumption$datetime,household_power_consumption$Sub_metering_1,type="l",col="black",xlab="", ylab="Energy sub metering")
lines(household_power_consumption$datetime,household_power_consumption$Sub_metering_2,col="red")
lines(household_power_consumption$datetime,household_power_consumption$Sub_metering_3,col="blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n")
with(household_power_consumption,plot(datetime,Voltage,type="l"))
with(household_power_consumption,plot(datetime,Global_reactive_power,type="l"))
dev.off()
