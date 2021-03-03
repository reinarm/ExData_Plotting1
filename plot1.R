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


# Plot 1 - Histogram

# PNG Device
png("plot1.png", width = 480, height = 480)

# create plot
hist(df$Global_active_power, main = "Global Active Power", 
                             col = "red",
                             xlab = "Global Active Power (kilowatts)")

# close device
dev.off()
