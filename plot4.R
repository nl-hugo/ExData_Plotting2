#
# Coursera | Exploratory Data Analysis
# Project 2
# plot4.R
#

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

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

# Subset coal combustion-related sources
c <- subset(SCC, grepl("Coal", EI.Sector), select=SCC)
c <- as.character(c$SCC)

# Subset sources 
d <- subset(NEI, SCC %in% c)

# Aggregate total yearly emissions
d <- aggregate(Emissions~year, data=d, sum)

# Plot the chart
qplot(data=d, x=year, y=Emissions, geom="line", 
     main="Total PM2.5 coal combustion-related emissions per year (in tons)",
     xlab="Year",
     ylab="Emissions")

# Save plot to file
ggsave(file="plot4.png")
