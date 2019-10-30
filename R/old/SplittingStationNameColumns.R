

# ---------------------------------------------------
# create a new dataframe with the field.id column
# separated into 'stationcode', 'monitoringprogram', 
# and 'rep'
# ---------------------------------------------------
dat4 <- dat3 %>%
  separate(field.id, 
           into = c("stationcode", "num"), 
           sep = "(?<=[A-Za-z])(?=[0-9])")%>%
  separate(num,
           into = c("monitoringprogram", "replicate"),
           sep = "[.]")
dat4 <- dat4 %>%
  separate(temperature,
           into = c("wtemp", "tempunits"),
           sep = "(\\s+)")%>%
  separate(specific.conductance,
           into = c("spc", "spcunits"),
           sep = "(\\s+)")
dat5 <- select(dat4, -spcunits, -tempunits)