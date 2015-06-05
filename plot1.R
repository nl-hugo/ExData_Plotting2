#
# Coursera | Exploratory Data Analysis
# Project 2
# plot1.R
#

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

# Check if data directory exists, create one if needed
if (!file.exists("data")) {
  dir.create("data")
}

# Download the dataset and unzip the files
if (!file.exists("./data/summarySCC_PM25.rds")) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileURL, destfile="./data/dataset.zip")
  unzip("./data/dataset.zip", exdir="./data")
}

# Read the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Aggregate total yearly emissions
d <- aggregate(Emissions~year, data=NEI, sum)

# Plot the histogram
plot(d, type="l", col="blue",
     main="Total PM2.5 emissions per year (in tons)",
     xlab="Year",
     ylab="Emissions")

# Save plot to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
