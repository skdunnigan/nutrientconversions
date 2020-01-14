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
  write.csv(here::here('output', 'data', 'HoldTimes', '2019_holdtimes_tier1.csv'))

# cleanup and remove tier1 names
rm(tier1)

# ----03 Tier 2 parameters----
tier2 <- c("DOC",
           "TP",
           "TKN",
           "TKN_F",
           "TSS",
           "FECCOL_CFU",
           "ECOLI_MPN")
ht_dat %>%
  dplyr::filter(cdmo_name %in% tier2) %>%
  tidyr::pivot_wider(id_cols = c('station_code', 'date_sampled'), 
                     names_from = cdmo_name,
                     values_from = date_analyzed) %>%
  write.csv(here::here('output', 'data', 'HoldTimes', '2019_holdtimes_tier2.csv'))

# cleanup and remove tier2 names and hold time dataframe
rm(tier2, ht_dat)