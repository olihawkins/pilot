# Theme specific versions of ggplot2 functions setting default styles

# Geoms -----------------------------------------------------------------------

#' A wrapper for the text geometry in ggplot2
#'
#' This function is identical to \code{\link[ggplot2]{geom_text}} in ggplot2.
#' The only difference is that the default arguments implement the pilot chart
#' style.
#'
#' @param color An RGB hex string indicating the color to use for the text. The
#'   default is "#ffffff".
#' @param family A string indicating the font family to use for the text. The
#'   default depends on the operating system.
#' @param fontface A string indicating the font face to use for the text. The
#'  default is "bold".
#' @param ... Any other arguments passed to \code{geom_text}.
#' @export

geom_text_pilot <- function(
    color = "#ffffff",
    family = getOption("pilot.geom_text_family"),
    fontface = "bold",
    ...) {

    ggplot2::geom_text(
        color = color,
        family = family,
        fontface = fontface,
        ...)
}

# Annotate --------------------------------------------------------------------

#' A wrapper for the annotate function in ggplot2
#'
#' This function is identical to \code{\link[ggplot2]{annotate}}  in ggplot2.
#' The only difference is that the default arguments implement the pilot chart
#' style.
#'
#' @param color An RGB hex string indicating the color to use for the text. The
#'   default is "#404040".
#' @param family A string indicating the font family to use for the text. The
#'   default depends on the operating system.
#' @param fontface A string indicating the font face to use for the text. The
#'   default is "plain".
#' @param size An integer indicating the size of the text. The default is 5.
#' @param ... Any other arguments passed to \code{annotate}.
#' @export

annotate_pilot <- function(
    color = "#404040",
    family = getOption("pilot.annotate_family"),
    fontface = "plain",
    size = 5,
    ...) {

    ggplot2::annotate(
        "text",
        family = family,
        fontface = fontface,
        color = color,
        size = size,
        ...)
}
