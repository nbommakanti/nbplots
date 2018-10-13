#' Visual Fields Heatmap
#'
#' @param .data
#' @param mapping
#' @param title
#' @param subtitle
#' @param fill_limits
#' @param low_color
#' @param high_color
#' @param legend_position
#' @param decimals
#'
#' @return
#' @import ggplot2
#' @export
#'
#' @examples
vf_heatmap <- function (.data, mapping,
                        title = NULL, subtitle = NULL,
                        fill_limits = NULL,
                        low_color = "black", high_color = "white",
                        legend_position = "none",
                        decimals = 2) {

    labels <- round(.data[[mapping]], decimals)

    p <- ggplot(.data, aes_string(x = "x", y = "y", fill = mapping))
    p <- p + geom_tile(size = .8, width = 5.6, height = 5.6)
    p <- p + geom_text(aes(label = labels), color = "white")
    p <- p + scale_fill_gradient(limits = fill_limits, low = low_color, high = high_color)
    p <- p + scale_x_continuous(breaks = seq(from = -27, to = 21, by = 6))
    p <- p + scale_y_continuous(breaks = seq(from = -21, to = 21, by = 6))
    p <- p + labs(title = title, x = "", y = "", fill = "")
    p <- p + theme(panel.border = element_blank(), legend.position = legend_position)
    p <- p + coord_fixed()

}
