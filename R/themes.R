# Themes

# Theme functions -------------------------------------------------------------

#' pilot ggplot theme
#'
#' This ggplot theme implements the pilot chart style. The theme
#' offers various options for easily controlling plot settings so that you
#' don't need to resort to additional uses of the ggplot2 \code{theme} function
#' in most cases.
#'
#' The main arguments are \code{axes}, \code{grid}, \code{caption_position},
#' and \code{legend_positon}. Arguments are also available to set the color and
#' font properties of elements of the plot.
#'
#' When creating plots using this theme, the title and subtitle elements may
#' be set using ggplot2's \code{labs} function, which provides the traditional
#' ggplot title alignment. Alternatively, the package also provides a function
#' that aligns the title and subtitle with the left-hand edge of the y-axis
#' text rather than the left-hand edge of the plotting area.
#'
#' To set the title and subtitle using this approach, first create a plot in
#' the normal way, without specifying any title or subtitle in \code{labs}.
#' Then use the \code{add_pilot_titles} function to add the title and subtitle
#' elements. Using \code{add_pilot_titles} also has the benefit of correctly
#' setting the distance between the bottom of the title and the rest of the
#' plot when no subtitle is needed.
#'
#' The arguments for controlling the properties of text elements in this
#' function include options for setting the properties for the title and
#' subtitle. These will control titles and subtitles that are set using the
#' ggplot2 \code{labs} function. You can separately configure the properties
#' of the title and subtitle in \code{add_pilot_titles} if you need to change
#' the appearance of the title elements when they are set in the recommended
#' way.
#'
#' @param axes A string indicating which axes should have lines and ticks.
#'   Specify which axes to show by including the matching characters in the
#'   string: "t" for top, "r" for right, "b" for bottom, "l" for left. You will
#'   need to ensure this argument is consistent with the axes settings in your
#'   plot for the lines and ticks to be displayed. The default is an empty
#'   string, meaning ticks and lines for the bottom and left axes are shown by
#'   default.
#' @param grid A string indicating which gridlines should be shown. Specify
#'   the gridlines to show by including the matching characters in the string:
#'   "h" for horizontal, "v" for vertical. The default is "hv",
#'   meaning both gridlines are shown by default.
#' @param legend_position A string indicating the position of the legend. Valid
#'   positions are "top", "right", "bottom", "left", "top-right", "top-left",
#'   "bottom-right", "bottom-left", and "none". The default is "right".
#' @param caption_position A string indicating the horizontal position of the
#'   caption. Valid positions are "left" or "right". The default is "right".
#' @param title_family A string indicating the font-family to use for the
#'   title. The default is "Trebuchet MS".
#' @param subtitle_family A string indicating the font-family to use for the
#'   subtitle. The default is "Trebuchet MS".
#' @param axis_title_family A string indicating the font-family to use for
#'   axis titles. The default is "Trebuchet MS".
#' @param axis_text_family A string indicating the font-family to use for
#'   axis text. The default is "Trebuchet MS".
#' @param legend_title_family A string indicating the font-family to use for
#'   legend titles. The default is "Trebuchet MS".
#' @param legend_text_family A string indicating the font-family to use for
#'   legend text. The default is "Trebuchet MS".
#' @param facet_title_family A string indicating the font-family to use for
#'   facet titles. The default is "Trebuchet MS".
#' @param caption_family A string indicating the font-family to use for
#'   captions. The default is "Trebuchet MS".
#' @param title_size An integer indicating the font size to use for the title
#'   in points. The default is 17 points.
#' @param subtitle_size An integer indicating the font size to use for the
#'   subtitle in points. The default is 12 points.
#' @param axis_title_size An integer indicating the font size to use for axis
#'   titles in points. The default is 11 points.
#' @param axis_text_size An integer indicating the font size to use for axis
#'   text in points. The default is 11 points.
#' @param legend_title_size An integer indicating the font size to use for
#'   legend titles in points. The default is 11 points.
#' @param legend_text_size An integer indicating the font size to use for
#'   legend text in points. The default is 10 points.
#' @param facet_title_size An integer indicating the font size to use for
#'   facet titles in points. The default is 10 points.
#' @param caption_size An integer indicating the font size to use for captions
#' in points. The default is 9 points.
#' @param title_color An RGB hex string indicating the color to use for the
#'   title. The default is "#404040".
#' @param subtitle_color An RGB hex string indicating the color to use for the
#'   subtitle. The default is "#404040".
#' @param axis_title_color An RGB hex string indicating the color to use for
#'   axis titles. The default is "#404040".
#' @param axis_text_color An RGB hex string indicating the color to use for
#'   axis text. The default is "#404040".
#' @param legend_title_color An RGB hex string indicating the color to use for
#'   legend titles. The default is "#404040".
#' @param legend_text_color An RGB hex string indicating the color to use for
#'   legend text. The default is "#404040".
#' @param facet_title_color An RGB hex string indicating the color to use for
#'   facet titles. The default is "#303030".
#' @param caption_color An RGB hex string indicating the color to use for
#'   captions. The default is "#404040".
#' @param background_color An RGB hex string indicating the color to use for
#'   the background. The default is "#ffffff".
#' @param axis_line_color An RGB hex string indicating the color to use for
#'   the axis lines. The default is "#a6a6a6".
#' @param grid_color An RGB hex string indicating the color to use for the
#'   gridlines. The default is "#dad5d1".
#' @return A ggplot2 theme that implements the Commons Library style.
#' @export

theme_pilot <- function (
    axes = "",
    grid = "hv",
    legend_position = "right",
    caption_position = "right",
    title_family = getOption("pilot.title_family"),
    subtitle_family =getOption("pilot.subtitle_family"),
    axis_title_family = getOption("pilot.axis_title_family"),
    axis_text_family = getOption("pilot.axis_text_family"),
    legend_title_family = getOption("pilot.legend_title_family"),
    legend_text_family = getOption("pilot.legend_text_family"),
    facet_title_family = getOption("pilot.facet_title_family"),
    caption_family = getOption("pilot.caption_family"),
    title_size = 17,
    subtitle_size = 12,
    axis_title_size = 11,
    axis_text_size = 11,
    legend_title_size = 11,
    legend_text_size = 10,
    facet_title_size = 10,
    caption_size = 9,
    title_color = "#404040",
    subtitle_color = "#404040",
    axis_title_color = "#404040",
    axis_text_color = "#404040",
    legend_title_color = "#404040",
    legend_text_color = "#404040",
    facet_title_color = "#303030",
    caption_color = "#404040",
    background_color = "#ffffff",
    axis_line_color = "#404040",
    grid_color = "#d8d8d8") {

    # Set the caption horizontal justification
    if (stringr::str_detect(caption_position, "left")) {
        caption_hjust = 0
    } else if (stringr::str_detect(caption_position, "right")) {
        caption_hjust = 1
    } else {
        stop("The caption_position should be \"left\" or \"right\"")
    }

    # Baseline theme
    theme_pilot <- ggplot2::theme(
        plot.background = ggplot2::element_rect(
            fill = background_color,
            size = 0),
        plot.margin = ggplot2::margin(
            t = 20,
            r = 20,
            b = 20,
            l = 20, unit = "pt"),
        plot.title = ggplot2::element_text(
            family = title_family,
            color = title_color,
            face = "bold",
            hjust = 0,
            size = title_size,
            margin = ggplot2::margin(
                t = 0,
                r = 0,
                b = 5,
                l = 0, unit = "pt")),
        plot.subtitle = ggplot2::element_text(
            family = subtitle_family,
            color = subtitle_color,
            face = "plain",
            hjust = 0,
            size = subtitle_size,
            margin = ggplot2::margin(
                t = 0,
                r = 0,
                b = 24,
                l = 0, unit = "pt")),
        plot.caption = ggplot2::element_text(
            family = caption_family,
            color = caption_color,
            hjust = caption_hjust,
            size = caption_size,
            margin = ggplot2::margin(
                t = 24,
                r = 0,
                b = 0,
                l = 0, unit = "pt")),
        plot.caption.position = "plot",
        panel.spacing = ggplot2::unit(20, "pt"),
        panel.border = ggplot2::element_blank(),
        panel.background = ggplot2::element_blank(),
        panel.grid = ggplot2::element_blank(),
        panel.grid.major = ggplot2::element_blank(),
        panel.grid.minor = ggplot2::element_blank(),
        axis.line = ggplot2::element_blank(),
        axis.line.x.top = ggplot2::element_blank(),
        axis.line.y.right = ggplot2::element_blank(),
        axis.line.x.bottom = ggplot2::element_blank(),
        axis.line.y.left = ggplot2::element_blank(),
        axis.ticks = ggplot2::element_blank(),
        axis.title = ggplot2::element_text(
            family = axis_title_family,
            color = axis_title_color,
            size = axis_title_size),
        axis.title.x = ggplot2::element_text(
            margin = ggplot2::margin(
                t = 12,
                r = 0,
                b = 0,
                l = 0, unit = "pt")),
        axis.title.x.top = ggplot2::element_text(
            margin = ggplot2::margin(
                t = 0,
                b = 12, unit = "pt")),
        axis.title.y = ggplot2::element_text(
            angle = 90,
            margin = ggplot2::margin(
                t = 0,
                r = 12,
                b = 0,
                l = 0, unit = "pt")),
        axis.title.y.right = ggplot2::element_text(
            angle = 90,
            margin = ggplot2::margin(
                r = 0,
                l = 12, unit = "pt")),
        axis.text = ggplot2::element_text(
            family = axis_text_family,
            color = axis_text_color,
            size = axis_text_size),
        axis.text.x = ggplot2::element_text(
            margin = ggplot2::margin(
                t = 5,
                r = 0,
                b = 0,
                l = 0, unit = "pt")),
        axis.text.x.top = ggplot2::element_text(
            margin = ggplot2::margin(
                t = 0,
                b = 5, unit = "pt")),
        axis.text.y = ggplot2::element_text(
            hjust = 1,
            margin = ggplot2::margin(
                t = 0,
                r = 5,
                b = 0,
                l = 0, unit = "pt")),
        axis.text.y.right = ggplot2::element_text(
            hjust = 0,
            margin = ggplot2::margin(
                r = 0,
                l = 5, unit = "pt")),
        legend.background = ggplot2::element_rect(
            color = NULL,
            fill = background_color,
            size = 0),
        legend.key = ggplot2::element_rect(
            color = background_color,
            fill = background_color),
        legend.title = ggplot2::element_text(
            family = legend_title_family,
            color = legend_title_color,
            face = "bold",
            size = legend_title_size),
        legend.text = ggplot2::element_text(
            family = legend_text_family,
            color = legend_text_color,
            size = legend_text_size),
        strip.background = ggplot2::element_rect(
            color = background_color,
            fill = background_color),
        strip.text = ggplot2::element_text(
            family = facet_title_family,
            color = facet_title_color,
            size = facet_title_size,
            face = "bold"))

    # Axes
    axis_line <- ggplot2::element_line(
        color = axis_line_color,
        size = 0.3,
        linetype = "solid")

    if (stringr::str_detect(axes, "t")) {
        theme_pilot <- theme_pilot %+replace%
            ggplot2::theme(
                axis.line.x.top = axis_line,
                axis.ticks.x.top = axis_line)
    }

    if (stringr::str_detect(axes, "r")) {
        theme_pilot <- theme_pilot %+replace%
            ggplot2::theme(
                axis.line.y.right = axis_line,
                axis.ticks.y.right = axis_line)
    }

    if (stringr::str_detect(axes, "b")) {
        theme_pilot <- theme_pilot %+replace%
            ggplot2::theme(
                axis.line.x.bottom = axis_line,
                axis.ticks.x.bottom = axis_line)
    }

    if (stringr::str_detect(axes, "l")) {
        theme_pilot <- theme_pilot %+replace%
            ggplot2::theme(
                axis.line.y.left = axis_line,
                axis.ticks.y.left = axis_line)
    }

    # Gridlines
    grid_line <- ggplot2::element_line(
        color = grid_color,
        size = 0.35,
        linetype = "solid")

    if (stringr::str_detect(grid, "v")) {
        theme_pilot <- theme_pilot %+replace%
            ggplot2::theme(panel.grid.major.x = grid_line)
    }

    if (stringr::str_detect(grid, "h")) {
        theme_pilot <- theme_pilot %+replace%
            ggplot2::theme(panel.grid.major.y = grid_line)
    }

    # Legend
    if (legend_position %in% c("top", "right", "bottom", "left", "none")) {

        theme_pilot <- theme_pilot %+replace%
            ggplot2::theme(legend.position = legend_position)

    } else if (legend_position == "top-right") {

        theme_pilot <- theme_pilot %+replace%
            ggplot2::theme(
                legend.position = "top",
                legend.direction = "horizontal",
                legend.justification = c(1,0))

    } else if (legend_position == "top-left") {

        theme_pilot <- theme_pilot %+replace%
            ggplot2::theme(
                legend.position = "top",
                legend.direction = "horizontal",
                legend.justification = c(0,1))

    } else if (legend_position == "bottom-right") {

        theme_pilot <- theme_pilot %+replace%
            ggplot2::theme(
                legend.position = "bottom",
                legend.direction = "horizontal",
                legend.justification = c(1,0))

    } else if (legend_position == "bottom-left") {

        theme_pilot <- theme_pilot %+replace%
            ggplot2::theme(
                legend.position = "bottom",
                legend.direction = "horizontal",
                legend.justification = c(0,1))

    } else {
        stop(paste(
            "The legend_position should be one of:",
            "\"top\", \"right\", \"bottom\", \"left\",",
            "\"top-right\", \"top-left\", \"bottom-right\", \"bottom-left\""))
    }

    theme_pilot
}

# Function to add correctly aligned titles ------------------------------------

#' Add titles to a plot using the Cpilot theme style
#'
#' Use this function to add titles to a plot that uses \code{theme_pilot}.
#' Using this functin to set the title and/or subtitle will ensure that title
#' elements are aligned with the left-hand edge of the y-axis text, rather than
#' the left-hand edge of the plotting area.
#'
#' To use the function, first create a plot using \code{theme_pilot}
#' without setting the title or subtitle, capturing the plot object in a
#' variable. Pass the plot to \code{add_pilot_titles} along with the title
#' and subtitle you want to use. This function will return the same plot with
#' titles added to the top and the correct spacing between the titles and the
#' rest of the plot area.
#'
#' Arguments are also available to set the font properties of the title and
#' subtitle elements of the plot.
#'
#' @param plot A ggplot2 plot object to which titles will be added.
#' @param title A string containing the title to add to the plot. Use NULL if
#'   you do not want a title.
#' @param subtitle A string containing the subtitle to add to the plot. Use
#'   NULL if you do not want a subtitle.
#' @param title_family A string indicating the font-family to use for the
#'   title. The default is "National-LFSN Semibd".
#' @param subtitle_family A string indicating the font-family to use for the
#'   subtitle. The default is "National-LFSN Book".
#' @param title_size An integer indicating the font size to use for the title
#'   in points. The default is 18 points.
#' @param subtitle_size An integer indicating the font size to use for the
#'   subtitle in points. The default is 14 points.
#' @param title_color An RGB hex string indicating the color to use for the
#'   title. The default is "#006548".
#' @param subtitle_color An RGB hex string indicating the color to use for the
#'   subtitle. The default is "#006548".
#' @param background_color An RGB hex string indicating the color to use for
#'   the background. The default is "#f0eeed".
#' @return A copy of the input plot with a title and/or subtitle added.
#' @export

add_pilot_titles <- function(
    plot,
    title = NULL,
    subtitle = NULL,
    title_family = getOption("pilot.title_family"),
    subtitle_family = getOption("pilot.subtitle_family"),
    title_size = 17,
    subtitle_size = 12,
    title_color = "#404040",
    subtitle_color = "#404040",
    background_color = "#ffffff") {

    # If no titles are provided, return the plot unmodified
    if (is.null(title) && is.null(subtitle)) return(plot)

    # Set the default title theme to the main theme plus any specified fonts
    theme_titles <- theme_pilot() + ggplot2::theme(
        plot.title = ggplot2::element_text(family = title_family),
        plot.subtitle = ggplot2::element_text(family = subtitle_family))

    # If no subtitle is provided, adjust the title's bottom padding
    if (is.null(subtitle)) {
        theme_titles <- theme_titles + ggplot2::theme(
            plot.title = ggplot2::element_text(
                family = title_family,
                margin = ggplot2::margin(b = 24, unit = "pt")))
    }

    # Remove margin padding from the plot before re-adding with the titles
    plot +
        ggplot2::theme(plot.margin = ggplot2::margin(
            t = 0,
            r = 0,
            b = 0,
            l = 0, unit = "pt")) +
        patchwork::plot_annotation(
            title = title,
            subtitle = subtitle,
            theme = theme_titles)
}
