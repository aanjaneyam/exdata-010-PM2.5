###############################################################################
# Before running this script please make sure that the required data file
# "summarySCC_PM25.rds" is in your working directory.
###############################################################################

#Read the rds data for PM2.5 Emissions
NEI <- readRDS("summarySCC_PM25.rds")

# subset emission data for Baltimore city.
baltimoreNEI <- subset(NEI, fips == "24510")

# aggregate total PM2.5 emission from all Baltimore city sources for each of the years 1999, 2002, 2005, and 2008.
baltimoreEmission <- aggregate(Emissions ~ year, baltimoreNEI,sum)

# Create PNG graphic device
png(filename = "plot2.png", width = 480, height = 480)

barplot(
		baltimoreEmission$Emissions,
		names.arg=baltimoreEmission$year,
		col=terrain.colors(4),
		xlab="Year",
		ylab="Total Emmission (Tons)",
		main="PM2.5 emission from all Baltimore city sources"
)

dev.off()