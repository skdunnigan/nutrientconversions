# must run CDMO script first for appropriate .csv file
# if you need file uncomment line below and comment lines 6-7
# source('01_Load_Wrangle_Run_CDMOFile.R')
# --------------------------------------------------
# load libraries and data files
source('R/00_loadpackages.R')
# --------------------------------------------------

### --> final dataframe of above source code is called 'big_dat'

df <- read.csv('output/data/CDMOFormat_all.csv', na.strings = c("No Result"))

# some formatting adjustments
names(df)<-make.names(names(df),unique = TRUE)
df$datetimestamp <- as.POSIXct(df$datetimestamp, tz = 'America/New_York')
df$fecal.coliforms.membrane.filter1 <- as.numeric(df$fecal.coliforms.membrane.filter1)
df$chlorophyll.a..corrected1 <- as.numeric(df$chlorophyll.a..corrected1)
df$phaeophytin.a1 <- as.numeric(df$phaeophytin.a1)

# separate month and year
    df$year <- year(df$datetimestamp)
    df$month <- month(df$datetimestamp)
    df$day <- day(df$datetimestamp)
    df$date <- ymd(paste(df$year, df$month, df$day, sep="-"))
     
# -----------------------------------------------
# create summary table
# -----------------------------------------------
summary.table <- df %>%
  group_by(stationcode, monitoringprogram, date) %>%
  summarise(CHLA = mean(chlorophyll.a..corrected1, na.rm = TRUE), 
            CHLA_sd = sd(chlorophyll.a..corrected1),
            Fecal = mean(fecal.coliforms.membrane.filter1, na.rm = TRUE), 
            Fecal_sd = sd(fecal.coliforms.membrane.filter1),
            TN = mean(kjeldahl.nitrogen1 + no2no3.n1, na.rm = TRUE),
            TN_sd = sd(kjeldahl.nitrogen1 + no2no3.n1, na.rm = TRUE),
            TP = mean(total.p1, na.rm=TRUE),
            TP_sd = sd(total.p1, na.rm = TRUE))

summary.table$CHLA <- round(summary.table$CHLA, digits=2)
summary.table$Fecal <- round(summary.table$Fecal, digits=1)
summary.table$TN <- round(summary.table$TN, digits=3)
summary.table$TP <- round(summary.table$TP, digits=3)
summary.table$date <- as.POSIXct(summary.table$date, tz = 'America/New_York')
# export as .csv
write.csv(summary.table, "output/data/summaries.csv")

# # -----------------------------------------------
# # separate out stations into their own df
# # -----------------------------------------------
pi_dat <- df %>%
  filter(stationcode == 'gtmpinut')
ss_dat <- df %>%
  filter(stationcode == 'gtmssnut')
fm_dat <- df %>%
  filter(stationcode == 'gtmfmnut')
pc_dat <- df %>%
  filter(stationcode == 'gtmpcnut', monitoringprogram == '1')
pcISCO_dat <- df %>%
  filter(stationcode == 'gtmpcnut', monitoringprogram == '2')

# and from the summary tables, which are the averaged values
pi_df <- summary.table %>% 
  filter(stationcode == 'gtmpinut')
ss_df <- summary.table %>% 
  filter(stationcode == 'gtmssnut')
fm_df <- summary.table %>% 
  filter(stationcode == 'gtmfmnut')
pc_df <- summary.table %>% 
  filter(stationcode == 'gtmpcnut', monitoringprogram=="1")
pcISCO_df <- summary.table %>%
  filter(stationcode == "gtmpcnut", monitoringprogram=="2")
