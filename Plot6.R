## Q6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California. Which city has seen greater changes over time in motor vehicle emissions?
## A. Los Angeles County

# Loading data
library("data.table")
path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

# Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
baltimore <- subset(NEI, fips == "24510")
los <- subset(NEI, fips == "06037")

# Subsetting SCC with vehicle values
vehicleMatches  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
subsetSCC <- SCC[vehicleMatches, ]

# Merging dataframes, adding city variable
dataBaltimore <- merge(baltimore, subsetSCC, by="SCC")
dataBaltimore$city <- "Baltimore City"
dataLos <- merge(los, subsetSCC, by="SCC")
dataLos$city <- "Los Angeles County"
data <- rbind(dataBaltimore, dataLos)

# Summing emission data per year per type
data <- aggregate(Emissions ~ year + city, data, sum)

# Plotting
g <- ggplot(data, aes(year, Emissions, color = city))
g + geom_line() +
    xlab("Year") +
    ylab(expression("Total PM"[2.5]*" Emissions")) +
    ggtitle("Total Emissions from motor sources in Baltimore and Los Angeles")
