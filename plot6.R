###############################################################################
# Before running this script please make sure that the required data files
# "summarySCC_PM25.rds" and "Source_Classification_Code.rds" are in your 
# working directory. This script requires ggplot2 package.
###############################################################################
library(ggplot2)

#Read the rds data for PM2.5 Emissions and source classification code 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset city vehicles data
vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicleSCC <- SCC[vehicle,]$SCC
vehicleNEIVal <- NEI[NEI$SCC %in% vehicleSCC,]
baltimoreVehicleNEI <- subset(vehicleNEIVal, fips == "24510")
losangelesVehicleNEI <- subset(vehicleNEIVal, fips == "06037")
baltimoreVehicleNEI[, "city"] <- "Baltimore City"
losangelesVehicleNEI[, "city"] <- "Los Angeles County"
baltiLa <- rbind(baltimoreVehicleNEI, losangelesVehicleNEI)

# Make plot for PM2.5 emissions from motor vehicle related sources in Baltimore and Los Angeles between 1999-2008 using ggplot2
g <- ggplot(aes(factor(year), Emissions, fill = city), data = baltiLa)
g + geom_bar(stat = "identity", aes(fill=year))+
facet_grid(.~city)+
theme_bw()+
guides(fill = FALSE)+
labs(x = "Year", y = expression("Total PM"[2.5]*" Emission (Tons)")) + 
labs(title = expression("PM"[2.5]*" Motor Vehicle Sources Emission in Baltimore & Los Angeles between 1999-2008"))

# Save the file to plot6.png
ggsave(file = "plot6.png")
