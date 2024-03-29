% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/themes.R
\name{theme_pilot}
\alias{theme_pilot}
\title{pilot ggplot theme}
\usage{
theme_pilot(
  axes = "",
  grid = "hv",
  legend_position = "right",
  caption_position = "right",
  title_family = getOption("pilot.title_family"),
  subtitle_family = getOption("pilot.subtitle_family"),
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
  grid_color = "#d8d8d8"
)
}
\arguments{
\item{axes}{A string indicating which axes should have lines and ticks.
Specify which axes to show by including the matching characters in the
string: "t" for top, "r" for right, "b" for bottom, "l" for left. You will
need to ensure this argument is consistent with the axes settings in your
plot for the lines and ticks to be displayed. The default is an empty
string, meaning ticks and lines for the bottom and left axes are shown by
default.}

\item{grid}{A string indicating which gridlines should be shown. Specify
the gridlines to show by including the matching characters in the string:
"h" for horizontal, "v" for vertical. The default is "hv",
meaning both gridlines are shown by default.}

\item{legend_position}{A string indicating the position of the legend. Valid
positions are "top", "right", "bottom", "left", "top-right", "top-left",
"bottom-right", "bottom-left", and "none". The default is "right".}

\item{caption_position}{A string indicating the horizontal position of the
caption. Valid positions are "left" or "right". The default is "right".}

\item{title_family}{A string indicating the font-family to use for the
title. The default depends on the operating system.}

\item{subtitle_family}{A string indicating the font-family to use for the
subtitle. The default depends on the operating system.}

\item{axis_title_family}{A string indicating the font-family to use for
axis titles. The default depends on the operating system.}

\item{axis_text_family}{A string indicating the font-family to use for
axis text. The default depends on the operating system.}

\item{legend_title_family}{A string indicating the font-family to use for
legend titles. The default depends on the operating system.}

\item{legend_text_family}{A string indicating the font-family to use for
legend text. The default depends on the operating system.}

\item{facet_title_family}{A string indicating the font-family to use for
facet titles. The default depends on the operating system.}

\item{caption_family}{A string indicating the font-family to use for
captions. The default depends on the operating system.}

\item{title_size}{An integer indicating the font size to use for the title
in points. The default is 17 points.}

\item{subtitle_size}{An integer indicating the font size to use for the
subtitle in points. The default is 12 points.}

\item{axis_title_size}{An integer indicating the font size to use for axis
titles in points. The default is 11 points.}

\item{axis_text_size}{An integer indicating the font size to use for axis
text in points. The default is 11 points.}

\item{legend_title_size}{An integer indicating the font size to use for
legend titles in points. The default is 11 points.}

\item{legend_text_size}{An integer indicating the font size to use for
legend text in points. The default is 10 points.}

\item{facet_title_size}{An integer indicating the font size to use for
facet titles in points. The default is 10 points.}

\item{caption_size}{An integer indicating the font size to use for captions
in points. The default is 9 points.}

\item{title_color}{An RGB hex string indicating the color to use for the
title. The default is "#404040".}

\item{subtitle_color}{An RGB hex string indicating the color to use for the
subtitle. The default is "#404040".}

\item{axis_title_color}{An RGB hex string indicating the color to use for
axis titles. The default is "#404040".}

\item{axis_text_color}{An RGB hex string indicating the color to use for
axis text. The default is "#404040".}

\item{legend_title_color}{An RGB hex string indicating the color to use for
legend titles. The default is "#404040".}

\item{legend_text_color}{An RGB hex string indicating the color to use for
legend text. The default is "#404040".}

\item{facet_title_color}{An RGB hex string indicating the color to use for
facet titles. The default is "#303030".}

\item{caption_color}{An RGB hex string indicating the color to use for
captions. The default is "#404040".}

\item{background_color}{An RGB hex string indicating the color to use for
the background. The default is "#ffffff".}

\item{axis_line_color}{An RGB hex string indicating the color to use for
the axis lines. The default is "#a6a6a6".}

\item{grid_color}{An RGB hex string indicating the color to use for the
gridlines. The default is "#dad5d1".}
}
\value{
A ggplot2 theme that implements the Commons Library style.
}
\description{
This ggplot theme implements the pilot chart style. The theme
offers various options for easily controlling plot settings so that you
don't need to resort to additional uses of the ggplot2 \code{theme} function
in most cases.
}
\details{
The main arguments are \code{axes}, \code{grid}, \code{caption_position},
and \code{legend_positon}. Arguments are also available to set the color and
font properties of elements of the plot.

When creating plots using this theme, the title and subtitle elements may
be set using ggplot2's \code{labs} function, which provides the traditional
ggplot title alignment. Alternatively, the package also provides a function
that aligns the title and subtitle with the left-hand edge of the y-axis
text rather than the left-hand edge of the plotting area.

To set the title and subtitle using this approach, first create a plot in
the normal way, without specifying any title or subtitle in \code{labs}.
Then use the \code{add_pilot_titles} function to add the title and subtitle
elements. Using \code{add_pilot_titles} also has the benefit of correctly
setting the distance between the bottom of the title and the rest of the
plot when no subtitle is needed.

The arguments for controlling the properties of text elements in this
function include options for setting the properties for the title and
subtitle. These will control titles and subtitles that are set using the
ggplot2 \code{labs} function. You can separately configure the properties
of the title and subtitle in \code{add_pilot_titles} if you need to change
the appearance of the title elements when they are set in the recommended
way.
}
