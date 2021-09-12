# This is an example of how to make a labelled bar chart using the pilot
# package.
#
# This script is self-contained: running it will create a PNG and an SVG of the
# example chart in the same directory. To run the script will need to ensure:
#
# 1. You have installed all of the packages that the script imports
# 2. You have the dataset "bar-chart-labels.csv" in the same directory
#
# See the readme on GitHub to find out how to install the package.
#
# To run the script, type the following code in your R console:
#
# source("bar-chart-labels.R")

# Imports ---------------------------------------------------------------------

library(tidyverse)
# library(pilot)

# Read in and prepare the data ------------------------------------------------

# Load the data from the csv as a dataframe
df <- read_csv("bar-chart-labels.csv")

# Turn the region column into a factor and order it by the population in each
# region: this sorts the bars in the chart from largest to smallest
df$region <- factor(df$region)
df$region <- fct_reorder(df$region, df$population, max)

# Create the plot -------------------------------------------------------------

# Use ggplot to create a plot with data
plot <- ggplot(data = df) +
    # Add a column geometry for the bars
    geom_col(
        mapping = aes(
            x = population,
            y = region),
        fill = pilot_color("navy")) +
    # Add a text geometry for the labels: geom_text_pilot uses the theme fonts
    geom_text_pilot(
        mapping = aes(
            x = population,
            y = region,
            label = format(population, digits = 2)),
        hjust = "center",
        nudge_x = -0.4) +
    # Set labels for the axes, but don't set titles here
    labs(
        x = "Millions of people",
        y = NULL) +
    # Configure the the x and y axes, removing the expansion for the x axis
    scale_x_continuous(
        limits = c(0, 10),
        breaks = seq(0, 10, 2),
        expand = c(0,0)) +
    scale_y_discrete(
        expand = expansion(add = c(0.6, 0.6))) +
    # Add the Pilot theme, setting a bottom axis with no gridlines
    theme_pilot(
        axes = "b",
        grid = "")

# After creating the plot, add a title and subtitle with add_pilot_titles
plot <- add_pilot_titles(
    plot,
    title = "Countries and regions vary in population",
    subtitle = "Population of countries and regions in mid-2020, United Kingdom")

# Save the plot in different formats ------------------------------------------

# Save a high resolution export of the plot as a png
save_png(
    "bar-chart-labels.png",
    plot = plot,
    width = 7.7,
    height = 6.2)

# Save an editable verson of the plot as an svg
save_svg(
    "bar-chart-labels.svg",
    plot = plot,
    width = 7.7,
    height = 6.2)
