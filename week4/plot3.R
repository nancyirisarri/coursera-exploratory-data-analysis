library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

# plot emissions for types of sources in Baltimore City, Maryland (fips == "24510") from 1999 to 2008
totals <- NEI %>% filter(fips == "24510") %>% group_by(year, type) %>% summarize(total = sum(Emissions, na.rm=TRUE))

totals$type <- as.factor(totals$type)

p <- ggplot(totals, aes(x=year, y=total, color=type, group=type)) + geom_point() + geom_line() + facet_grid(. ~ type) +
  ggtitle("PM2.5 Emissions in Baltimore City by Type of Source") +
  xlab("Year") + ylab("PM2.5 Emissions") + theme(legend.position="none") 
p + theme(panel.spacing = unit(0.5, "lines"))

ggsave("plot3.png", width = 7, height = 3.5)