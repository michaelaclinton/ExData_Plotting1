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
#open relevant libraries
hpc <- read.delim("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE, na.strings = "?") #read in the data, no factors
data <- hpc[hpc$Date %in% c("1/2/2007", "2/2/2007") ,] #subset for applicable dates
sm1 <- data$Sub_metering_1 #sub metering 1 vector
sm2 <- data$Sub_metering_2 #sub metering 2 vector
sm3 <- data$Sub_metering_3 #sub metering 3 vector
datetime <- strptime(paste(data$Date, data$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
png(filename = "plot3.png", width = 480, height = 480)
plot(datetime, sm1, type = "l", ylab = "Energy Submetering", xlab = "")
lines(datetime, sm2, type = "l", col = "red")
lines(datetime, sm3, type = "l", col = "blue")
legend("topright", lty=1, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), bty = "n")
dev.off()