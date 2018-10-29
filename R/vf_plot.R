#' Generate a 24-2 VF plot
#'
#' This returns a grob object
#'
#' @return
#' @import data.table
#' @export
#'
#' @examples
vf_plot <- function(data) {

    # Remove facet labels
    theme_update(
        strip.background = element_blank(),
        strip.text.x = element_blank(),
        panel.border = element_rect(linetype = "solid",
                                    fill = NA, color = "#75787B")
    )

    # Call internal function to remove empty grobs from the facet plot
    g <- strip_empty(p)
    g
}
