### Colors

#' Pilot colors
#' @export

pilot_colors <- c(
    "blue"   = "#0080e8",
    "sky"    = "#70d0ff",
    "mint"   = "#98f098",
    "yellow" = "#ffa000",
    "green"  = "#009900",
    "magenta" = "#c00060")

#' Get the hex code for a pilot color
#' @param color_name The name of the color.
#' @export

pilot_color <- function (color_name) {
    unname(pilot_colors[color_name])
}
