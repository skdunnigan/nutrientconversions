# must run CDMO script first for appropriate .csv file

source('R/01_Load_Wrangle_Run_PlotsSummaryCDMO.R')

# create chlorophyll plots
source('R/00_chlathresholdgraphs.R')

# create total nitrogen plots
source('R/00_TNthresholdgraphs.R')

# create total phosphorus plots
source('R/00_TPthresholdgraphs.R')

# create fecal and ecoli plots
source('R/00_fecalgraphs.R')