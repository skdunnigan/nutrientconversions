# !!this code produces output files!!
# this code converts the GTMNERR in-house running nutrient data file into CDMO-ready data formats, hold times and mdl tables for metadata documentation

# ----01 create cdmo-format file----
source('R/cdmo_qaqc/02.1_cdmofile.R')
# creates one output file as .csv

# ----02 create hold time tables----
source('R/cdmo_qaqc/02.2_holdtimetables.R')
# creates two output files as .csv

# ----03 create mdl tables----
source('R/cdmo_qaqc/02.3_mdltables.R')
# creates four output files as .csv
# two are all the CDMO-required parameters and two are only when those required parameters had MDLs that changed from their base.
