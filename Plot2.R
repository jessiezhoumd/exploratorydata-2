## Q2 Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008?
## A. Yes.

# Loading data
library("data.table")
path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

# Reading and subsetting data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
baltimore <- subset(NEI, fips == "24510")

# Summing emissions per year
totalEmissions <- tapply(baltimore$Emissions, baltimore$year, sum)

# Plotting
barplot(totalEmissions, xlab = "Year", ylab = "Total Emission (ton)", 
        main = "Total Emission per year in Baltimore")