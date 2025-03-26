library(psrccensus)
library(magrittr)

NAS_dir <- "//ReadyNAS-RN4220/FederalData/Census/acs/data_profiles/"

# Helper function

get_dp_multigeo <- function(acs.type){
  table_ids <- paste0("DP0", c(2:4))
  geographies <- c("state", "msa", "county", "place", "tract")
  dp_years <- 2005:(lubridate::year(Sys.Date()) - 2) # ~ 2 year lag for publication
  if(acs.type=="acs5"){
    dp_years %<>% setdiff(c(2005:2008)) # 2005-09 is first 5yr
  }else if(acs.type=="acs1"){
    dp_years %<>% setdiff(2020) # Pandemic year not available
    geographies %<>% setdiff("tract") # Too detailed
  }
  rs <- list()
  rs <- lapply(geographies, get_acs_recs, table.names=table_ids, years= dp_years, acs.type=acs.type)
  rs %<>% data.table::rbindlist(fill=TRUE, use.names=TRUE)
}

dp_1yr <- get_dp_multigeo("acs1") %>% saveRDS(file=paste0(NAS_dir, "DP_acs1.rds"))
dp_5yr <- get_dp_multigeo("acs5") %>% saveRDS(file=paste0(NAS_dir, "DP_acs5.rds"))
