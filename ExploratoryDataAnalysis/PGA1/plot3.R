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

png(file="plot3.png", height=480, width=480)
## Plot 3 - 
with(DataHouse, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


## Saving to file with given dimensions
#dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
