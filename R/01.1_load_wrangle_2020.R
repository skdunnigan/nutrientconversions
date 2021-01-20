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
                                    'GTM_NERR_01012020_12112020_LIMS.xlsx')) %>% 
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
  dplyr::select(-temperature,-specific_conductance,-dissolved_o2) %>% 
  dplyr::select(station_code, site, date_sampled, analysis, cdmo_name, component_long, result, remark, mdl,
                pql, units, test_comments, date_received, date_analyzed) %>% 
  dplyr::filter(station_code != "fieldblank") 

rm(names)

# export as a new file to add in the ALS lab data from months 04-06, resume with new file import on line 49
readr::write_excel_csv(dat2, here::here('output', 'data', '2020_dep.csv'))

# (2021-01-20) SKD - this is where we stop with the DEP datafile and now ALS data needs to be entered from months 04-06

# BEGIN WITH FULL 2020 YEAR DATA HERE ----

# # just nutrient analysis data
# # make data wide to fit CDMO format
# dat_nut <- dat2 %>%
#   dplyr::select(station_code, date_sampled, cdmo_name, result) %>% 
#   dplyr::group_by(station_code, date_sampled) %>% 
#   dplyr::distinct() %>% # remove duplicates
#   tidyr::pivot_wider(id_cols = c('station_code', 'date_sampled'), 
#                      names_from = cdmo_name,
#                      values_from = result)
# 
# # FDEP lab QAQC codes
# # add in F_cdmo_name column
# # remove cdmo_name column
# # make data wide to fit CDMO format
# dat_rem <- dat2 %>% 
#   dplyr::select(station_code, date_sampled, cdmo_name, remark) %>%
#   dplyr::mutate(F_cdmo_name = paste("F", cdmo_name, sep="_")) %>%
#   dplyr::select(-cdmo_name) %>%
#   tidyr::pivot_wider(id_cols = c('station_code', 'date_sampled'), 
#                      names_from = F_cdmo_name,
#                      values_from = remark)
# 
# # pull out cdmo information of station code, monitoring program, and replicate
# cdmo_dat <- dplyr::left_join(dat_nut, dat_rem, by = c("station_code", "date_sampled")) %>%
#   tidyr::separate(station_code, 
#                   into = c("station_code", "num"), 
#                   sep = "(?<=[A-Za-z])(?=[0-9])")%>%
#   tidyr::separate(num,
#                   into = c("monitoringprogram", "replicate"),
#                   sep = "[.]")
# 
# glimpse(data.frame(cdmo_dat))
# 
# cdmo_dat_new <- lapply(cdmo_dat, as.numeric)
