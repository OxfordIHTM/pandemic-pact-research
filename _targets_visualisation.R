################################################################################
#
# Data visualisation workflow
#
################################################################################

visualisation_targets <- tar_plan(
  ## Disease over time ----
  tar_target(
    name = disease_year_grant_number_plot,
    command = plot_disease_year(pact_disease_year_table)
  ),
  tar_target(
    name = disease_year_grant_amount_plot,
    command = plot_disease_year(pact_disease_year_table, outcome = "money")
  ),
  tar_target(
    name = disease_grant_number_plot,
    command = plot_disease(pact_disease_table)
  ),
  tar_target(
    name = disease_grant_amount_plot,
    command = plot_disease(pact_disease_table, outcome = "money")
  ),
  tar_target(
    name = category_grant_number_plot,
    command = plot_category(pact_category_table)
  ),
  tar_target(
    name = category_grant_amount_plot,
    command = plot_category(pact_category_table, outcome = "money")
  )
)