# --------------------------------------------------
# load libraries and data files
source('R/00_loadpackages.R')

# --------------------------------------------------
# load GTMNERR SWMP nutrient dataset
# load file with CDMO SWMP names
# load GTMNERR SWMP field data
# --------------------------------------------------
dat <- readxl::read_xlsx(here::here('data', '2019_Nutrients_10.1.xlsx'), 
                 sheet = "Chemistry") %>% 
  janitor::clean_names()

names <- readr::read_csv(here::here('data', 'componentnames.csv')) %>%
  janitor::clean_names()

env <- readxl::read_xlsx(here::here('data', '2019_Nutrients_10.1.xlsx'), 
                         sheet = "Enviro") %>% 
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
  dplyr::select(-component_short) %>%
  dplyr::mutate(station_code = tolower(station_code),
                station_code = gsub(" ","", station_code),
                site = tolower(site),
                component_long = tolower(component_long)) %>%
  dplyr::left_join(names, by = "component_long") %>%
  dplyr::mutate(cdmo_name = forcats::as_factor(cdmo_name))

env2 <- env %>%
  dplyr::mutate(station_code = tolower(station_code),
                station_code = gsub(" ","", station_code),
                site = tolower(site),
                component_long = tolower(component_long),
                cdmo_name = component_short)

rm(names)