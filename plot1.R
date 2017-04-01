#load library lubridate for easier date convertion
library(lubridate)

#download the zip file to local directory
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data.zip")

#unzip the file
unzip("data.zip")

#read the txt file by using the read table command and define it as data in environment
household_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#subsetting the data to include data only in Feb 1st 2007 and Feb 2nd 2007. 
#notice that the values in date columns are factors, I simply match the date to "1/2/2007" and "2/2/2007"
#without converting them to a date format first
#I defined this new environmental variable as refined_data

refined_data <- household_data[household_data$Date == "1/2/2007" | household_data$Date == "2/2/2007",]

#convert the Date column from factor variable to date variable
refined_data$Date = dmy(refined_data$Date)

#ignore this one. I thought the instruction was asking the per minute difference between these two days
#a <- refined_data %>% group_by(Time) %>% mutate(diff = c(NA, diff(as.numeric(as.character(Global_active_power)))))

#converting all the factor values from column 3 to 9 to numeric values
for (i in 3:9) {refined_data[[i]] = as.numeric(as.character(refined_data[[i]]))}

#set the png parameter
png("plot1.png", width = 480, height = 480, units = "px")

#construct the histgram in plot 1
hist(refined_data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()



