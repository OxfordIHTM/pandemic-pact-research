# Targets for rendering reports ------------------------------------------------

report_targets <- tar_plan(
  ## Render EDA report ----
  tar_quarto(
    name = eda_report,
    path = "reports/pandemic_pact_eda.qmd"
  ),
  ## Render data checks report ----
  tar_quarto(
    name = data_checks_report,
    path = "reports/pandemic_pact_data_checks.qmd"
  )
)