################################################################################
#
# Overall workflow
#
################################################################################

## Load libraries and custom functions ----
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)


## Build options ----
pact_client <- pact_client_set()


## Create targets and list targets objects ----

### Data ingest and processing targets - Figsahre ----
source("_targets_data_figshare.R")

### Data ingest and processing targets - website ----
source("_targets_data_website.R")

### Visualisation targets ----
source("_targets_visualisation.R")


### Analysis targets
analysis_targets <- tar_plan(
  
)


### Output targets
output_targets <- tar_plan(
  
)


### Reporting targets
source("_targets_report.R")


### Deploy targets
deploy_targets <- tar_plan(
  
)


## List targets
all_targets()
