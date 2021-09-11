# Colors

#' Pilot colors
#' @export

pilot_colors <- c(
    "navy"   = "#204466",
    "blue"   = "#249db5",
    "brown"    = "#b84818",
    "green" = "#30c788",
    "yellow"  = "#ffc517",
    "purple" = "#9956db",
    "orange" = "#e77d00")

#' Get the hex code for a pilot color
#'
#' @param color_name The name of the color.
#' @export

pilot_color <- function (color_name) {
    unname(pilot_colors[color_name])
}
