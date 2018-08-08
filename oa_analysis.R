library(tidyverse)
library(roadoi)

# read in data, select only articles identified as having individual participant level data, and remove the four cases where there is no doi
d <- read_csv('data.csv') %>%
  filter(individualLevelData == 'Y',
         !AccessionNumber %in% c("WOS:000255215200004", "WOS:000274139600003", "WOS:000281821900008", "WOS:000329478800016"))

# send dois to unpaywell to check OA status
oa_out <- oadoi_fetch(dois = d$doi, 
                    email = "your_email")

# show summary of open access status
oa_out %>% count(is_oa)

# save open access results
saveRDS(oa_out, 'openAccessResults.rds')
