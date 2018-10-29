# Define function to create coefficients plots
#' Title
#'
#' @param .data
#' @param x_mapping
#' @param y_mapping
#' @param exclude_intercept
#' @param title
#' @param subtitle
#' @param x_label
#' @param y_label
#' @param x_limits
#' @param y_limits
#' @param fill
#' @param color
#' @param breaks
#'
#' @return
#' @export
#' @import ggplot2
#' @examples
my_coef <- function (.data,
                     x_mapping = "estimate",
                     y_mapping = "term",
                     exclude_intercept = FALSE,
                     title = "Coefficients plot",
                     subtitle = "with 95% confidence interval",
                     x_label = "",
                     y_label = "",
                     x_limits = NULL,
                     y_limits = NULL,
                     fill = "#69727a",
                     color = "#414649",
                     breaks = NULL,
                     x_digits = 1)  {

    if (!("term" %in% names(.data))) {
        stop("there is no column named 'term' in the input data.")
    }
    if (!("estimate" %in% names(.data))) {
        stop("there is no column named 'estimate' in the input data.")
    }
    if (exclude_intercept) {
        .data <- .data[.data$term != "(Intercept)", ]
    }

    p <- ggplot(.data, aes_string(x = x_mapping, y = y_mapping))
    p <- p + geom_vline(xintercept = 0, linetype = 2, color = color)
    p <- p + geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), data = .data,
                            color = fill, height = 0.1,
                            linetype = "solid", size = 0.3)
    p <- p + geom_point(color = fill, size = 4)
    p <- p + labs(title = title,
                  subtitle = subtitle,
                  x = x_label, y = y_label)
    p <- p + scale_x_continuous(breaks = c(signif(.data$estimate, x_digits), breaks))
    p <- p + coord_cartesian(xlim = x_limits, ylim = y_limits)

    p
}
