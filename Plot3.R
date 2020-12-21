## Q3.Of the four types of sources indicated by the (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## A. nonpoint, nonroad, onroad
## Which have seen increases in emissions from 1999–2008? 
## A. point

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

# summing emission data per year per type
data <- aggregate(Emissions ~ year + type, baltimore, sum)

# Plotting
library(ggplot2)
g <- ggplot(data, aes(year, Emissions, color = type))
g + geom_line() +
    xlab("Year") +
    ylab(expression("Total PM"[2.5]*" Emissions")) +
    ggtitle("Total Emissions per type in Baltimore")