#'
#' Plot research categories and subcategories
#' 
#' 

plot_category <- function(pact_category_table,
                          outcome = c("frequency", "money")) {
  ## Get outcome ----
  outcome <- match.arg(outcome)

  pact_table <- pact_category_table |>
    dplyr::filter(ResearchCat != "NA")
  
  if (outcome == "frequency") {
    ggplot2::ggplot(
      data = pact_table |>
        tidyr::pivot_longer(
          cols = n_grants:n_grants_specified,
          names_to = "grant_type", values_to = "n_grants"
        ) |>
        dplyr::mutate(
          grant_type = factor(
            x = grant_type,
            levels = c("n_grants_specified", "n_grants"),
            labels = c(
              "Grants with known\nfinancial commitments",
              "Total number of grants"
            )
          )
        ),
      mapping = ggplot2::aes(
        x = n_grants, 
        y = reorder(stringr::str_wrap(ResearchCat, 35), n_grants), 
        fill = grant_type
      )
    ) +
      ggplot2::geom_col(alpha = 0.7, position = ggplot2::position_dodge()) +
      ggplot2::scale_fill_manual(
        name = NULL,
        values = oxthema::get_oxford_colours(c("sky", "cerulean"))
      ) +
      ggplot2::scale_x_continuous(
        n.breaks = 12,
        labels = scales::label_number(scale = 1e-3)
      ) +
      ggplot2::labs(
        x = "Number of Grants (in thousands)", y = "Research Category"
      ) +
      oxthema::theme_oxford() +
      ggplot2::theme(
        legend.position = "top",
        panel.border = ggplot2::element_blank(),
        panel.grid.major.y = ggplot2::element_blank(),
        axis.text.y = ggplot2::element_text(size = 9)
      )
  } else {
    ggplot2::ggplot(
      data = pact_table,
      mapping = ggplot2::aes(
        x = grant_amount_total, 
        y = reorder(stringr::str_wrap(ResearchCat, 35), grant_amount_total)
      )
    ) +
      ggplot2::geom_col(
        colour = oxthema::get_oxford_colour("plum"),
        fill = oxthema::get_oxford_colour("plum"),
        alpha = 0.7
      ) +
      ggplot2::scale_x_continuous(
        breaks = scales::breaks_pretty(),
        labels = scales::label_number(scale = 1e-8)
      ) +
      ggplot2::labs(
        x = "Financial Commitments (in USD 100 millions)", 
        y = "Research Category"
      ) +
      oxthema::theme_oxford() +
      ggplot2::theme(
        panel.border = ggplot2::element_blank(),
        panel.grid.major.y = ggplot2::element_blank(),
        axis.text.y = ggplot2::element_text(size = 9)
      )
  }
}