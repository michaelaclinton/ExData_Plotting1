filedata <- "epc.zip"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
unzipped <- ("household_power_consumption.txt")
#check if file already exists
if (!file.exists(filedata)) {
  download.file(url, filedata, mode = "wb") #if not, download
}
#check if directory exists and unzip
if(!file.exists(unzipped)) {
  unzip("epc.zip", files = NULL, exdir = ".") #?
}
#read in all data and subset
hpc <- read.delim("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE, na.strings = "?") #read in the data, no factors
data <- hpc[hpc$Date %in% c("1/2/2007", "2/2/2007") ,] #subset for applicable dates
#make all subsets for charts
datetime <- strptime(paste(data$Date, data$Time, sep = " "), "%d/%m/%Y %H:%M:%S") #datetime
gap <- data$Global_active_power #global active power data
sm1 <- data$Sub_metering_1 #sub metering 1 vector
sm2 <- data$Sub_metering_2 #sub metering 2 vector
sm3 <- data$Sub_metering_3 #sub metering 3 vector
voltage <- data$Voltage
grp <- data$Global_reactive_power #global reactive power data
#set 2 by 2 grid and output to png
png(filename = "plot4.png", width= 480, height = 480)
par(mfrow = c(2,2))

#upper left
plot(datetime, gap, type = "l", ylab = "Global Active Power", xlab = "")
#upper right
plot(datetime, voltage, type = "l", ylab = "Voltage", xlab = "datetime")
#lower left
plot(datetime, sm1, type = "l", ylab = "Energy Submetering", xlab = "")
lines(datetime, sm2, type = "l", col = "red")
lines(datetime, sm3, type = "l", col = "blue")
legend("topright", lty=1, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), bty = "n")
#lower right
plot(datetime, grp, ylab = "Global_reactive_power", xlab = "datetime", type = "l")

dev.off() #close device
