###############################################################################
# Before running this script please make sure that the required data files "summarySCC_PM25.rds"
# and "Source_Classification_Code.rds" are in your working directory.
###############################################################################

#Read the rds data for PM2.5 Emissions

NEI <- readRDS("summarySCC_PM25.rds")
#Read the rds data for Source Classification Code Table
SCC <- readRDS("Source_Classification_Code.rds")

# aggregate total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
emissionTotal <- aggregate(Emissions ~ year,NEI, sum)

#Names the colums of aggregated data emissionTotal
names(emissionTotal) <- c('Year', 'TotalEmission')

# Create PNG graphic device
png(filename = "plot1.png", width = 480, height = 480)

# Plot the total PM2.5 Emissions from all sources using base plotting system
barplot(
		(emissionTotal$Emissions)/10^6,
		names.arg=emissionTotal$year,
		xlab="Year",
		ylab="Total Emmission (Tons)",
		main="Total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008"
)
