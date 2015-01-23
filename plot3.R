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

# Plot PM2.5 emmission by source type in Baltimore city between 1999-2008 using ggplot2 system.
 
g <- ggplot(aes(factor(year), Emissions, fill = type), data = baltimoreNEI)
g + geom_bar(stat = "identity")+
facet_grid(.~type)+
theme_bw()+
guides(fill = FALSE)+
labs(x = "Year", y = expression("Total PM"[2.5]*" Emission (Tons)")) + 
labs(title = expression("PM"[2.5]*" Emissions for Baltimore City by Source Type 1999-2008"))

# Save the file to plot3.png
ggsave(file = "plot3.png")
