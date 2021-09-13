# This is an example of how to make a stacked column chart using the pilot
# package.
#
# This script is self-contained: running it will create a PNG and an SVG of the
# example chart in the same directory. To run the script will need to ensure:
#
# 1. You have installed all of the packages that the script imports
# 2. You have the dataset "stacked-column-chart.csv" in the same directory
#
# See the readme on GitHub to find out how to install the package.
#
# To run the script, type the following code in your R console:
#
# source("stacked-column-chart.R")

# Imports ---------------------------------------------------------------------

library(tidyverse)
# library(pilot)

# Read in and prepare the data ------------------------------------------------

# Load the data from the csv as a dataframe
df <- read_csv("stacked-column-chart.csv")

# Convert the year to character data: we don't want to treat this as a date or
# a number in this case, it is just a label for each bar
df$year <- as.character(df$year)

# Turn the nationality column into a factor: setting the order of the levels
# controls the order of the categories in each bar from top to bottom
df$nationality <- factor(df$nationality, levels = c("Non-EU", "EU", "British"))

# Create the plot -------------------------------------------------------------

# Use ggplot to create a plot with data and mappings
plot <- ggplot(
        data = df,
        mapping = aes(
            x = year,
            y = estimate,
            fill = nationality)) +
    # Add a col geometry for columns
    geom_col(width = 0.8) +
    # Set labels for the axes, legend, and caption, but don't set titles here
    labs(
        x = NULL,
        y = NULL,
        fill = NULL,
        caption = "Source: ONS, Provisional LTIM estimates") +
    # Configure the the x and y axes: set the y axis breaks and limits, and
    # turn off the y-axis expansion
    scale_x_discrete() +
    scale_y_continuous(
        limits = c(0, 700),
        breaks = seq(0, 700, 100),
        expand = c(0,0)) +
    # Add the Pilot theme: set the grid to horizontal, the legend to top-left,
    # and the caption to left
    theme_pilot(
        grid = "h",
        legend_position = "top-left",
        caption_position = "left") +
    # Use scale_fill_manual and pilot_color to set category colors
    scale_fill_manual(values = c(
        "British" = pilot_color("yellow"),
        "EU" = pilot_color("navy"),
        "Non-EU" = pilot_color("blue")))

# After creating the plot, add a title and subtitle with add_pilot_titles
plot <- add_pilot_titles(
    plot,
    title = "Immigration is stable but the composition has changed",
    subtitle = "Immigration by nationality in each year ending September (000s)")

# Save the plot in different formats ------------------------------------------

# Save a high resolution export of the plot as a png
save_png(
    "stacked-column-chart.png",
    plot = plot,
    width = 7.7,
    height = 5.8)

# Save an editable verson of the plot as an svg
save_svg(
    "stacked-column-chart.svg",
    plot = plot,
    width = 7.7,
    height = 5.8)
