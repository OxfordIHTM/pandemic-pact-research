################################################################################
#
# Overall workflow
#
################################################################################

## Load libraries and custom functions ----
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)


## Create targets and list targets objects ----

### Data ingest and processing targets - Figsahre
source("_targets_data_figshare.R")

### Data ingest and processing targets - website
source("_targets_data_website.R")

### Processing targets
processing_targets <- tar_plan(
  
)


### Analysis targets
analysis_targets <- tar_plan(
  
)


### Output targets
output_targets <- tar_plan(
  
)


### Reporting targets
report_targets <- tar_plan(
  
)


### Deploy targets
deploy_targets <- tar_plan(
  
)


## List targets
all_targets()
