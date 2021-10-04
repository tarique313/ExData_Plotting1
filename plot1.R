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

# Load the data
data <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors =FALSE, dec = '.')
summary(load_data)

##Format Date + Time
# data_load$Date <- as.Date(data_load$Date, format = "%d/%m/%Y")
##data_load$Time <- as.POSIXct(data_load$Time, format = "%H:%M:%s")

# We will only be using data from the dates 2007-02-01 and 2007-02-02.
# One alternative is to read the data from just those dates rather than
# reading in the entire dataset and subsetting to those dates.

subsetdata <- data[data$Date %in% c("1/2/2007","2/2/2007"),]

globalActivePower <- as.numeric(subsetdata$Global_active_power)
globalReactivePower <- as.numeric(subsetdata$Global_reactive_power)
voltage <- as.numeric(subsetdata$Voltage)
subMetering1 <- as.numeric(subsetdata$Sub_metering_1)
subMetering2 <- as.numeric(subsetdata$Sub_metering_2)
subMetering3 <- as.numeric(subsetdata$Sub_metering_3)

# Create histogram
# hist(globalActivePower, col="red", main="Global Active Ppower", xlab="Global Active Power (kwt)")
png(filename = "./plot1.png", width = 480, height = 480, units = "px")
with(subsetdata, hist(globalActivePower, xlab = "Global Active Power(kilowatts)",col = "red", main = "Global Active Power"))
dev.off()
