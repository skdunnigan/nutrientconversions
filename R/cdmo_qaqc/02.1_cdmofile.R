# to create the CDMO output data file

# ----01 split into multiple dataframes----
# just nutrient analysis data
# make data wide to fit CDMO format
dat_nut <- dat2 %>% 
  dplyr::select(station_code, date_sampled, cdmo_name, result) %>%
  tidyr::pivot_wider(id_cols = c('station_code', 'date_sampled'), 
                     names_from = cdmo_name,
                     values_from = result)

# FDEP lab QAQC codes
# add in F_cdmo_name column
# remove cdmo_name column
# make data wide to fit CDMO format
dat_rem <- dat2 %>% 
  dplyr::select(station_code, date_sampled, cdmo_name, remark) %>%
  dplyr::mutate(F_cdmo_name = paste("F", cdmo_name, sep="_")) %>%
  dplyr::select(-cdmo_name) %>%
  tidyr::pivot_wider(id_cols = c('station_code', 'date_sampled'), 
                     names_from = F_cdmo_name,
                     values_from = remark)

dat_env <- env2 %>%
  dplyr::select(station_code, date_sampled, cdmo_name, result) %>%
  tidyr::pivot_wider(id_cols = c('station_code', 'date_sampled'), 
                     names_from = cdmo_name,
                     values_from = result)

# ----02 merge both wide dataframes into one----
# pull out cdmo information of station code, monitoring program, and replicate
cdmo_dat <- dplyr::left_join(dat_nut, dat_rem, by = c("station_code", "date_sampled")) %>%
  tidyr::separate(station_code, 
           into = c("station_code", "num"), 
           sep = "(?<=[A-Za-z])(?=[0-9])")%>%
  tidyr::separate(num,
           into = c("monitoringprogram", "replicate"),
           sep = "[.]")

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
                F_Record = NA,
                datetimestamp = date_sampled) %>%
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
                CHLAF, F_CHLAF,
                UncCHLA_N, F_UncCHLA_N,
                PHEA, F_PHEA,
                TSS, F_TSS,
                FECCOL_CFU, F_FECCOL_CFU,
                ECOLI_MPN, F_ECOLI_MPN,
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
write.csv(cdmo_dat3, here::here('output', 'data', '2019_cdmo_format.csv'))

rm(cdmo_dat, cdmo_dat2, cdmo_dat3)