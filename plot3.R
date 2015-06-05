#
# Coursera | Exploratory Data Analysis
# Project 2
# plot3.R
#

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make 
# a plot answer this question.

library(ggplot2) 

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

# Factorize type
d$type <- as.factor(d$type) 

# Aggregate total yearly emissions per type
d <- aggregate(Emissions~year+type, data=d, sum)

# Plot the chart
qplot(data=d, x=year, y=Emissions, colour=type, geom="line",
     main="Total PM2.5 emissions per year per type in Baltimore (in tons)",
     xlab="Year",
     ylab="Emissions")

# Save plot to file
ggsave(file="plot3.png", width=6, height=4, dpi=100)
