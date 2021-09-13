# This is an example of how to make a line chart using the pilot package.
#
# This script is self-contained: running it will create a PNG and an SVG of the
# example chart in the same directory. To run the script will need to ensure:
#
# 1. You have installed all of the packages that the script imports
# 2. You have the dataset "line-chart.csv" in the same directory
#
# See the readme on GitHub to find out how to install the package.
#
# To run the script, type the following code in your R console:
#
# source("line-chart.R")

# Imports ---------------------------------------------------------------------

library(tidyverse)
library(pilot)

# Read in and prepare the data ------------------------------------------------

# Load the data from the csv as a dataframe
df <- read_csv("line-chart.csv")

# Create the plot -------------------------------------------------------------

# Use ggplot to create a plot with data and mappings
plot <- ggplot(
        data = df,
        mapping = aes(
            x = quarter,
            y = estimate,
            color = flow)) +
    # Add a line geometry to draw lines
    geom_line(size = 1.1) +
    # Set labels for the axes, legend, and caption, but don't set titles here
    labs(
        color = NULL,
        x = NULL,
        y = "Thousands of people",
        caption = "Source: ONS, Provisional LTIM estimates") +
    # Configure the the x and y axes: we set the y axis breaks and limits
    scale_x_date(
        expand = c(0, 0)) +
    scale_y_continuous(
        breaks = seq(0, 800, 200),
        limits = c(0, 800),
        expand = c(0, 0)) +
    # Add the Pilot theme, setting a bottom axis and horizontal gridlines
    theme_pilot(
        axes = "b",
        grid = "h") +
    # Use scale_color_manual and pilot_color to set colors for each lines
    scale_color_manual(values = c(
        "Immigration" = pilot_color("navy"),
        "Net migration" = pilot_color("blue"))) +
    # Here we use a theme customisation to overlay the legend on the plot area:
    # We could have used legend_position = "top-right" in theme_pilot
    # to put the legend at the top-right above the plot area
    theme(
        legend.position = c(1.03, 0.99),
        legend.justification = c(1, 1),
        legend.direction = "horizontal",
        legend.text = element_text(margin = margin(r = 10)))

# After creating the plot, add a title and subtitle with add_pilot_titles
plot <- add_pilot_titles(
    plot,
    title = "Net migration fell after the EU referendum",
    subtitle = "International migration in the year ending each quarter")

# Save the plot in different formats ------------------------------------------

# Save a high resolution export of the plot as a png
save_png(
    "line-chart.png",
    plot = plot,
    width = 7.7,
    height = 5.8)

# Save an editable verson of the plot as an svg
save_svg(
    "line-chart.svg",
    plot = plot,
    width = 7.7,
    height = 5.8)
