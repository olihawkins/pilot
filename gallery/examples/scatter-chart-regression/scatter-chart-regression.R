# This is an example of how to make a scatterplot with regression parameters
# using the pilot package.
#
# This script is self-contained: running it will create a PNG and an SVG of the
# example chart in the same directory. To run the script will need to ensure:
#
# 1. You have installed all of the packages that the script imports
# 2. You have the dataset "scatter-chart-regression.csv" in the same directory
#
# See the readme on GitHub to find out how to install the package.
#
# To run the script, type the following code in your R console:
#
# source("scatter-chart-regeression.R")

# Imports ---------------------------------------------------------------------

library(tidyverse)
# library(pilot)

# Read in and prepare the data ------------------------------------------------

# Load the data from the csvs as dataframes
df_data <- read_csv("scatter-chart-regression-data.csv")
df_posterior <- read_csv("scatter-chart-regression-posterior.csv")

# Create the plot -------------------------------------------------------------

# Use ggplot to create a plot with data and mappings for the posterior
plot <- ggplot(
        data = df_posterior,
        mapping = aes(x = weight)) +
    # Add a ribbon geometry for the posterior prediction intervals
    geom_ribbon(
        mapping = aes(
            ymin = lower_prediction,
            ymax = upper_prediction),
        fill = pilot_color("orange"),
        alpha = 0.5)  +
    # Add a ribbon geometry for the posterior slope parameter intervals
    geom_ribbon(
        mapping = aes(
            ymin = lower_parameter,
            ymax = upper_parameter),
        fill = pilot_color("brown"),
        alpha = 0.5)  +
    # Add a line geometry for the posterior slope parameter central estimate
    geom_line(
        mapping = aes(y = height),
        color = pilot_color("brown")) +
    # Add a point geometry for the regression data
    geom_point(
        data = df_data,
        mapping = aes(
            x = weight,
            y = height),
        shape = 16,
        size = 2,
        color = "#404040",
        alpha = 0.6) +
    # Set labels for the axes and caption, but don't set titles here
    labs(
        x = "Weight",
        y = "Height",
        caption = "Source: Richard McElreath, Statistical Rethinking, Figure 4.10") +
    # Configure the the axes: set the axis limits and turn off the expansion
    scale_x_continuous(
        expand = c(0, 0)) +
    scale_y_continuous(
        expand = c(0, 0),
        limits = c(120, 190)) +
    # Add the Pilot theme: set the axes to bottom and left, the gridlines to
    # horizontal and vertical, and the caption to left
    theme_pilot(
        axes = "bl",
        grid = "hv",
        caption_position = "left")

# After creating the plot, add a title and subtitle with add_pilot_titles
plot <- add_pilot_titles(
    plot,
    title = "Height increases as a function of weight",
    subtitle = "Fitted regression line, slope interval, and 89% prediction interval")

# Save the plot in different formats ------------------------------------------

# Save a high resolution export of the plot as a png
save_png(
    "scatter-chart-regression.png",
    plot = plot,
    width = 7.7,
    height = 6.4)

# Save an editable verson of the plot as an svg
save_svg(
    "scatter-chart-regression.svg",
    plot = plot,
    width = 6.4,
    height = 6.4)
