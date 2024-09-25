#'
#' Plot research subcategories
#' 

plot_subcategory <- function(pact_subcategory_table,
                             category,
                             outcome = c("frequency", "money")) {
  ## Get outcome ----
  outcome <- match.arg(outcome)

  pact_table <- pact_subcategory_table |>
    #dplyr::filter(ResearchCat == category) |>
    dplyr::filter(!is.na(ResearchCat)) |>
    dplyr::filter(!is.na(ResearchSubcat))

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
        y = tidytext::reorder_within(
          stringr::str_wrap(ResearchSubcat, 35), by = n_grants,
          within = ResearchCat
        ), 
        fill = grant_type
      )
    ) +
      ggplot2::geom_col(alpha = 0.7, position = ggplot2::position_dodge()) +
      ggplot2::scale_fill_manual(
        name = NULL,
        values = oxthema::get_oxford_colours(c("sky", "cerulean"))
      ) +
      ggplot2::scale_x_continuous(
        labels = scales::label_number(scale = 1e-3)
      ) +
      tidytext::scale_y_reordered() +
      ggplot2::labs(
        x = "Number of Grants (in thousands)", y = "Research Subcategory"
      ) +
      ggplot2::facet_wrap(. ~ ResearchCat, nrow = 12, scales = "free") +
      ggplot2::theme_bw() +
      ggplot2::theme(
        legend.position = "top",
        strip.background = ggplot2::element_rect(
          fill = oxthema::get_oxford_colour("Oxford blue"), 
          colour = oxthema::get_oxford_colour("Oxford blue") 
        ),
        strip.text = ggplot2::element_text(colour = "#FFFFFF", size = 9),
        panel.border = ggplot2::element_blank(),
        panel.grid.major.y = ggplot2::element_blank(),
        axis.text.y = ggplot2::element_text(size = 9)
      )
  } else {
    ggplot2::ggplot(
      data = pact_table,
      mapping = ggplot2::aes(
        x = grant_amount_total, 
        y = tidytext::reorder_within(
          stringr::str_wrap(ResearchSubcat, 35), by = grant_amount_total,
          within = ResearchCat
        )
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
      tidytext::scale_y_reordered() +
      ggplot2::labs(
        x = "Financial Commitments (in USD 100 millions)", 
        y = "Research Subcategory"
      ) +
      ggplot2::facet_wrap(. ~ ResearchCat, nrow = 12, scales = "free") +
      ggplot2::theme_bw() +
      ggplot2::theme(
        strip.background = ggplot2::element_rect(
          fill = oxthema::get_oxford_colour("Oxford blue"), 
          colour = oxthema::get_oxford_colour("Oxford blue") 
        ),
        strip.text = ggplot2::element_text(colour = "#FFFFFF", size = 9),
        panel.border = ggplot2::element_blank(),
        panel.grid.major.y = ggplot2::element_blank(),
        axis.text.y = ggplot2::element_text(size = 9)
      )
  }
}