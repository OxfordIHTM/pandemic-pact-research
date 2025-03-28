################################################################################
#
# Data ingest and processing workflow - website data
#
################################################################################

## Website data targets ----

data_website_targets <- tar_plan(
  ### Download Pandemic PACT data from website ----
  tar_target(
    name = pact_data_download,
    command = pact_download_website(
      path = "data-raw", overwrite = FALSE, quiet = TRUE
    ),
    format = "file"
  ),
  ### Archive downloaded dataset ----
  tar_target(
    name = pact_data_archive,
    command = archive_website_data(path_from = pact_data_download),
    format = "file"
  ),
  ### Read Pandemic PACT data from download ----
  tar_target(
    name = pact_data,
    command = read.csv(file = pact_data_download)
  )
)

## Website data processing targets ----

process_website_targets <- tar_plan(
  ### Process website data ----
  tar_target(
    name = pact_data_list_cols,
    command = pact_process_website(pact_data)
  ),
  ### Tabulate disease ----
  tar_target(
    name = pact_disease_year_table,
    command = pact_table_topic_group(
      pact_data_list_cols, topic = "Disease", group = "GrantStartYear"
    )
  ),
  tar_target(
    name = pact_disease_table,
    command = pact_table_disease(pact_data_list_cols)
  ),
  ### Tabulate research categories ----
  tar_target(
    name = pact_category_table,
    command = pact_table_category(
      pact_data_list_cols, topic = "ResearchCat"
    )
  ),
  tar_target(
    name = pact_subcategory_table,
    command = pact_table_category(
      pact_data_list_cols, topic = "ResearchSubcat",
      na_values = "No subcategory"
    )
  ),
  tar_target(
    name = pact_region_funder_table,
    command = pact_table_location_funder(
      pact_data_list_cols, topic = "FunderRegion"
    )
  ),
  tar_target(
    name = pact_country_funder_table,
    command = pact_table_location_funder(
      pact_data_list_cols, topic = "FunderCountry"
    )
  ),
  tar_target(
    name = pact_region_institution_table,
    command = pact_table_location_institution(
      pact_data_list_cols, topic = "ResearchInstitutionRegion"
    )
  ),
  tar_target(
    name = pact_country_institution_table,
    command = pact_table_location_institution(
      pact_data_list_cols, topic = "ResearchInstitutionCountry"
    )
  ),
  tar_target(
    name = pact_region_research_table,
    command = pact_table_location_research(
      pact_data_list_cols, topic = "ResearchLocationRegion"
    )
  ),
  tar_target(
    name = pact_country_research_table,
    command = pact_table_location_research(
      pact_data_list_cols, topic = "ResearchLocationCountry"
    )
  )
)