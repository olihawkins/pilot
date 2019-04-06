### Themes

#' Pilot theme
#'
#' @param base_family The name of the font family to use for the base font.
#' @param title_family The name of the font family to use for the title font.
#' @param subtitle Boolean to indicate whether the plot has a subtitle. This
#'   argument controls the spacing after the title, so that it is smaller when
#'   a subtitle is present. The default is TRUE.
#' @param axes A string to indicate which axes should have axis lines and
#'   ticks. Designate the axes to show by including a particular character in
#'   the string: "t" for top, "r" for right, "b" for bottom, "l" for left. You
#'   will need to position the axes correctly with ggplot, and turn on any
#'   secondary axes, in order for the specified axes lines and ticks to be
#'   displayed. The default is an empty string, meaning no axes are shown by
#'   default.
#' @param grid A string to indicate which gridlines should be shown. Designate
#'   which gridlines to show by including a particular character in the string:
#'   "h" for horizontal, "v" for vertical. The default is "h", meaning
#'   only the horizontal gridlines are shown by default.
#' @export

theme_pilot <- function (
    base_family = "Avenir Next",
    title_family = "Avenir Next Demi Bold",
    subtitle = TRUE,
    axes = "",
    grid = "hv") {

    theme_pilot <- ggplot2::theme(
            plot.background = ggplot2::element_rect(
                fill = "#ffffff",
                size = 0),
            plot.margin = ggplot2::margin(
                t = 16,
                r = 16,
                b = 16,
                l = 16, unit = "pt"),
            plot.title = ggplot2::element_text(
                family = title_family,
                color = "#404040",
                hjust = 0,
                size = 17,
                margin = ggplot2::margin(
                    t = 0,
                    r = 0,
                    b = 6,
                    l = 0, unit = "pt")),
            plot.subtitle = ggplot2::element_text(
                family = base_family,
                color = "#404040",
                face = "plain",
                hjust = 0,
                size = 12,
                margin = ggplot2::margin(
                    t = 0,
                    r = 0,
                    b = 20,
                    l = 0, unit = "pt")),
            plot.caption = ggplot2::element_text(
                family = base_family,
                color = "#404040",
                hjust = 1,
                size = 10,
                margin = ggplot2::margin(
                    t = 12,
                    r = 0,
                    b = 0,
                    l = 0, unit = "pt")),
            panel.border = ggplot2::element_blank(),
            panel.background = ggplot2::element_blank(),
            panel.grid.major = ggplot2::element_blank(),
            panel.grid.minor = ggplot2::element_blank(),
            axis.line.x.top = ggplot2::element_blank(),
            axis.line.y.right = ggplot2::element_blank(),
            axis.line.x.bottom = ggplot2::element_blank(),
            axis.line.y.left = ggplot2::element_blank(),
            axis.ticks = ggplot2::element_blank(),
            axis.title.x = ggplot2::element_text(
                family = base_family,
                color = "#404040",
                size = 11,
                margin = ggplot2::margin(
                    t = 12,
                    r = 0,
                    b = 0,
                    l = 0, unit = "pt")),
            axis.title.x.top = ggplot2::element_text(
                family = base_family,
                margin = ggplot2::margin(
                    t = 0,
                    b = 12, unit = "pt")),
            axis.title.y = ggplot2::element_text(
                family = base_family,
                color = "#404040",
                size = 11,
                angle = 90,
                margin = ggplot2::margin(
                    t = 0,
                    r = 12,
                    b = 0,
                    l = 0, unit = "pt")),
            axis.title.y.right = ggplot2::element_text(
                family = base_family,
                margin = ggplot2::margin(
                    r = 0,
                    l = 12, unit = "pt")),
            axis.text = ggplot2::element_text(
                family = base_family,
                color = "#404040",
                size = 11),
            axis.text.x = ggplot2::element_text(
                family = base_family,
                margin = ggplot2::margin(
                    t = 5,
                    r = 0,
                    b = 0,
                    l = 0, unit = "pt")),
            axis.text.x.top = ggplot2::element_text(
                family = base_family,
                margin = ggplot2::margin(
                    t = 0,
                    b = 5, unit = "pt")),
            axis.text.y = ggplot2::element_text(
                family = base_family,
                hjust = 1,
                margin = ggplot2::margin(
                    t = 0,
                    r = 5,
                    b = 0,
                    l = 0, unit = "pt")),
            axis.text.y.right = ggplot2::element_text(
                family = base_family,
                hjust = 0,
                margin = ggplot2::margin(
                    r = 0,
                    l = 5, unit = "pt")),
            legend.background = ggplot2::element_rect(
                color = NULL,
                fill = "#ffffff",
                size = 0),
            legend.key = ggplot2::element_rect(
                color = NULL,
                fill = "#ffffff"),
            legend.title = ggplot2::element_text(
                family = base_family,
                color = "#404040",
                face = "bold",
                size = 11),
            legend.text = ggplot2::element_text(
                family = base_family,
                color = "#404040",
                size = 10)
        )

    # Subtitle

    if (! subtitle) {
        theme_pilot <- theme_pilot + ggplot2::theme(
            plot.title = ggplot2::element_text(
                margin = ggplot2::margin(b = 16, unit = "pt")))
    }

    # Axes

    axis_line <- ggplot2::element_line(color = "#404040", size = 0.3)

    if (stringr::str_detect(axes, "t")) {
        theme_pilot <- theme_pilot %+replace% ggplot2::theme(
            axis.line.x.top = axis_line,
            axis.ticks.x.top = axis_line)
    }

    if (stringr::str_detect(axes, "r")) {
        theme_pilot <- theme_pilot %+replace% ggplot2::theme(
            axis.line.y.right = axis_line,
            axis.ticks.y.right = axis_line)
    }

    if (stringr::str_detect(axes, "b")) {
        theme_pilot <- theme_pilot %+replace% ggplot2::theme(
            axis.line.x.bottom = axis_line,
            axis.ticks.x.bottom = axis_line)
    }

    if (stringr::str_detect(axes, "l")) {
        theme_pilot <- theme_pilot %+replace% ggplot2::theme(
            axis.line.y.left = axis_line,
            axis.ticks.y.left = axis_line)
    }

    # Grid

    grid_line <- ggplot2::element_line(color = "#d8d8d8",size = 0.2)

    if (stringr::str_detect(grid, "v")) {
        theme_pilot <- theme_pilot %+replace% ggplot2::theme(
            panel.grid.major.x = grid_line)
    }

    if (stringr::str_detect(grid, "h")) {
        theme_pilot <- theme_pilot %+replace% ggplot2::theme(
            panel.grid.major.y = grid_line)
    }

    theme_pilot
}
