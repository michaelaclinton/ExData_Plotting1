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
library(dplyr)
hpc <- tbl_df(read.delim("household_power_consumption.txt", sep = ";", na.strings = "?")) #read in the data
data <- hpc[hpc$Date %in% c("1/2/2007", "2/2/2007") ,] #subset for applicable dates
gap <- data$Global_active_power
png("plot1.png", width = 480, height = 480, units = "px")#create png
hist(gap, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")#construct plot
dev.off()
