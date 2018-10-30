#' Add VF Locations
#'
#' @param data
#'
#' @return
#' @export
#' @import data.table
#' @import here
#'
#' @examples
add_vf_locations <- function(data) {

    # Load vf_map from the "data" folder
    load(here("data", "vf_map.rda"))

    # Note that there will be missing values. This is intentional - these regions will be removed
    data_with_locations <- data[vf_map, on = c("x", "y")]

    # Return
    data_with_locations
}
