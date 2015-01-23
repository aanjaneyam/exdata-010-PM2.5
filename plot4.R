###############################################################################
# Before running this script please make sure that the required data files
# "summarySCC_PM25.rds" and "Source_Classification_Code.rds" are in your 
# working directory. This script requires ggplot2 package.
###############################################################################
library(ggplot2)

#Read the rds data for PM2.5 Emissions and source classification code 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset coal cumbustion data
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE)
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalCombustionSCC <- SCC[coal & combustion,]$SCC
coalCumbustionNEIVal <- NEI[NEI$SCC %in% coalCombustionSCC,]
coalCumbustionNEITotal <- aggregate(Emissions~year, coalCumbustionNEIVal, sum)

# Make plot for emissions from coal combustion-related sources from 199-2008 using ggplot2

g <- ggplot(aes(factor(year), Emissions/10^5), data = coalCumbustionNEITotal)
g + geom_bar(stat = "identity", fill="#FF9999", colour="black", width=0.75)+
theme_bw()+
guides(fill = FALSE)+
labs(x = "Year", y = expression("Total PM"[2.5]*" Emission (Tons)")) + 
labs(title = expression("PM"[2.5]*" Emissions from Coal Combustion Sources Across US between 1999-2008"))

# Save the file to plot4.png
ggsave(file = "plot4.png")