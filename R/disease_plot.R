#'
#' Disease bar plot
#' 
#' 

plot_disease <- function(pact_disease_table,
                         outcome = c("frequency", "money")) {
  ## Get outcome ----
  outcome <- match.arg(outcome)

  ## Re-label diseases and re-scale grant amounts ----
  pact_table <- pact_disease_table |>
    dplyr::mutate(
      Disease = factor(
        x = Disease, levels = disease_list$names, 
        labels = disease_list$short_names
      )
    )

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
        x = n_grants, y = reorder(Disease, n_grants), fill = grant_type
      )
    ) +
      ggplot2::geom_col(alpha = 0.7, position = ggplot2::position_dodge()) +
      ggplot2::scale_fill_manual(
        name = NULL,
        values = oxthema::get_oxford_colours(c("sky", "cerulean"))
      ) +
      ggplot2::scale_x_continuous(
        n.breaks = 12,
        labels = scales::label_number(scale = 1e-2)
      ) +
      ggplot2::labs(x = "Number of Grants (in hundreds)", y = "Disease") +
      oxthema::theme_oxford() +
      ggplot2::theme(
        legend.position = "top",
        panel.border = ggplot2::element_blank(),
        panel.grid.major.y = ggplot2::element_blank()
      )
  } else {
    ggplot2::ggplot(
      data = pact_table,
      mapping = ggplot2::aes(
        x = grant_amount_total, 
        y = reorder(Disease, grant_amount_total)
      )
    ) +
      ggplot2::geom_col(
        colour = oxthema::get_oxford_colour("lilac"),
        fill = oxthema::get_oxford_colour("lilac"),
        alpha = 0.7
      ) +
      ggplot2::scale_x_continuous(
        breaks = scales::breaks_pretty(),
        labels = scales::label_number(scale = 1e-8)
      ) +
      ggplot2::labs(
        x = "Financial Commitments (in USD 100 millions)", 
        y = "Disease"
      ) +
      oxthema::theme_oxford() +
      ggplot2::theme(
        panel.border = ggplot2::element_blank(),
        panel.grid.major.y = ggplot2::element_blank()
      )
  }
}