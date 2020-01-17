# create CDMO files
source('R/01_Load_Wrangle_Run_CDMOFile.R')

# ----01 create new dataframe for mdl tables----
mdl_dat <- dat2 %>% 
  dplyr::select(station_code, date_sampled, cdmo_name, mdl, units)

base_mdl <- readr::read_csv(here::here('data', 'baseline_mdls.csv')) %>%
  janitor::clean_names()


# ----02.1 create mdl table of plant pigments----
plantpigs <- c("CHLA_N", "UncCHLA_N", "PHEA")

mdl_dat %>%
  dplyr::filter(cdmo_name %in% plantpigs) %>%
  write.csv(here::here('output', 'data', 'MDLs', 'plantpigmentsMDL_all.csv'))

# ----02.2 create mdl of plant pigments not equal to base MDL----
# NOTES:
# make a table with just the ones that change from the base MDL
# requires making separate dataframes
# also need to make sure you have the right MDL from the lab.

mdl_CHLA <- mdl_dat %>%
  dplyr::filter(cdmo_name == "CHLA_N" & mdl != 0.55)
mdl_UnCHLA <- mdl_dat %>%
  dplyr::filter(cdmo_name == "UncCHLA_N" & mdl != 0.4)
mdl_PHEA <- mdl_dat %>%
  filter(cdmo_name == "PHEA" & mdl != 0.4)

# bind rows together into one dataframe
mdl_plantpigs <- bind_rows(mdl_CHLA, mdl_UnCHLA, mdl_PHEA)

# export as table
write.csv(mdl_plantpigs, 
          here::here('output', 'data', 'MDLs', 'plantpigmentsMDL_diff.csv'))

# clean up environment
rm(mdl_CHLA, mdl_UnCHLA, mdl_PHEA, mdl_plantpigs, plantpigs)

# ----03.1 create mdl table of nonplant pigments----
nutrients <- c("NH4F",
               "NO2F",
               "NO23F",
               "PO4F", 
               "TKN",
               "TKNF",
               "TP",
               "TSS",
               "FECCOL_CFU",
               "ECOLI_MPN",
               "DOC")

mdl_dat %>%
  dplyr::filter(cdmo_name %in% nutrients) %>%
  write.csv(here::here('output', 'data', 'MDLs', 'nutrientsMDL_all.csv'))

# ----03.2 create mdl of nonplant pigments not equal to base MDL----
# NOTES:
# make a table with just the ones that change from the base MDL
# requires making separate dataframes
# also need to make sure you have the right MDL from the lab.

# create df that groups variables for fewer lines of code
mdl_nh4 <- mdl_dat %>%
  filter(cdmo_name == "NH4N" & mdl != 0.0020)
mdl_tkn <- mdl_dat %>%
  filter(cdmo_name == "TKN" & mdl != 0.08)
mdl_tknf <- mdl_dat %>%
  filter(cdmo_name == "TKNF" & mdl != 0.08)
mdl_no2 <- mdl_dat %>%
  filter(cdmo_name == "NO2F" & mdl != 0.002)
mdl_no3 <- mdl_dat %>%
  filter(cdmo_name == "NO3F" & mdl != 0.004)
mdl_no23 <- mdl_dat %>%
  filter(cdmo_name == "NO23F" & mdl != 0.004)
mdl_po4 <- mdl_dat %>%
  filter(cdmo_name == "PO4F" & mdl != 0.004)
mdl_tp <- mdl_dat %>%
  filter(cdmo_name == "TP" & mdl != 0.002)
mdl_tss <- mdl_dat %>%
  filter(cdmo_name == "TSS" & mdl != 2)
mdl_fec <- mdl_dat %>%
  filter(cdmo_name == "FECCOL_CFU" & mdl != 2)
mdl_ecoli <- mdl_dat %>%
  filter(cdmo_name == "ECOLI_MPN" & mdl != 1)
mdl_doc <- mdl_dat %>%
  filter(cdmo_name == "DOC" & mdl != 0.5)

# bind rows together into one dataframe
mdl_nutsall <- bind_rows(mdl_nh4, mdl_tkn, mdl_tknf, mdl_no2,
                         mdl_no3, mdl_no23, mdl_po4,
                         mdl_tp, mdl_tss, mdl_fec,
                         mdl_ecoli, mdl_doc)

write.csv(mdl_nutsall, here::here('output', 'data', 'MDLs', 'nutrientsMDL_diff.csv'))

rm(mdl_nh4, mdl_tkn, mdl_tknf, mdl_no2,
   mdl_no3, mdl_no23, mdl_po4,
   mdl_tp, mdl_tss, mdl_fec,
   mdl_ecoli, mdl_doc,
   mdl_nutsall, 
   base_mdl, mdl_dat)