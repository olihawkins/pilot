# This is an example of how to make an annotated area chart using the pilot
# package.
#
# This script is self-contained: running it will create a PNG and an SVG of the
# example chart in the same directory. To run the script will need to ensure:
#
# 1. You have installed all of the packages that the script imports
# 2. You have the dataset "area-chart-annotations.csv" in the same directory
#
# See the readme on GitHub to find out how to install the package.
#
# To run the script, type the following code in your R console:
#
# source("area-chart-annotations.R")

# Imports ---------------------------------------------------------------------

library(tidyverse)
library(scales)
library(pilot)

# Read in and prepare the data ------------------------------------------------

# Load the data from the csv as a dataframe and pivot it into a tidy format
df <- read_csv("area-chart-annotations.csv") %>%
    pivot_longer(
        cols = -date,
        names_to = "energy_source",
        values_to = "gwh")

# Turn the energy_source column into a factor: setting the order of the levels
# controls the order of the categories from top to bottom
df$energy_source <- factor(
    df$energy_source,
    levels = c("other", "renewables"))

# Create the plot -------------------------------------------------------------

# Use ggplot to create a plot with data and mappings
plot <- ggplot(
        data = df,
        mapping = aes(x = date, y = gwh, fill = energy_source)) +
    # Add an area geometry to fill areas based on the data
    geom_area() +
    # Set labels for the axes, but don't set titles here
    labs(
        x = NULL,
        y = NULL,
        caption = "Source: BEIS, Digest of UK Energy Statistics, Table 5.3") +
    # Configure the the x and y axes: we set the y axis breaks and limits, and
    # we turn off the expansion on both axes
    scale_x_date(
        expand = c(0, 0)) +
    scale_y_continuous(
        label = comma,
        limits = c(0, 402000),
        breaks = seq(0, 400000, 100000),
        expand = c(0, 0)) +
    # Use annotate_pilot to add annotations to a plot: this function does
    # the same thing as annotate but it automatically sets the fonts to match
    # the theme style; position each annotation using values on the axis scales
    annotate_pilot(
        x = as.Date("2013-10-07"),
        y = 200000,
        label = "Non-renewable",
        color = "#ffffff",
        hjust = 0) +
    annotate_pilot(
        x = as.Date("2015-04-01"),
        y = 40000,
        label = "Renewable",
        color = "#202020",
        hjust = 0) +
    # Add the Pilot theme, turning on the bottom and left axes, and turning off
    # the gridlines and legend
    theme_pilot(
        axes = "bl",
        grid = "",
        legend_position = "none") +
    # Use scale_fill_manual and pilot_color to set category colors
    scale_fill_manual(values = c(
        "renewables" = pilot_color("green"),
        "other" = pilot_color("navy")))

# After creating the plot, add a title and subtitle with add_pilot_titles
    plot <- add_pilot_titles(
        plot,
        title = "Renewables are growing as a share of electricity generation",
        subtitle = "Electricity generation by fuel type in the United Kingdom from 1996 to 2020, GWh")

# Save the plot in different formats ------------------------------------------

# Save a high resolution export of the plot as a png
ggsave(
    filename = "area-chart-annotations.png",
    plot = plot,
    width = 7.7,
    height = 5.8,
    dpi = 400)

# Save an editable verson of the plot as an svg
ggsave(
    filename = "area-chart-annotations.svg",
    plot = plot,
    width = 7.7,
    height = 5.8,
    dpi = 400)
