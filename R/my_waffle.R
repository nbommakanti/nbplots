#' Simple wrapper around waffle()
#'
#'
#' @param .data
#' @param title
#' @param x_lab
#' @param colors
#' @param rows
#' @param size
#' @param legend_pos
#' @param font_family
#'
#' @return
#' @export
#' @import waffle
#'
#' @examples
my_waffle <- function(.data,
                      title = NULL,
                      x_lab = "(One Square Represents 10,000 Visual Fields)",
                      colors = c("#414649", "#69727a", "#afafaf"),
                      rows = 10,
                      size = 2,
                      legend_pos = "top",
                      font_family = "Arial") {
    waffle(.data,
           title = title,
           colors = colors,
           xlab = x_lab,
           rows = rows,
           size = size,
           legend_pos = legend_pos) +
        theme(text = element_text(family = font_family),
              plot.title = element_text(size = 18,
                                        face = "bold"),
              plot.subtitle = element_text(size = 12))
}
