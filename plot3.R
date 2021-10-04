library(downloader)

# create the data folder if not exists
if (!file.exists("./data")) {
  dir.create("./data")
}

#Download the data file
download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest="./data/electric-power-consumption.zip", mode="wb")

#Unzip the file
unzip("./data/electric-power-consumption.zip", exdir="./data", overwrite = TRUE)

# remove the downloaded zip file
unlink("./data/electric-power-consumption.zip")


# Load Data File

data_load <- read.csv("./data/household_power_consumption.txt", header=TRUE, sep=";", 
                      stringsAsFactors=FALSE, na.strings = "?", dec=".")

# Format Date + Time
data_load$Date <- as.Date(data_load$Date, format = "%d/%m/%Y")


##Subset Data to date ranges provided
data_load_subset <-subset(data_load, data_load$Date >= "2007-02-01" & data_load$Date <= "2007-02-02")


# Combine Date + Time into new column
data_load_subset$TS <- as.POSIXct(paste(data_load_subset$Date, data_load_subset$Time, seperator = " "))


# Output Plot to 480 x 480 png
png("plot3.png", height = 480, width = 480)
plot(data_load_subset$Sub_metering_1~data_load_subset$TS, type = "l", ylab = "Energy sub metering", xlab = "")
lines(data_load_subset$TS, data_load_subset$Sub_metering_2, col = "red")
lines(data_load_subset$TS, data_load_subset$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2, col=c("black", "red", "blue"))

dev.off()