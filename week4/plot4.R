library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008
# column names [1] "fips"      "SCC"       "Pollutant" "Emissions" "type"      "year"