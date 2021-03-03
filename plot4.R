## Exploratory Data Assignment Week 1

## The Assigment is to read in Data from the UCI Irvine Machine Learning Repository
## and reconstruct four plots. Create for each plot a seperate script.


# set working directory
setwd("~/RProgramming/05_JHU/ExData_Plotting1")

# load packages
library(tidyverse)
library(lubridate)
library(data.table)


# download data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./household_power_consumption.zip")

# write log
log_url <- paste0("Downloaded from: ", fileURL)  # save URL
log_date <- paste0("Downloaded at: ", date())  # save date of download

log <- file("log.txt")  # create logfile
writeLines(c(log_url, log_date), log)  # write URL and date of download
close(log)  # close log file to save


# unzip data
unzip("./household_power_consumption.zip", exdir = "./ExData_Plotting1")


# read in data and subsetting
df <- fread("./household_power_consumption.txt", na.strings = "?")
df <- subset(df, as.Date(df$Date, "%d/%m/%Y") >= "2007-02-01" & 
                 as.Date(df$Date, "%d/%m/%Y") < "2007-02-03")


# convert format
df$Global_active_power <- as.numeric(df$Global_active_power)

# compute new variable
df$DateTime <- as.POSIXct(paste(df$Date, df$Time), 
                          format = "%d/%m/%Y %H:%M:%S")


# Plot 4 - Facets

# PNG Device
png("plot4.png", width = 480, height = 480)

# set parameter for plot
par(mfrow = c(2, 2))

# create plot1
plot(x =  df$DateTime,
     y = df$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# create plot2
plot(x = df$DateTime,
     y = df$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# create plot3
plot(x = df$DateTime, y = df$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering", col = "red")
lines(x = df$DateTime, y = df$Sub_metering_2, col = "green")
lines(x = df$DateTime, y = df$Sub_metering_3, col = "blue")
legend("topright", 
       col = c("red", "green", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_2"),
       lty = c(1, 1), bty = "n", cex = .5)

# create plot4
plot(x = df$DateTime,
     y = df$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

# close device
dev.off()
