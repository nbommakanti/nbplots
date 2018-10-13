#' Define function to create boxplot/histograms
#'
#' @param .data
#' @param mapping
#' @param binwidth
#' @param title
#' @param subtitle
#' @param x_label
#' @param y_label
#' @param x_limits
#' @param y_limits
#' @param fill
#' @param color
#' @param box_color
#' @param y_format
#' @param line_intercept
#'
#' @return
#' @import ggplot2
#' @import patchwork
#' @export
#'
#' @examples
box_hist <- function (.data, mapping,
                      binwidth = 1,
                      title = NULL, subtitle = NULL,
                      x_label = NULL, y_label = NULL,
                      x_limits = NULL, y_limits = NULL,
                      fill = "#69727a", color = "#414649", box_color = NULL,
                      y_format = NULL,
                      line_intercept = NULL)  {

    # Construct histogram
    p_hist <- ggplot(.data, aes_string(x = mapping))
    p_hist <- p_hist + geom_histogram(binwidth = binwidth,
                                      fill = fill,
                                      color = color)
    p_hist <- p_hist + labs(x = x_label, y = y_label)
    p_hist <- p_hist + theme(axis.ticks.y = element_blank())
    p_hist <- p_hist + coord_cartesian(xlim = x_limits, ylim = y_limits)
    if (is.null(y_format)) {
        # do nothing
    } else if (y_format == "k") {
        p_hist <- p_hist + scale_y_continuous(
            label = scales::unit_format(unit = "k", scale = 1e-3))
    } else if (y_format == "comma") {
        p_hist <- p_hist + scale_y_continuous(label = comma)
    }
    if (!is.null(line_intercept)) {
        p_hist <- p_hist + geom_vline(xintercept = line_intercept,
                                      linetype = 2, color = fill)
    }

    # Construct boxplot
    p_box <- ggplot(.data, aes_string(y = mapping))
    if (!is.null(box_color)) {
        p_box <- p_box + geom_boxplot(fill = fill,
                                      color = box_color,
                                      outlier.shape = NA)
    } else {
        p_box <- p_box + geom_boxplot(fill = fill,
                                      color = color,
                                      outlier.shape = NA)
    }
    p_box <- p_box + labs(title = title,
                          subtitle = subtitle,
                          x = "", y = "")
    p_box <- p_box + theme(axis.text.x = element_blank(),
                           axis.ticks.x = element_blank(),
                           axis.line.x = element_blank(),
                           axis.text.y = element_blank(),
                           axis.ticks.y = element_blank(),
                           panel.grid.major.y = element_blank())
    # ylim = xlimits is correct. note the coordinate flip
    p_box <- p_box + coord_flip(ylim = x_limits)

    # Combine
    p <- p_box + p_hist + plot_layout(nrow = 2, heights = c(1, 15))

}
