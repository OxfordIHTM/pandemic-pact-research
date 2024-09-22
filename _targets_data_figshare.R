################################################################################
#
# Data ingest and processing workflow - Figshare
#
################################################################################

## Figshare data targets ----

data_figshare_targets <- tar_plan(
  ### Set Figshare client ----
  # tar_target(
  #   name = pact_client,
  #   command = pact_client_set()
  # ),
  ### Read Pandemic PACT data from Figshare ----
  tar_target(
    name = pact_data_figshare,
    command = pact_read_figshare(pact_client)
  ),
  ### Read Pandemic PACT data dictionary from Figshare ----
  tar_target(
    name = pact_data_dictionary,
    command = pact_read_figshare_dictionary(pact_client)
  )
)

## Figshare data processing targets ----

process_figshare_targets <- tar_plan(
  ### Process Pandemic PACT Figshare data ----
  tar_target(
    name = pact_data_figshare_processed,
    command = pact_process_figshare(pact_data_figshare)
  )
)