# --------------------------------------------------
# load libraries and data files
source('R/00_loadpackages.R')

# --------------------------------------------------
# load GTMNERR SWMP nutrient dataset
# load file with CDMO SWMP names
# load GTMNERR SWMP field data
# --------------------------------------------------

dat <- readxl::read_xlsx(here::here('data', 
                                    'fromLIMS', 
                                    'GTM_NERR_01012020_12112020_LIMS_051821_skd.xlsx')) %>% 
  janitor::clean_names()

names <- readr::read_csv(here::here('data', 'componentnames.csv')) %>%
  janitor::clean_names()

# inspect the data
glimpse(dat)

# --------------------------------------------------
# remove component_short
# force names to lowercase 
# remove any spaces in station_code
# merge cdmo names file with dataframe to convert
# set cdmo_name to factor
# --------------------------------------------------
dat2 <- dat %>%
  dplyr::mutate(station_code = tolower(field_id),
                station_code = gsub(" ","", station_code),
                site = tolower(site_location),
                component_long = tolower(component)) %>%
  dplyr::left_join(names, by = "component_long") %>%
  dplyr::mutate(cdmo_name = forcats::as_factor(cdmo_name),
                result = as.numeric(result)) %>%
  dplyr::select(-temperature,-specific_conductance,-dissolved_o2, -x5) %>% 
  dplyr::select(station_code, site, date_sampled, analysis, cdmo_name, component_long, result, remark, mdl,
                pql, units, test_comments, date_analyzed) %>% 
  dplyr::filter(station_code != "fieldblank") 

rm(names)

# export as a new file to add in the ALS lab data from months 04-06, resume with new file import on line 49
# readr::write_excel_csv(dat2, here::here('output', 'data', '2020_dep.csv'))

# (2021-01-20) SKD - this is where we stop with the DEP datafile and now ALS data needs to be entered from months 04-06

# format times

dat2$datetimestamp<-as.POSIXct(strptime(dat2$date_sampled, 
                                         "%d-%b-%Y %H:%M", tz='EST'))
dat2$analyzetime<-as.POSIXct(strptime(dat2$date_analyzed, 
                                     "%d-%b-%Y %H:%M", tz='EST'))


# hold time tables --------------------------------------------------------

# create dataframe for hold times

# ----01 create new dataframe to work with----
# hold time = date analyzed
ht_dat <- dat2 %>% 
  dplyr::select(station_code, date_sampled, cdmo_name, date_analyzed)

# ----02 Tier 1 parameters----

# hold times for Tier 1 Parameters, ultimately exporting wide table
tier1 <- c("NH4F",
           "NO2F",
           "NO23F",
           "PO4F",
           "CHLA_N",
           "UncCHLA_N",
           "PHEA")

ht_dat %>%
  dplyr::filter(cdmo_name %in% tier1) %>%
  tidyr::pivot_wider(id_cols = c('station_code', 'date_sampled'), 
                     names_from = cdmo_name,
                     values_from = date_analyzed) %>%
  write.csv(here::here('output', '2020', '2020_holdtimes_tier1.csv'))

# cleanup and remove tier1 names
rm(tier1)

# ----03 Tier 2 parameters----
tier2 <- c("DOC",
           "TP",
           "TKN",
           "TKN_F",
           "TSS",
           "FECCOL_CFU",
           "ECOLI_MPN",
           "SUCRA",
           "ACETA")
ht_dat %>%
  dplyr::filter(cdmo_name %in% tier2) %>%
  tidyr::pivot_wider(id_cols = c('station_code', 'date_sampled'), 
                     names_from = cdmo_name,
                     values_from = date_analyzed) %>%
  write.csv(here::here('output', '2020', '2020_holdtimes_tier2.csv'))

# cleanup and remove tier2 names and hold time dataframe
rm(tier2, ht_dat)

# MDL tables --------------------------------------------------------------


# ----01 create new dataframe for mdl tables----
mdl_dat <- dat2 %>% 
  dplyr::select(station_code, date_sampled, cdmo_name, mdl, units)

base_mdl <- readr::read_csv(here::here('data', 'baseline_mdls_2020.csv')) %>%
  janitor::clean_names()


# ----02.1 create mdl table of plant pigments----
plantpigs <- c("CHLA_N", "UncCHLA_N", "PHEA")

mdl_dat %>%
  dplyr::filter(cdmo_name %in% plantpigs) %>%
  write.csv(here::here('output', '2020', '2020_plantpigmentsMDL_all.csv'))

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
  filter(cdmo_name == "PHEA" & mdl != 0.6) # 2020 PHEA changed from 0.4 to 0.6

# bind rows together into one dataframe
mdl_plantpigs <- bind_rows(mdl_CHLA, mdl_UnCHLA, mdl_PHEA)

# export as table
write.csv(mdl_plantpigs, 
          here::here('output', '2020', '2020_plantpigmentsMDL_diff.csv'))

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
               "DOC")

mdl_dat %>%
  dplyr::filter(cdmo_name %in% nutrients) %>%
  write.csv(here::here('output', '2020', '2020_nutrientsMDL_all.csv'))

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
mdl_doc <- mdl_dat %>%
  filter(cdmo_name == "DOC" & mdl != 0.5)

# bind rows together into one dataframe
mdl_nutsall <- bind_rows(mdl_nh4, mdl_tkn, mdl_tknf, mdl_no2,
                         mdl_no3, mdl_no23, mdl_po4,
                         mdl_tp, mdl_tss, mdl_fec,
                         mdl_doc)

write.csv(mdl_nutsall, here::here('output', '2020', '2020_nutrientsMDL_diff.csv'))

rm(mdl_nh4, mdl_tkn, mdl_tknf, mdl_no2,
   mdl_no3, mdl_no23, mdl_po4,
   mdl_tp, mdl_tss, mdl_fec,
   mdl_doc,
   mdl_nutsall, 
   base_mdl, mdl_dat)


# cdmo file ---------------------------------------------------------------

# just nutrient analysis data
# make data wide to fit CDMO format
dat_nut <- dat2 %>%
  dplyr::select(station_code, datetimestamp, cdmo_name, result) %>%
  dplyr::group_by(station_code, datetimestamp) %>%
  dplyr::distinct() %>% # remove duplicates
  tidyr::pivot_wider(id_cols = c('station_code', 'datetimestamp'),
                     names_from = cdmo_name,
                     values_from = result)

# FDEP lab QAQC codes
# add in F_cdmo_name column
# remove cdmo_name column
# make data wide to fit CDMO format
dat_rem <- dat2 %>%
  dplyr::select(station_code, datetimestamp, cdmo_name, remark) %>%
  dplyr::mutate(F_cdmo_name = paste("F", cdmo_name, sep="_")) %>%
  dplyr::select(-cdmo_name) %>%
  tidyr::pivot_wider(id_cols = c('station_code', 'datetimestamp'),
                     names_from = F_cdmo_name,
                     values_from = remark)

# pull out cdmo information of station code, monitoring program, and replicate
cdmo_dat <- dplyr::left_join(dat_nut, dat_rem, by = c("station_code", "datetimestamp")) %>%
  tidyr::separate(station_code,
                  into = c("station_code", "num"),
                  sep = "(?<=[A-Za-z])(?=[0-9])")%>%
  tidyr::separate(num,
                  into = c("monitoringprogram", "replicate"),
                  sep = "[.]")

glimpse(data.frame(cdmo_dat))

# remove other dataframes from environment
rm(dat_nut, dat_rem)

# ----03 calculate total n, din, ton, don/reorder dataframe format----
# add in blank NA record columns for each
# select parameters to keep
# this is also a way to reorder the data to CDMO format

cdmo_dat2 <- cdmo_dat %>%
  dplyr::mutate(TN = TKN + NO23F,
                DIN = NH4F + NO23F,
                TON = TKN + NH4F,
                DON = TKN_F - NH4F,
                F_TN = NA,
                F_DIN = NA,
                F_TON = NA,
                F_DON = NA,
                F_Record = NA) %>%
  dplyr::select(station_code, datetimestamp, 
                monitoringprogram, replicate, F_Record,
                PO4F, F_PO4F,
                TP, F_TP,
                NH4F, F_NH4F,
                NO2F, F_NO2F,
                NO3F, F_NO3F,
                NO23F, F_NO23F,
                DIN, F_DIN,
                TN, F_TN,
                TKN, F_TKN,
                TON, F_TON,
                CHLA_N, F_CHLA_N,
                UncCHLA_N, F_UncCHLA_N,
                PHEA, F_PHEA,
                TSS, F_TSS,
                FECCOL_CFU, F_FECCOL_CFU,
                ENTERO, F_ENTERO,
                DOC, F_DOC,
                TKN_F, F_TKN_F,
                DON, F_DON)

# ----04 export file as cdmo format----
# NOTE: this file is used to run with the NERRS QAQC Macro and therefore is easier without the NAs. So, the output file will have all of the NAs replaced with blanks.
# replace all NAs with blanks
# this is a new dataframe because it will make everything factors
# this is JUST to export the data into a csv without NAs
cdmo_dat3 <- sapply(cdmo_dat2, as.character)
cdmo_dat3[is.na(cdmo_dat3)] <- " "
cdmo_dat3<-as.data.frame(cdmo_dat3)
cdmo_dat3 <- cdmo_dat3 %>% 
  arrange(datetimestamp)
write.csv(cdmo_dat3, here::here('output', '2020', '2020_cdmo_format_dep-data.csv'))

rm(cdmo_dat, cdmo_dat2, cdmo_dat3)
