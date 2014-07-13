setwd("c:/users/liam/documents/r/datascience/exploratory data analysis")

# download zipped data file, extract the required data file and remove zipped file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
electric.power.consumption = read.csv(unz(temp, "household_power_consumption.txt"), header=TRUE, sep=";", na.strings="?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
unlink(temp)

# extract the two days of interest
electric.power.consumption = electric.power.consumption[as.character(electric.power.consumption$Date) == "1/2/2007" 
                                                        | as.character(electric.power.consumption$Date) == "2/2/2007", ]
# with dates arriving with single digit days, I found I needed the %e format option
electric.power.consumption$DateTime = strptime(paste(electric.power.consumption$Date, electric.power.consumption$Time, sep=" "), format="%e/%m/%Y %H:%M:%S")

# Create PNG device
png(file="plot2.png")
# plot the line
plot(electric.power.consumption$DateTime, electric.power.consumption$Global_active_power, xlab="", type="l", ylab="Global Active Power (kilowatts)")

# close graphics device
dev.off()


