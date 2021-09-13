# This is an example of how to make a facetted scatterplot using the pilot
# package.
#
# This script is self-contained: running it will create a PNG and an SVG of the
# example chart in the same directory. To run the script will need to ensure:
#
# 1. You have installed all of the packages that the script imports
# 2. You have the dataset "scatter-chart-facets.csv" in the same directory
#
# See the readme on GitHub to find out how to install the package.
#
# To run the script, type the following code in your R console:
#
# source("scatter-chart-facets.R")

# Imports ---------------------------------------------------------------------

library(tidyverse)
library(scales)
library(pilot)

# Read in and prepare the data ------------------------------------------------

# Load the data from the csv as a dataframe and filter for GB constituencies
df <- read_csv("scatter-chart-facets.csv") %>%
    filter(! is.na(classification))

# Turn the classification column into a factor: setting the order of the levels
# controls the order of the categories in the legend from top to bottom
settlement_classes <- c(
    "London",
    "Other city",
    "Large town",
    "Medium town",
    "Small town",
    "Village")

df$classification <- factor(df$classification, levels = settlement_classes)

# Create the plot -------------------------------------------------------------

# Use ggplot to create a plot with data and mappings
plot <- ggplot(
        data = df,
        mapping = aes(
            x = median_age,
            y = turnout,
            color = classification)) +
    # Add a point geometry to add points: set shape = 16 to match house style
    geom_point(
        shape = 16,
        size = 2,
        alpha = 0.6) +
    # Use facet_wrap to set the variable to facet with
    facet_wrap(~ classification) +
    # Set labels for the axes, colors and caption: DON'T set titles here
    labs(
        x = "Median age",
        y = "Turnout",
        color = "Settlement class") +
    # Configure the the x and y axes: set the x axis limits; set the y axis
    # limits and the y axis labels to show percentages to the nearest percent,
    # turn off the expansion on both axes
    scale_x_continuous(
        expand = c(0, 0),
        limits = c(25, 55),
        breaks = seq(25, 55, 10)) +
    scale_y_continuous(
        expand = c(0, 0),
        limits = c(0.5, 0.8),
        label = percent_format(accuracy = 1)) +
    # Add the Pilot theme: turn off the axes, set the gridlines to
    # both horizontal and vertical, and turn off the legend
    theme_pilot(
        axes = "",
        grid = "hv",
        legend_position = "none") +
    # Use scale_color_manual and pilot_color to set category colors
    scale_color_manual(values = c(
        "London" = pilot_color("navy"),
        "Other city" = pilot_color("blue"),
        "Large town" = pilot_color("brown"),
        "Medium town" = pilot_color("green"),
        "Small town" = pilot_color("orange"),
        "Village" = pilot_color("purple")))

# After creating the plot, add a title and subtitle with add_pilot_titles
plot <- add_pilot_titles(
    plot,
    title = "Turnout was higher in older, less urban constituencies",
    subtitle = "Constituencies by age, turnout and settlement class, 2017")

# Save the plot in different formats ------------------------------------------

# Save a high resolution export of the plot as a png
save_png(
    "scatter-chart-facets.png",
    plot = plot,
    width = 7.7,
    height = 6.3)

# Save an editable verson of the plot as an svg
save_svg(
    "scatter-chart-facets.svg",
    plot = plot,
    width = 7.7,
    height = 6.3)
