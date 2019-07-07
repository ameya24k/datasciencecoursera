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

## Plot 4 - 
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(DataHouse, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global_Reactive_Power",xlab="datetime")
})

## Saving to file with given dimensions
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
