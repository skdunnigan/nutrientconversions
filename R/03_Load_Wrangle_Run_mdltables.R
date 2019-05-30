# create CDMO files
source('R/01_Load_Wrangle_Run_CDMOFile.R')

# --------------------------------------------------
# create new dataframe for mdl tables
# --------------------------------------------------
mdl_dat <- dat2 %>% 
  select(field.id, datetimestamp, component, mdl, units)

# remove spaces from component names
mdl_dat$component2 <- gsub(" ","",mdl_dat$component)
mdl_dat$mdl <- as.numeric(mdl_dat$mdl) # make sure the mdl column is seen as numeric
# make all names lowercase in field.id column
mdl_dat$field.id <- tolower(mdl_dat$field.id)


# --------------------------------------------------
## plant pigments MDL table
# --------------------------------------------------
plantpigs <- c("Chlorophyll-a,Corrected", "Chlorophyll-a,Uncorrected", "Phaeophytin-a")

mdl_plant1 <- mdl_dat %>%
  group_by(field.id, datetimestamp)%>%
  filter(component2 %in% plantpigs)
# rename column names to what export table should be
colnames(mdl_plant1)[1] <- "SampleID"
colnames(mdl_plant1)[2] <- "DateSampled"
colnames(mdl_plant1)[3] <- "Component"
colnames(mdl_plant1)[4] <- "MDL"
colnames(mdl_plant1)[5] <- "Units"
# ungroup and remove component 2 from final file
mdl_plant1a <- mdl_plant1 %>%
  ungroup()%>%
  select(-component2)
mdl_plant1 <- ungroup(mdl_plant1)
# export as csv to output folder
write.csv(mdl_plant1a, "output/data/MDLs/plantpigmentsMDL_all.csv")

# --------------------------------------------------
## plant pigments MDL change tables
# --------------------------------------------------
mdl_CHLA <- mdl_plant1 %>%
  group_by(SampleID, DateSampled, component2) %>%
  filter(component2 == "Chlorophyll-a,Corrected" & MDL != 0.55)
mdl_UnCHLA <- mdl_plant1 %>%
  group_by(SampleID, DateSampled, component2) %>%
  filter(component2 == "Chlorophyll-a,Uncorrected" & MDL != 0.4)
mdl_PHEA <- mdl_plant1 %>%
  group_by(SampleID, DateSampled, component2) %>%
  filter(component2 == "Phaeophytin-a" & MDL != 0.4)

# bind rows together into one dataframe
mdl_plantpigs <- bind_rows(mdl_CHLA, mdl_UnCHLA, mdl_PHEA)

# ungroup and remove component 2 from final file
mdl_plantpigsa <- mdl_plantpigs %>%
  ungroup()%>%
  select(-component2)
# export as csv to output folder
write.csv(mdl_plantpigsa, "output/data/MDLs/plantpigmentsMDL_diff.csv")

# --------------------------------------------------
### nonplant pigments MDL table
# --------------------------------------------------
nutrients <- c("Ammonia-N", 
               "KjeldahlNitrogen",
               "KjeldahlNitrogenFiltered",
               "Nitrate-N",
               "Nitrite-N",
               "NO2NO3-N",
               "O-Phosphate-P",
               "Total-P",
               "TSS",
               "FecalColiforms-MembraneFilter",
               "EscherichiaColi-Quanti-Tray",
               "OrganicCarbon")
mdl_nut <- mdl_dat %>%
  group_by(field.id, datetimestamp)%>%
  filter(component2 %in% nutrients)
# rename column names to what export table should be
colnames(mdl_nut)[1] <- "SampleID"
colnames(mdl_nut)[2] <- "DateSampled"
colnames(mdl_nut)[3] <- "Component"
colnames(mdl_nut)[4] <- "MDL"
colnames(mdl_nut)[5] <- "Units"
# ungroup and remove component 2 from final file
mdl_nut1 <- mdl_nut %>%
  ungroup()%>%
  select(-component2)
mdl_nut <- ungroup(mdl_nut)
# export as csv to output folder
write.csv(mdl_nut1, "output/data/MDLs/nutrientsMDL_all.csv")

# --------------------------------------------------
### nonplant pigments MDL changes table
# --------------------------------------------------

# create df that groups variables for fewer lines of code
mdl_nut2 <- mdl_nut %>%
  group_by(SampleID, DateSampled, component2) 

mdl_nh4 <- mdl_nut2 %>%
  filter(component2 == "Ammonia-N" & MDL != 0.0020)
mdl_tkn <- mdl_nut2 %>%
  filter(component2 == "KjeldahlNitrogen" & MDL != 0.08)
mdl_tknf <- mdl_nut2 %>%
  filter(component2 == "KjeldahlNitrogenFiltered" & MDL != 0.08)
mdl_no2 <- mdl_nut2 %>%
  filter(component2 == "Nitrite-N" & MDL != 0.002)
mdl_no3 <- mdl_nut2 %>%
  filter(component2 == "Nitrate-N" & MDL != 0.004)
mdl_no23 <- mdl_nut2 %>%
  filter(component2 == "NO2NO3-N" & MDL != 0.004)
mdl_po4 <- mdl_nut2 %>%
  filter(component2 == "O-Phosphate-P" & MDL != 0.004)
mdl_tp <- mdl_nut2 %>%
  filter(component2 == "Total-P" & MDL != 0.002)
mdl_tss <- mdl_nut2 %>%
  filter(component2 == "TSS" & MDL != 2)
mdl_fec <- mdl_nut2 %>%
  filter(component2 == "FecalColiforms-MembraneFilter" & MDL != 2)
mdl_ecoli <- mdl_nut2 %>%
  filter(component2 == "EscherichiaColi-Quanti-Tray" & MDL != 1)
mdl_doc <- mdl_nut2 %>%
  filter(component2 == "OrganicCarbon" & MDL != 0.5)

# bind rows together into one dataframe
mdl_nutsall <- bind_rows(mdl_nh4, mdl_tkn, mdl_tknf, mdl_no2,
                         mdl_no3, mdl_no23, mdl_po4,
                         mdl_tp, mdl_tss, mdl_fec,
                         mdl_ecoli, mdl_doc)

# ungroup and remove component 2 from final file
mdl_nutsalla <- mdl_nutsall %>%
  ungroup()%>%
  select(-component2)
# export as csv to output folder
write.csv(mdl_nutsalla, "output/data/MDLs/nutrientsMDL_diff.csv")