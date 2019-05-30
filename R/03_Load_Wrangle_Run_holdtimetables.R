# create CDMO files
source('R/01_Load_Wrangle_Run_CDMOFile.R')

# create dataframe for hold times
# hold time = date analyzed
ht_dat <- dat2 %>% 
  select(field.id, datetimestamp, component, analyzetime)
# make all names lowercase in field.id column
ht_dat$field.id <- tolower(ht_dat$field.id)

# remove spaces from component names
ht_dat$component2 <- gsub(" ","",ht_dat$component)


# ------------------------------------------------------
# hold times for Tier 1 Parameters
# ------------------------------------------------------
tier1 <- c("Ammonia-N",
           "Nitrite-N",
           "NO2NO3-N",
           "O-Phosphate-P",
           "Chlorophyll-a,Corrected",
           "Chlorophyll-a,Uncorrected",
           "Phaeophytin-a,corrected")
ht1_dat <- ht_dat %>%
  group_by(field.id, datetimestamp, analyzetime)%>%
  filter(component2 %in% tier1)
# ungroup 
ht1_dat <- ungroup(ht1_dat)
# rename column names to what export table should be
colnames(ht1_dat)[1] <- "SampleID"
colnames(ht1_dat)[2] <- "DateSampled"

# ---------------------------------------------------
# dealing with duplicate chlorophyll samples
# add a 1 and 2 at end of component name for duplicates
# in newcolumn named 'samplenames'
ht1_dat1 <- ht1_dat %>%
  group_by(SampleID, DateSampled, component)%>%
  mutate(count = seq(n()), samplenames = paste0(component,count))

ht1_dat2 <- ht1_dat1%>%
  ungroup()%>%
  select(-component2, -count, -component)

# make dataset wide
ht1_datwide <- ht1_dat2 %>%
  spread(key = samplenames,
         value= analyzetime)

# export and write as csv
write.csv(ht1_datwide, "output/data/HoldTimes/tier1.csv")

# ------------------------------------------------------
# hold times for Tier 2 Parameters
# ------------------------------------------------------
tier2 <- c("OrganicCarbon",
           "Total-P",
           "KjeldahlNitrogen",
           "KjeldahlNitrogenFiltered",
           "TSS",
           "FecalColiforms-MembraneFilter",
           "EscherichiaColi-Quanti-Tray")
ht2_dat <- ht_dat %>%
  group_by(field.id, datetimestamp, analyzetime)%>%
  filter(component2 %in% tier2)
# ungroup and remove component2 column from df
ht2_dat <- ht2_dat%>%
  ungroup() %>%
  select(-component2)
# rename column names to what export table should be
colnames(ht2_dat)[1] <- "SampleID"
colnames(ht2_dat)[2] <- "DateSampled"

# make dataset wide
ht2_datwide <- ht2_dat %>%
  spread(key = component,
         value= analyzetime)
# export and write as csv
write.csv(ht2_datwide, "output/data/HoldTimes/tier2.csv")