library(dplyr)
library(tidyr)

# Get and filter for 2017 data
# seattle.data <- read.csv("D:/info362/Seattle_Police_Data_2017/data/Seattle_Police_Department_911_Incident_Response.csv",
#                          stringsAsFactors = FALSE)
# seattle.data.2017 <- seattle.data %>%
#                      filter(grepl("2017+", seattle.data$Event.Clearance.Date)) %>%
#                      select(Event.Clearance.Description, Event.Clearance.SubGroup, Event.Clearance.Group,
#                             Event.Clearance.Date, District.Sector, Zone.Beat, Latitude, Longitude)

# write.csv(seattle.data.2017, file = "Seattle_Police_911_Incident_Response_2017.csv", row.names = FALSE)

#Read in 2017 data
seattle.data <- read.csv("D:/info362/Seattle_Police_Data_2017/data/Seattle_Police_911_Incident_Response_2017.csv",
                         stringsAsFactors = FALSE)

#Unique categories reported during incident calls
descript.cat <- unique(seattle.data$Event.Clearance.Description)
clearance.subg.cat <- unique(seattle.data$Event.Clearance.SubGroup)
clearance.group.cat <- unique(seattle.data$Event.Clearance.Group)

#Split clearance date column into "Date" and "Time"
seattle.data <- separate(seattle.data,
                         col = "Event.Clearance.Date",
                         into = c("Date", "Time"),
                         sep = " ",
                         extra = "merge")
#Only retain the hour of each inccident call (24 hour format)
seattle.data$Time <- strptime(seattle.data$Time, "%I:%M:%S %p") %>%
                     format("%H")
