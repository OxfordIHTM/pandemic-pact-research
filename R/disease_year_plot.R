#'
#' Plot grants by disease per year
#' 
#' @param pact_disease_year_table
#' @param outcome
#' 
#' @returns
#' 

plot_disease_year <- function(pact_disease_year_table,
                              outcome = c("frequency", "money")) {
  ## Get outcome ----
  outcome <- match.arg(outcome)
  
  ## Re-label diseases and re-scale grant amounts ----
  pact_table <- pact_disease_year_table |>
    dplyr::mutate(
      Disease = factor(
        x = Disease, levels = disease_list$names, 
        labels = disease_list$short_names
      )
    )

  if (outcome == "frequency") {
    base_plot <- ggplot2::ggplot(
      data = pact_table,
      mapping = ggplot2::aes(x = GrantStartYear, y = n_grants, group = Disease)
    ) +
      ggplot2::geom_line(
        colour = oxthema::get_oxford_colour("sky"), linewidth = 1
      ) +
      ggplot2::scale_y_continuous(
        breaks = scales::breaks_pretty(),
        labels = scales::label_number()
      ) +
      ggplot2::labs(x = "Year of Award Start", y = "Number of Grants")
  } else {
    base_plot <- ggplot2::ggplot(
      data = pact_table,
      mapping = ggplot2::aes(
        x = GrantStartYear, y = grant_amount_total, group = Disease)
    ) +
      ggplot2::geom_line(
        colour = oxthema::get_oxford_colour("lilac"), linewidth = 1
      ) +
      ggplot2::scale_y_continuous(
        breaks = scales::breaks_pretty(),
        labels = scales::label_number(scale = 1e-6)
      ) +
      ggplot2::labs(
        x = "Year of Award Start", 
        y = "Known Financial Commitments (in USD millions)"
      )
  }

  base_plot +
    ggplot2::facet_wrap(. ~ Disease, nrow = 5, ncol = 4, scales = "free_y") +
    ggplot2::theme_bw() +
    ggplot2::theme(
      strip.background = ggplot2::element_rect(
        fill = oxthema::get_oxford_colour("Oxford blue"), 
        colour = oxthema::get_oxford_colour("Oxford blue") 
      ),
      strip.text = ggplot2::element_text(colour = "#FFFFFF", size = 9),
      panel.border = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      axis.text.x = ggplot2::element_text(angle = 90, vjust = 0.5, hjust = 1),
      axis.ticks = ggplot2::element_blank()
    ) 
}