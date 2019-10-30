# this script will take the LIMS file and break it down
# into one datafile in long format with all parameters
# must run 
#source('R/01_Load_Wrangle_Run_CDMOFile.R')

# create reference method table
df <- dat2%>%
  group_by(component, reference.method)%>%
  summarise(count = n())
df
write.csv(df, "output/data/referencemethods.csv")