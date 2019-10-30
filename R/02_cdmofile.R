# to create the CDMO output data file

# ---------------------------------------------------
# split into multiple dataframes 
# ---------------------------------------------------
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

# ---------------------------------------------------
# merge both wide dataframes into one
# pull out cdmo information of 
## station code, monitoring program, and replicate
# ---------------------------------------------------
cdmo_dat <- dplyr::left_join(dat_nut, dat_rem, by = c("station_code", "date_sampled")) %>%
  tidyr::separate(station_code, 
           into = c("station_code", "num"), 
           sep = "(?<=[A-Za-z])(?=[0-9])")%>%
  tidyr::separate(num,
           into = c("monitoringprogram", "replicate"),
           sep = "[.]")

# remove other dataframes from environment
rm(dat_nut, dat_rem)

# ---------------------------------------------------
# calculate total n, din, ton
# ---------------------------------------------------
glimpse(cdmo_dat %>%
  dplyr::mutate(TN = TKN + NO23F,
                DIN = NH4F + NO23F,
                TON = TKN + NH4F)
)
big_dat$tn <- big_dat$kjeldahl.nitrogen1 + big_dat$no2no3.n1
big_dat$F_tn <- NA # blank column
big_dat$din <- big_dat$ammonia.n1 + big_dat$no2no3.n1
big_dat$F_din <- NA # blank column
big_dat$ton <- big_dat$kjeldahl.nitrogen1 - big_dat$ammonia.n1
big_dat$F_ton <- NA # blank column
big_dat$F_wtemp_n <- NA # blank column
big_dat$F_spcond_n <- NA # blank column
big_dat$F_do_n <- NA # blank column
big_dat$F_ph <- NA # blank column
big_dat$secchi <- NA # blank column
big_dat$F_secchi <- NA # blank column
big_dat$F_Record <- NA # blank column
big_dat$don <- big_dat$kjeldahl.nitrogen.filtered1 - big_dat$ammonia.n1
big_dat$F_don <- NA # blank column