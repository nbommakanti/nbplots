#' Theme Nik
#'
#' @return
#' @import ggplot2
#' @export
#'
#' @examples
theme_nik <- function () {
    theme_classic(base_family = "Roboto", base_size = 14) +
        theme(
            plot.title = element_text(size = 18, face = "bold"),
            plot.subtitle = element_text(size = 12),
            axis.line.y = element_blank(),
            axis.ticks.y = element_blank(),
            panel.grid.major.y = element_line(size = 0.1, linetype = 3)
        )
}


