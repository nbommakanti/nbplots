#' Define function to create histograms
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
#' @export
#'
#' @examples
my_hist <- function (.data, mapping, group_mapping = NULL,
                      binwidth = 1,
                      title = NULL, subtitle = NULL,
                      x_label = NULL, y_label = NULL,
                      x_limits = NULL, y_limits = NULL,
                      fill = "#69727a", color = "#414649",
                      y_format = NULL,
                      line_intercept = NULL)  {

    # Construct histogram
    p <- ggplot(.data, aes_string(x = mapping, fill = group_mapping))
    if (is.null(group_mapping)) {
        p <- p + geom_histogram(binwidth = binwidth,
                                fill = fill,
                                color = color)
    } else {
        p <- p + geom_histogram(binwidth = binwidth, color = color)
    }

    p <- p + labs(title = title, subtitle = subtitle, x = x_label, y = y_label)
    p <- p + coord_cartesian(xlim = x_limits, ylim = y_limits)
    if (is.null(y_format)) {
        # do nothing
    } else if (y_format == "k") {
        p <- p + scale_y_continuous(
            label = scales::unit_format(unit = "k", scale = 1e-3))
    } else if (y_format == "comma") {
        p <- p + scale_y_continuous(label = comma)
    }
    if (!is.null(line_intercept)) {
        p <- p + geom_vline(xintercept = line_intercept,
                            linetype = 2, color = fill)
    }
    # Return
    p
}
