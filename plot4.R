#load library lubridate for easier date convertion
library(lubridate)

#read the txt file by using the read table command and define it as data in environment
household_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#subsetting the data to include data only in Feb 1st 2007 and Feb 2nd 2007. 
#notice that the values in date columns are factors, I simply match the date to "1/2/2007" and "2/2/2007"
#without converting them to a date format first
#I defined this new environmental variable as refined_data
refined_data <- household_data[household_data$Date == "1/2/2007" | household_data$Date == "2/2/2007",]

#convert the Date column from factor variable to date variable
refined_data$Date = dmy(refined_data$Date)

#converting all the factor values from column 3 to 9 to numeric values
for (i in 3:9) {refined_data[[i]] = as.numeric(as.character(refined_data[[i]]))}

#attach a new column with date and time in a POSIXct format
refined_data[,"date_time"] = ymd_hms(paste(refined_data$Date, refined_data$Time))

#set the png parameter
png("plot4.png", width = 480, height = 480, units = "px")

#set the par to c(2,2)
par(mfrow = c(2,2))

#plot the four plots
with(refined_data, plot(date_time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
with(refined_data, plot(date_time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
plot(refined_data$date_time, refined_data$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
points(refined_data$date_time, refined_data$Sub_metering_1, type = "l")
points(refined_data$date_time, refined_data$Sub_metering_2, type = "l", col = "red")
points(refined_data$date_time, refined_data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
with(refined_data, plot(date_time, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

dev.off()
