# --------------------------------------------------
# load libraries and data files
source('R/00_loadpackages.R')

# --------------------------------------------------
# load data file
# --------------------------------------------------
dat <- read_xlsx("data/LIMS.xlsx", sheet = "BrowseReportPage") %>% janitor::clean_names()

# trim out unnecessary columns
dat2 <- select(dat, -X__1, -X__2, -X__3, 
               -X__4, -X__5, -X__6, 
               -'STORET STATION')

# --------------------------------------------------
# Create datetimestamp in POSIXct format
# --------------------------------------------------
dat2$datetimestamp<-as.POSIXct(strptime(dat2$date_sampled, 
                                        "%d-%b-%Y %H:%M", tz='EST'))
dat2$receivetime<-as.POSIXct(strptime(dat2$date_received, 
                                      "%d-%b-%Y %H:%M", tz='EST'))
dat2$analyzetime<-as.POSIXct(strptime(dat2$date_analyzed, 
                                      "%d-%b-%Y %H:%M", tz='EST'))

# remove spaces from field names
dat2$field.id <- gsub(" ","",dat2$field.id)

# --------------------------------------------------
# convert file into one wide format
# IMPORTANT DISCLAIMER:
### if data was entered incorrectly into the LIMS spreadsheet, there will be errors.
# --------------------------------------------------
source('R/00_datawrangling.R')
# if error, open up original script and run each chunk of code.
# you will likely need to edit code on line 122 to match the number of variables in the big_dat1 data frame.

# --------------------------------------------------
# convert wide format data into CDMO Format
# --------------------------------------------------
source('R/00_convertCDMOformat.R')

