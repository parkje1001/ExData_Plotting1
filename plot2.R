## Set working directory
setwd("C:/Users/james_000/Desktop/DataScience/Exploratory/Week1")

## URL of ZIP file to download
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Download the zip file to the working directory
download.file(fileUrl, destfile = "household.zip")
## Unzip into the working directory
unzip("household.zip")

## Read in the data
d <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors=FALSE)

## Convert Date column to correct format for subsetting
d$Date <- as.Date(d$Date, "%d/%m/%Y")
## Subset the data for specific dates
dOne <- as.Date("2007/02/01") # Start date
dTwo <- as.Date("2007/02/02") # End date
dFinal <- subset(d, Date %in% dOne:dTwo)

## Remove the non-subsetted data frame and cleanup the memory
rm(d)
gc()

## Convert rest of needed columns to correct format
dFinal$Time <- format(dFinal$Time, format="%H:%M:%S")
dFinal$Global_active_power <- as.numeric(dFinal$Global_active_power)

## Merge date and time into single column
dateTime <- strptime(paste(dFinal$Date, dFinal$Time, sep=" "), "%Y-%m-%d %H:%M:%S")
## Add merged datetime column into subsetted dataframe
dFinal <- cbind(dFinal, dateTime)

## Set up to create the plot as a PNG file in the working directory
png(filename = "plot2.png", width = 480, height = 480)

## Plot the line for Global_active_power as a function of dateTime
with(dFinal, plot(dateTime, Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l"))

## Turn off the PNG device so file can be opened
dev.off()