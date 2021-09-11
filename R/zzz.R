# Options

#' Set the font family used for all supported text elements
#'
#' The font family used for each text element is controlled through a set of
#' options. This function sets each of these options to the same family,
#' allowing you to quickly customise the font family used by the theme.
#' Individual family options can be set with \code{options}.
#'
#' @param family The name of the font family to use.
#' @export

set_pilot_family <- function(family) {
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

    # Set a default font if system can't ne detected
    default_family <- "Arial"

    # Set a default font for each main desktop OS
    switch(Sys.info()[['sysname']],
           Windows = {default_family <- "Trebuchet MS"},
           Linux = {default_family <- "Arial"},
           Darwin = {default_family <- "PT Sans"})

    # Set default options if options have not already been set
    op <- options()

    op_pilot <- list(
        pilot.title_family = default_family,
        pilot.subtitle_family = default_family,
        pilot.axis_title_family = default_family,
        pilot.axis_text_family = default_family,
        pilot.legend_title_family = default_family,
        pilot.legend_text_family = default_family,
        pilot.facet_title_family = default_family,
        pilot.caption_family = default_family,
        pilot.geom_text_family = default_family,
        pilot.annotate_family = default_family)

    to_set <- !(names(op_pilot) %in% names(op))
    if (any(to_set)) options(op_pilot[to_set])
    invisible()
}
