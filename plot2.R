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
hpc <- read.delim("household_power_consumption.txt", sep = ";", 
                  stringsAsFactors = FALSE, na.strings = "?") #read in the data, no factors
data <- hpc[hpc$Date %in% c("1/2/2007", "2/2/2007") ,] #subset for applicable dates
gap <- data$Global_active_power
datetime <- strptime(paste(data$Date, data$Time, sep = " "), 
                     "%d/%m/%Y %H:%M:%S") #paste dates and times together in new vector
png("plot2.png", width = 480, height = 480) #set params of a plot
plot(datetime, gap, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts") #make the plot and save as png
dev.off() #disconnect