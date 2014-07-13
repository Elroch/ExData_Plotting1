# change working directory
setwd("c:/users/liam/documents/r/datascience/exploratory data analysis")

# if necessary, download zipped data file, extract the required data file and remove zipped file
if (!file.exists("household_power_consumption.txt")) {
    temp <- tempfile()
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
    unz(temp, "household_power_consumption.txt")
    unlink(temp)    
}

# extract the two days of interest
electric.power.consumption = electric.power.consumption[as.character(electric.power.consumption$Date) == "1/2/2007" 
                                                        | as.character(electric.power.consumption$Date) == "2/2/2007", ]
# with dates arriving with single digit days, I found I needed the %e format option
electric.power.consumption$DateTime = strptime(paste(electric.power.consumption$Date, electric.power.consumption$Time, sep=" "), format="%e/%m/%Y %H:%M:%S")

# Create PNG device
png(file="plot3.png")

# plot a line and overlay two others
plot(electric.power.consumption$DateTime, electric.power.consumption$Sub_metering_1, xlab="", type="l", ylab="Energy sub metering")
lines(electric.power.consumption$DateTime, electric.power.consumption$Sub_metering_2, xlab="", type="l", ylab="Energy sub metering", col="red")
lines(electric.power.consumption$DateTime, electric.power.consumption$Sub_metering_3, xlab="", type="l", ylab="Energy sub metering", col="blue")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# close graphics device
dev.off()