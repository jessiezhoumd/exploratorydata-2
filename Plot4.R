## Q4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
## A. There has been an overall decrease in emissions from 1999 to 2008.

# Loading data
library("data.table")
path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

# Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subsetting SCC with coal values
coalMatches  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
subsetSCC <- SCC[coalMatches, ]

# Merging dataframes
NEISCC <- merge(NEI, subsetSCC, by="SCC")

# Summing emission data per year
totalEmissions <- tapply(NEISCC$Emissions, NEISCC$year, sum)

# Plotting
barplot(totalEmissions, xlab = "Year", ylab = "Total Emission (ton)", 
        main = "Total Emission from coal sources")