# --------------------------------------------------
# load libraries and data files
source('R/00_loadpackages.R')

# --------------------------------------------------
# load GTMNERR SWMP field data
# --------------------------------------------------

# field data has a separate tab for each month, but all the same columns

# initialize readin listing
mysheets_fromexcel <- list()

# get the list of all the sheet names
mysheetlist <- readxl::excel_sheets(path = here::here('data', 
                                              '2020_FIELDDATA_v3.xlsx'))

# create loop for the sheets
i=1

for (i in 1:length(mysheetlist)){
  
  tempdf <- readxl::read_excel(path = here::here('data', 
                                         '2020_FIELDDATA_v3.xlsx'), 
                               sheet = mysheetlist[i])
  
  tempdf$sheetname <- mysheetlist[i]
  
  mysheets_fromexcel[[i]] <- tempdf 
}

mysheets_fromexcel


# merge all the lists into one tibble using dplyr::bind_rows()
dat <- purrr::reduce(mysheets_fromexcel, dplyr::bind_rows) %>% 
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
  dplyr::mutate(date = lubridate::ymd(paste0(yyyy, "-", mm_4, "-", dd)),
                time = paste0(hh, ":", mm_7),
                datetime = paste0(date, " ", time),
                datetimestamp = lubridate::ymd_hm(datetime,
                                                  tz = Sys.timezone()),
                site = tolower(site),
                component_long = tolower(component_long),
                cdmo_name = forcats::as_factor(component_short),
                ) %>% 
  dplyr::select(-c(3:7), -date, -time, -datetime,
                -checked_on, -checked_by, -entered_on, -entered_by,
                -checked_by_2, -checked_on_2, -sheetname)

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

# ----04 export file as cdmo format----
# NOTE: this file is used to run with the NERRS QAQC Macro and therefore is easier without the NAs. So, the output file will have all of the NAs replaced with blanks.
# replace all NAs with blanks
# this is a new dataframe because it will make everything factors
# this is JUST to export the data into a csv without NAs
cdmo_dat2 <- sapply(cdmo_dat, as.character)
cdmo_dat2[is.na(cdmo_dat2)] <- " "
cdmo_dat2 <- as.data.frame(cdmo_dat2)
cdmo_dat2 <- cdmo_dat2 %>% 
  arrange(datetimestamp)
write.csv(cdmo_dat2, here::here('output', '2020', '2020_cdmo_format_field-data.csv'))

rm(cdmo_dat, cdmo_dat2)
