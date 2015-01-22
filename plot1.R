###############################################################################
# Before running this script please make sure that the required data file
# "summarySCC_PM25.rds" is in your working directory.
###############################################################################

#Read the rds data for PM2.5 Emissions
NEI <- readRDS("summarySCC_PM25.rds")

# aggregate total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
emissionTotal <- aggregate(Emissions ~ year,NEI, sum)

# Create PNG graphic device
png(filename = "plot1.png", width = 480, height = 480)

# Plot the total PM2.5 Emissions from all United States sources using base plotting system
barplot(
		(emissionTotal$Emissions)/10^6,
		names.arg=emissionTotal$year,
		col = heat.colors(4),
		xlab="Year",
		ylab="Total Emmission (Tons)",
		main="PM2.5 emission from all US sources between 1999-2008"
)

# Close graphic device
dev.off()