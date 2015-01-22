###############################################################################
# Before running this script please make sure that the required data file
# "summarySCC_PM25.rds" is in your working directory. This script requires ggplot2
# package.
###############################################################################
library(ggplot2)

#Read the rds data for PM2.5 Emissions
NEI <- readRDS("summarySCC_PM25.rds")

# subset emission data for Baltimore city.
baltimoreNEI <- subset(NEI, fips == "24510")

# Create PNG graphic device
png(filename = "plot3.png", width = 480, height = 480)

# Plot pm 2.5 emmission by source type in Baltimore city between 1999-2008 using ggplot2 system.
 
qplot(year, Emissions, data = baltimoreNEI, group = type, color = type, 
		geom = c("point", "line"), 
		ylab = expression("Total Baltimore PM"[2.5], Emissions),
		xlab = "Year", 
		main = "Total Emissions in Baltimore by Type of Pollutant")