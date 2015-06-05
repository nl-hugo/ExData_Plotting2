#
# Coursera | Exploratory Data Analysis
# Project 2
# plot2.R
#

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

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

# Subset Baltimore data
d <- subset(NEI, fips == "24510")

# Aggregate total yearly emissions
d <- aggregate(Emissions~year, data=d, sum)

# Plot the histogram
plot(d, type="l", col="blue",
     main="Total PM2.5 emissions per year in Baltimore (in tons)",
     xlab="Year",
     ylab="Emissions")

# Save plot to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
