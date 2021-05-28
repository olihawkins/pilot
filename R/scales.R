### Scales

#' Function to extract pilot colors as hex codes
#'
#' @param ... Names of colors in \code{pilot_colors}.
#' @export

get_pilot_colors <- function(...) {

    colors <- c(...)
    if (is.null(colors))
        return (pilot_colors)
    pilot_colors[colors]
}

#' Return a function which interpolates a pilot color palette
#'
#' @param palette Name of palette in \code{pilot_palettes}.
#' @param reverse Boolean to indicate whether the palette should be reversed.
#' @param ... Additional arguments to pass to \code{colorRampPalette}.
#' @export

get_pilot_palette <- function(
    palette = "five",
    reverse = FALSE, ...) {

    pilot_palettes <- list(
        two =   get_pilot_colors(
            "navy",
            "blue"),
        three =  get_pilot_colors(
            "navy",
            "blue",
            "brown"),
        four = get_pilot_colors(
            "navy",
            "blue",
            "brown",
            "green"),
        five = get_pilot_colors(
            "navy",
            "blue",
            "brown",
            "green",
            "yellow"),
        six = get_pilot_colors(
            "navy",
            "blue",
            "brown",
            "green",
            "yellow",
            "purple"),
        seven = get_pilot_colors(
            "navy",
            "blue",
            "brown",
            "green",
            "yellow",
            "purple",
            "orange"))

    p <- pilot_palettes[[palette]]
    if (reverse) p <- rev(p)
    grDevices::colorRampPalette(p, ...)
}

#' Color scale for pilot colors
#'
#' @param palette Name of palette in \code{pilot_palettes}.
#' @param discrete Boolean to indicate if color aesthetic is discrete.
#' @param reverse Boolean to indicate whether palette should be reversed.
#' @param ... Additional arguments passed to \code{discrete_scale} or
#'   \code{scale_color_gradientn}, depending on the value of \code{discrete}.
#' @export

scale_color_pilot <- function(
    palette = "main",
    discrete = TRUE,
    reverse = FALSE, ...) {

    p <- get_pilot_palette(palette = palette, reverse = reverse)

    if (discrete) {
        ggplot2::discrete_scale(
            "color", paste0("pilot_", palette), palette = p, ...)
    } else {
        ggplot2::scale_color_gradientn(colors = p(256), ...)
    }
}

#' Fill scale for pilot colors
#'
#' @param palette Name of palette in \code{pilot_palettes}.
#' @param discrete Boolean to indicate if color aesthetic is discrete.
#' @param reverse Boolean to indicate whether palette should be reversed.
#' @param ... Additional arguments passed to \code{discrete_scale} or
#'   \code{scale_color_gradientn}, depending on the value of \code{discrete}.
#' @export

scale_fill_pilot <- function(
    palette = "main",
    discrete = TRUE,
    reverse = FALSE, ...) {

    p <- get_pilot_palette(palette = palette, reverse = reverse)

    if (discrete) {
        ggplot2::discrete_scale(
            "fill", paste0("pilot_", palette), palette = p, ...)
    } else {
        ggplot2::scale_fill_gradientn(colors = p(256), ...)
    }
}
