# Before running this script, you need to run
# source('R/00_datawrangling.R')

# ---------------------------------------------------
# matching format of current files
# ---------------------------------------------------
# remove spaces from column names
names(big_dat)<-make.names(names(big_dat),unique = TRUE)
big_dat$kjeldahl.nitrogen1 <- as.numeric(big_dat$kjeldahl.nitrogen1)
big_dat$ammonia.n1 <- as.numeric(big_dat$ammonia.n1)
big_dat$no2no3.n1 <- as.numeric(big_dat$no2no3.n1)
big_dat$kjeldahl.nitrogen.filtered1 <- as.numeric(big_dat$kjeldahl.nitrogen.filtered1)

# calculate total n, din, ton
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

# select parameters to keep
cdmo_dat <- big_dat %>%
  select(stationcode, datetimestamp, monitoringprogram, replicate, F_Record,
         o.phosphate.p1, F_o.phosphate.p1,
         total.p1, F_total.p1,
         ammonia.n1, F_ammonia.n1,
         nitrite.n1, F_nitrite.n1,
         nitrate.n1, F_nitrate.n1,
         no2no3.n1, F_no2no3.n1,
         din, F_din,
         tn, F_tn,
         kjeldahl.nitrogen1, F_kjeldahl.nitrogen1,
         ton, F_ton, 
         chlorophyll.a..corrected1, F_chlorophyll.a..corrected1,
         chlorophyll.a..corrected2, F_chlorophyll.a..corrected2,
         chlorophyll.a..uncorrected1, F_chlorophyll.a..uncorrected1, 
         chlorophyll.a..uncorrected2, F_chlorophyll.a..uncorrected2,
         phaeophytin.a1, F_phaeophytin.a1,
         phaeophytin.a2, F_phaeophytin.a2,
         tss1, F_tss1,
         fecal.coliforms.membrane.filter1, F_fecal.coliforms.membrane.filter1,
         escherichia.coli.quanti.tray1, F_escherichia.coli.quanti.tray1,
         temperature, F_wtemp_n,
         specificconductance, F_spcond_n,
         dissolvedoxygen, F_do_n,
         ph, F_ph,
         secchi, F_secchi,
         organic.carbon1, F_organic.carbon1,
         kjeldahl.nitrogen.filtered1, F_kjeldahl.nitrogen.filtered1,
         don, F_don)

# rename columns
colnames(cdmo_dat)[6] <- "PO4F"
colnames(cdmo_dat)[7] <- "F_PO4F"
colnames(cdmo_dat)[8] <- "TP"
colnames(cdmo_dat)[9] <- "F_TP"
colnames(cdmo_dat)[10] <- "NH4F"
colnames(cdmo_dat)[11] <- "F_NH4F"
colnames(cdmo_dat)[12] <- "NO2F"
colnames(cdmo_dat)[13] <- "F_NO2F"
colnames(cdmo_dat)[14] <- "NO3F"
colnames(cdmo_dat)[15] <- "F_NO3F"
colnames(cdmo_dat)[16] <- "NO23F"
colnames(cdmo_dat)[17] <- "F_NO23F"
colnames(cdmo_dat)[18] <- "DIN"
colnames(cdmo_dat)[19] <- "F_DIN"
colnames(cdmo_dat)[20] <- "TN"
colnames(cdmo_dat)[21] <- "F_TN"
colnames(cdmo_dat)[22] <- "TKN"
colnames(cdmo_dat)[23] <- "F_TKN"
colnames(cdmo_dat)[24] <- "TON"
colnames(cdmo_dat)[25] <- "FTON"
colnames(cdmo_dat)[26] <- "CHLA_N1"
colnames(cdmo_dat)[27] <- "F_CHLAN1"
colnames(cdmo_dat)[28] <- "2CHLA"
colnames(cdmo_dat)[29] <- "F_2CHLA"
colnames(cdmo_dat)[30] <- "UncCHLa_N1"
colnames(cdmo_dat)[31] <- "F_UncCHLa_N1"
colnames(cdmo_dat)[32] <- "2UncCHLa"
colnames(cdmo_dat)[33] <- "F_2UncCHLa"
colnames(cdmo_dat)[34] <- "PHEA1"
colnames(cdmo_dat)[35] <- "F_PHEA1"
colnames(cdmo_dat)[36] <- "2PHEA"
colnames(cdmo_dat)[37] <- "F_2PHEA"
colnames(cdmo_dat)[38] <- "TSS"
colnames(cdmo_dat)[39] <- "F_TSS"
colnames(cdmo_dat)[40] <- "FECCOL_CFU"
colnames(cdmo_dat)[41] <- "F_FECCOL_CFU"
colnames(cdmo_dat)[42] <- "ECOLI_MPN"
colnames(cdmo_dat)[43] <- "F_ECOLI_MPN"
colnames(cdmo_dat)[44] <- "WTEM_N"
colnames(cdmo_dat)[45] <- "FWTEM_N"
colnames(cdmo_dat)[46] <- "SPC"
colnames(cdmo_dat)[47] <- "F_SPC"
colnames(cdmo_dat)[48] <- "DO_N"
colnames(cdmo_dat)[49] <- "F_DO_N"
colnames(cdmo_dat)[50] <- "PH"
colnames(cdmo_dat)[51] <- "F_PH"
colnames(cdmo_dat)[52] <- "SECCHI"
colnames(cdmo_dat)[53] <- "F_SECCHI"
colnames(cdmo_dat)[54] <- "DOC"
colnames(cdmo_dat)[55] <- "F_DOC"
colnames(cdmo_dat)[56] <- "TKN_F"
colnames(cdmo_dat)[57] <- "F_TKN_F"
colnames(cdmo_dat)[58] <- "DON"
colnames(cdmo_dat)[59] <- "F_DON"

# replace all NAs with blanks
# this is a new dataframe because it will make everything factors
# this is JUST to export the data into a csv without NAs
cdmo_dat2 <- sapply(cdmo_dat, as.character)
cdmo_dat2[is.na(cdmo_dat2)] <- " "
cdmo_dat2<-as.data.frame(cdmo_dat2)

# export as CSV
write.csv(cdmo_dat2, "output/data/CDMOFormat_correct.csv")