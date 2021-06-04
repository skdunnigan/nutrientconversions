
# load packages and read in file ------------------------------------------

library(tidyverse)
library(here)
library(readxl)

dat <- readxl::read_xlsx(here::here('data', '2020_dep_als.xlsx'))


# pivot_wider -------------------------------------------------------------

dat %>%
  select(station_code, date_sampled, cdmo_name, result) %>% 
  # mutate(row = row_number()) %>% # "try adding row name as unique identifier" - DOESN'T WORK
  group_by(station_code, date_sampled) %>% 
  tidyr::pivot_wider(names_from = cdmo_name,
                     values_from = result)
