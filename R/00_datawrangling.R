# this script will take the LIMS file and break it down
# into one datafile in long format with all parameters
# must run 
#source('R/01_Load_Wrangle_Run_CDMOFile.R')

# ---------------------------------------------------
# keep only relevant columns 
# ---------------------------------------------------
dat3 <- select(dat2, field.id, datetimestamp, component, result, remark,
               temperature, specific.conductance, ph, dissolved.o2, sample.id)

# ---------------------------------------------------
# separate units in environmental data to leave only values
# ---------------------------------------------------
dat4 <- dat3 %>%
  separate(temperature,
           into = c("temperature", "tempunits"),
           sep = "(\\s+)")%>%
  separate(specific.conductance,
           into = c("specificconductance", "spcunits"),
           sep = "(\\s+)")%>%
  separate(dissolved.o2,
           into = c("dissolvedoxygen", "o2units"),
           sep = "(\\s+)")
# remove the unit columns
dat5 <- select(dat4, -spcunits, -tempunits, -o2units)

# ---------------------------------------------------
# reformat dataframe 
# ---------------------------------------------------
dat5$field.id <- tolower(dat5$field.id)
dat5$component <- tolower(dat5$component)
## set component to have factors
dat5$component <- as.factor(dat5$component)

# ---------------------------------------------------
# split into multiple dataframes 
# ---------------------------------------------------
dat_nut <- dat5 %>% select(field.id, sample.id, datetimestamp, component, result) # just nutrient analysis data
dat_rem <- dat5 %>% select(field.id, sample.id, datetimestamp, component, remark) # FDEP lab QAQC codes
dat_env <- dat5 %>% select(field.id, sample.id, datetimestamp, temperature, 
                           specificconductance, ph, dissolvedoxygen) # environmental data associated with samples

# ---------------------------------------------------
# convert environmental data into long format
# ---------------------------------------------------
dat_envm <- dat_env %>% 
  melt(id=c("field.id", "sample.id", "datetimestamp"), 
       na.rm=FALSE)

# ---------------------------------------------------
# dealing with duplicate chlorophyll samples
# ---------------------------------------------------
# nutrient dataset
dat_nut_alpha <- dat_nut %>%
  group_by(field.id, datetimestamp, component)%>%
  mutate(count = seq(n()), newcolumn = paste0(component,count))

dat_nut_beta <- dat_nut_alpha%>%
  ungroup()%>%
  select(-sample.id, -component, -count)

# the remarks dataset

dat_rem_alpha <- dat_rem %>%
  group_by(field.id, datetimestamp, component)%>%
  mutate(count = seq(n()), newcolumn = paste0(component,count))

dat_rem_beta <- dat_rem_alpha%>%
  ungroup()%>%
  select(-sample.id, -component, -count)

dat_rem_beta$flagcomponent <- paste("F", dat_rem_beta$newcolumn, sep="_")

dat_rem_gamma <- dat_rem_beta%>%
  select(-newcolumn)

# ---------------------------------------------------
# remove duplicates in environmental dataset
# ---------------------------------------------------

dat_env_alpha <- dat_envm %>%
  select(-sample.id) %>%
  unique()


# ---------------------------------------------------
# making data wide
# ---------------------------------------------------  
dat_nutwide <- dat_nut_beta%>%
  spread(key = newcolumn, 
         value = result)

dat_envwide <- dat_env_alpha %>%
  spread(key = variable,
         value= value)

dat_remwide <- dat_rem_gamma %>%
  spread(key = flagcomponent,
         value= remark)

# ---------------------------------------------------
# merging the dataframes
# --------------------------------------------------- 
new_data <- full_join(dat_envwide, dat_nutwide, by = c("field.id", "datetimestamp"))
new_datb <- full_join(new_data, dat_remwide, by = c("field.id", "datetimestamp"))

# reordering columns

big_dat <- new_datb %>%
  separate(field.id, 
           into = c("stationcode", "num"), 
           sep = "(?<=[A-Za-z])(?=[0-9])")%>%
  separate(num,
           into = c("monitoringprogram", "replicate"),
           sep = "[.]")

# replace all NAs with blanks
big_dat1 <- sapply(big_dat, as.character)
big_dat1[is.na(big_dat1)] <- " "
big_dat1<-as.data.frame(big_dat1)
CDMOdatALL <- big_dat1[,c(1,4,2,3,5:82)] #the large number will need to change dependent upon your number of components
# ---------------------------------------------------
# export as CSV file
# --------------------------------------------------- 
write.csv(CDMOdatALL, file="output/data/CDMOFormat_all.csv")