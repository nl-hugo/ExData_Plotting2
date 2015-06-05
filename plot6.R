#
# Coursera | Exploratory Data Analysis
# Project 2
# plot6.R
#

# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

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

# Subset motor vehicle-related sources
c <- subset(SCC, grepl("Vehicle", EI.Sector), select=SCC)
c <- as.character(c$SCC)

# Subset sources and fips
d <- subset(NEI, SCC %in% c & fips %in% c("24510","06037"))

# Factor cities
d$city <- as.factor(ifelse(d$fips=="24510", "Baltimore City", "Los Angeles County"))

# Aggregate total yearly emissions
d <- aggregate(Emissions~year+city, data=d, sum)

# Plot the chart
qplot(data=d, x=year, y=Emissions, color=city, geom="line", 
     main="Total PM2.5 motor vehicle-related emissions per year (in tons)",
     xlab="Year",
     ylab="Emissions")

# Save plot to file
ggsave(file="plot6.png")
