# Options

#' Set the font family used for all supported text elements
#'
#' The font family used for each text element is controlled through a set of
#' options. This function sets each of these options to the same family,
#' allowing you to quickly customise the font family used by the theme.
#' Individual family options can be set with \code{options}.
#'
#' @param family The name of the font family to use.
#' @param title_family The name of the font family to use for the main chart
#'   title. This is an optional argument that lets you use a different font
#'   family for the main title. The argument is ignored if the value is NULL.
#'   The default value is NULL.
#' @export

set_pilot_family <- function(family, title_family = NULL) {
    if (is.null(title_family)) title_family <- family
    options(pilot.title_family = family)
    options(pilot.subtitle_family = family)
    options(pilot.axis_title_family = family)
    options(pilot.axis_text_family = family)
    options(pilot.legend_title_family = family)
    options(pilot.legend_text_family = family)
    options(pilot.facet_title_family = family)
    options(pilot.caption_family = family)
    options(pilot.geom_text_family = family)
    options(pilot.annotate_family = family)
}

.onLoad <- function(libname, pkgname) {

    # Set a default fonts if system can't be detected
    family <- ""
    title_family <- family

    # Set a default font for each main desktop OS
    switch(Sys.info()[['sysname']],
        Windows = {
            family <- ""
            title_family <- family},
        Linux = {
            family <- ""
            title_family <- family},
        Darwin = {
            family <- "Avenir Next"
            title_family <- "Avenir Next Demi Bold"})

    # Set default options if options have not already been set
    op <- options()

    op_pilot <- list(
        pilot.title_family = title_family,
        pilot.subtitle_family = family,
        pilot.axis_title_family = family,
        pilot.axis_text_family = family,
        pilot.legend_title_family = family,
        pilot.legend_text_family = family,
        pilot.facet_title_family = family,
        pilot.caption_family = family,
        pilot.geom_text_family = family,
        pilot.annotate_family = family)

    to_set <- !(names(op_pilot) %in% names(op))
    if (any(to_set)) options(op_pilot[to_set])
    invisible()
}
