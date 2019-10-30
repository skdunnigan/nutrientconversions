# --------------------------------------------------
# load libraries 
source('R/00_loadpackages.R')

# --------------------------------------------------
# load data file AS CSV <---
# need to change name of datafile in code
# --------------------------------------------------
dat <- read.csv(here::here('data', '16-19_nutrients_pellicercreek_tschaefer.csv'), 
                stringsAsFactors = FALSE ) %>% 
  janitor::clean_names()

# --------------------------------------------------
# Create datetimestamp in POSIXct format
# --------------------------------------------------
dat$datetimestamp<-as.POSIXct(strptime(dat$date_sampled, 
                                        "%d-%b-%Y %H:%M", tz='EST'))
dat$receivetime<-as.POSIXct(strptime(dat$date_received, 
                                      "%d-%b-%Y %H:%M", tz='EST'))
dat$analyzetime<-as.POSIXct(strptime(dat$date_analyzed, 
                                      "%d-%b-%Y %H:%M", tz='EST'))

# --------------------------------------------------
# force names to lowercase 
# remove spaces from field names
# separate units from environmental data columns
# remove old dates from LIMS file
# --------------------------------------------------
dat2 <- dat %>%
  dplyr::mutate(field_id = tolower(field_id),
                field_id = gsub(" ","", field_id),
                site_location = tolower(site_location)) %>%
  tidyr::separate(temperature,
                  into = c("temperature", "tempunits"),
                  sep = "(\\s+)") %>%
  tidyr::separate(specific_conductance,
                  into = c("specificconductance", "spcunits"),
                  sep = "(\\s+)") %>%
  tidyr::separate(dissolved_o2,
                  into = c("dissolvedoxygen", "o2units"),
                  sep = "(\\s+)") %>%
  dplyr::select(-date_sampled, -date_received, -date_analyzed, -spcunits, -tempunits, -o2units)

# --------------------------------------------------
# export as CSV file
#### rename file whatever it needs to be named
# --------------------------------------------------
write.csv(dat2, here::here('output', 'reformattedfor_tschaefer.csv'))