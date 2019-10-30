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

