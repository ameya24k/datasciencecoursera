## Reading the data with read.csv and using separator as ";" and na.strings="?"
DataHouse <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
## Formatting the date column
DataHouse$Date <- as.Date(DataHouse$Date, format="%d/%m/%Y")

## Subsetting the data within the given window
DataHouse <- subset(DataHouse, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Creating a date time column and adding it to the main dataset
Datetime <- paste(as.Date(DataHouse$Date), DataHouse$Time)
DataHouse$Datetime <- as.POSIXct(Datetime)

## Plot 1 - Histogram
hist(DataHouse$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving to file with given dimensions
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
