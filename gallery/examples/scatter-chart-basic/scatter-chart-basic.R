# This is an example of how to use the basic features of pilot.
#
# This script is self-contained: running it will create a PNG and an SVG of the
# example chart in the same directory. To run the script will need to ensure
# that you have installed all of the packages that the script imports.
#
# See the readme on GitHub to find out how to install the package.
#
# To run the script, type the following code in your R console:
#
# source("scatter-chart-basic.R")

# Imports ---------------------------------------------------------------------

library(ggplot2)
library(pilot)

# Create the plots -------------------------------------------------------------

plot_1 <- ggplot(
    data = mpg,
    mapping = aes(
        x = displ,
        y = hwy,
        color = class)) +
    geom_point() +
    labs(
        title = "Cars with smaller engines are more efficient",
        subtitle = "Engine size by fuel efficiency and class",
        x = "Engine size in litres",
        y = "Miles per gallon",
        color = "Class",
        caption = "Reproduced from Chapter 3 of R for Data Science") +
    theme_pilot() +
    scale_color_pilot()

plot_2 <- ggplot(
    data = mpg,
    mapping = aes(
        x = displ,
        y = hwy,
        color = class)) +
    geom_point() +
    labs(
        x = "Engine size in litres",
        y = "Miles per gallon",
        color = "Class",
        caption = "Reproduced from Chapter 3 of R for Data Science") +
    theme_pilot() +
    scale_color_pilot()

plot_2 <- add_pilot_titles(
    plot_2,
    title = "Cars with smaller engines are more efficient",
    subtitle = "Engine size by fuel efficiency and class")

# Save the plot in different formats ------------------------------------------

# Save a high resolution export of the plots as a png
save_png(
    "scatter-chart-basic-1.png",
    plot = plot_1,
    width = 7.7,
    height = 5.2)

save_png(
    "scatter-chart-basic-2.png",
    plot = plot_2,
    width = 7.7,
    height = 5.2)

# Save an editable verson of the plots as an svg
save_svg(
    "scatter-chart-basic-1.svg",
    plot = plot_1,
    width = 7.7,
    height = 5.2)

save_svg(
    "scatter-chart-basic-2.svg",
    plot = plot_2,
    width = 7.7,
    height = 5.2)
