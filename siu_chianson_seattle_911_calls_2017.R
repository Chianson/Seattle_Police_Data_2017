library(dplyr)
library(tidyr)
library(ggplot2)
# Get and filter for 2017 data
# seattle.data <- read.csv("D:/info362/Seattle_Police_Data_2017/data/Seattle_Police_Department_911_Incident_Response.csv",
#                          stringsAsFactors = FALSE)
# seattle.data.2017 <- seattle.data %>%
#                      filter(grepl("2017+", seattle.data$Event.Clearance.Date)) %>%
#                      select(Event.Clearance.Description, Event.Clearance.SubGroup, Event.Clearance.Group,
#                             Event.Clearance.Date, District.Sector, Zone.Beat, Latitude, Longitude)

# write.csv(seattle.data.2017, file = "Seattle_Police_911_Incident_Response_2017.csv", row.names = FALSE)

#Read in 2017 data
seattle.data <- read.csv("data/Seattle_Police_911_Incident_Response_2017.csv")

#Date data was downloaded
date.downloaded <- as.Date("01-19-2018", format = "%d-%M-%Y")

#Split clearance date column into "Date" and "Time"
seattle.data <- separate(seattle.data,
                         col = "Event.Clearance.Date",
                         into = c("Date", "Time"),
                         sep = " ",
                         extra = "merge") #merges time + am or pm, e.g. 6:00 pm

#Only retain the hour of each inccident call (24 hour format)
seattle.data$Time <- strptime(seattle.data$Time, "%I:%M:%S %p") %>%
                     format("%H")
seattle.data$day <- weekdays(as.Date(seattle.data$Date, format = "%d/%M/%Y"))

getFreqDf <- function(column){
  
}
#Unique categories reported during incident calls are placed into tables
descript.cat <- as.data.frame(table(seattle.data$Event.Clearance.Description))
names(descript.cat) <- c("description", "Freq")
clearance.subg.cat <- table(seattle.data$Event.Clearance.SubGroup)
clearance.group.cat <- table(seattle.data$Event.Clearance.Group)

# crimes by day
crimes.by.day <- as.data.frame(table(seattle.data$day))
names(crimes.by.day) <- c("Day", "Freq")