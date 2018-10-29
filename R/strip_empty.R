#' Define internal function to strip empty grobs from facet plot
#'
#' @param p
#'
#' @return
#'
#' @examples
strip_empty <- function(p) {
    g <- ggplotGrob(p)

    panels <- unique(g$layout$name)[grepl("panel", unique(g$layout$name))]
    to_remove <- c("panel-1-1", "panel-1-2", "panel-1-8",
                   "panel-2-1", "panel-2-8",
                   "panel-3-1", "panel-3-7", "panel-3-8",
                   "panel-6-1", "panel-6-2", "panel-6-3","panel-6-7",
                   "panel-7-1", "panel-7-2", "panel-7-7",
                   "panel-8-1", "panel-8-2", "panel-8-8",
                   "panel-9-1", "panel-9-8")
    # used this and c(to_remove, remaining_options[i]) to find arbitrary panel locations to remove
    # remaining_options <- setdiff(panels, to_remove)

    # get the grobs that must be removed
    rm_grobs <- g$layout$name %in% to_remove
    # remove grobs
    g$grobs[rm_grobs] <- NULL
    g$layout <- g$layout[!rm_grobs, ]
    g
}
