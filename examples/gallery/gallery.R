# Functions to create a gallery of examples using the theme and scales

# Imports ---------------------------------------------------------------------

library(tidyverse)
library(scales)
devtools::load_all(".")

# Constants -------------------------------------------------------------------

DATASET_DIR <- "datasets"
DATASET_POP_FILE <- file.path(DATASET_DIR, "population-by-region.csv")
DATASET_CON_FILE <- file.path(DATASET_DIR, "constituencies.csv")
DATASET_MIGRATION_FILE <- file.path(DATASET_DIR, "migration.csv")
DATASET_MIGRATION_NATIONALITY_FILE <- file.path(DATASET_DIR, "migration-nationality.csv")
DATASET_RETHINKING_HW_FILE <- file.path(DATASET_DIR, "rethinking-height-weight.csv")
DATASET_RETHINKING_PS_FILE <- file.path(DATASET_DIR, "rethinking-posterior-summary.csv")
DATASET_ELECTRICITY_FILE <- file.path(DATASET_DIR, "electricity-generation.csv")

GALLERY_DIR <- "."
GALLERY_FILE <- "gallery.html"

GALLERY_BAR_POP_REGION_NAME <- file.path("bar-pop-region")
GALLERY_LINE_MIGRATION_NAME <- file.path("line-migration")
GALLERY_BAR_MIGRATION_NAME <- file.path("bar-migration")
GALLERY_AREA_ELECTRICITY_NAME <- file.path("area-electricity")
GALLERY_SCATTER_CONS_FACET_NAME <- file.path("scatter-cons-facet")
GALLERY_SCATTER_RETHINKING_NAME <- file.path("scatter-rethinking")

SVG_WIDTH <- 7.7
SVG_HEIGHT <- 5.8

# Build gallery ---------------------------------------------------------------

build_example <- function(example_name, example_func) {

    plot <- example_func()

    svgfile <- file.path(GALLERY_DIR, str_glue("{example_name}.svg"))
    save_svg(plot, svgfile, SVG_WIDTH, SVG_HEIGHT)

    pngfile <- file.path(GALLERY_DIR, str_glue("{example_name}.png"))
    save_png(plot, pngfile, SVG_WIDTH, SVG_HEIGHT)
}

build_gallery <- function() {

    examples <- list()
    examples[[GALLERY_BAR_POP_REGION_NAME]] = example_bar_pop_region
    examples[[GALLERY_LINE_MIGRATION_NAME]] = example_line_migration
    examples[[GALLERY_AREA_ELECTRICITY_NAME]] = example_area_electricity
    examples[[GALLERY_BAR_MIGRATION_NAME]] = example_bar_migration
    examples[[GALLERY_SCATTER_CONS_FACET_NAME]] = example_scatter_cons_facet
    examples[[GALLERY_SCATTER_RETHINKING_NAME]] = example_scatter_rethinking

    elements <- map_chr(names(examples), function(example_name) {
        build_example(example_name, examples[[example_name]])
        element <- str_glue(
            "<p>
                <img src=\"{example_name}.svg\" />
            </p>")
    })

    elements <- str_c(elements, collapse = "")

    html <- str_glue(
        "<html><head></head><body>{elements}</body></html>")

    htmlfile <- file.path(GALLERY_DIR, GALLERY_FILE)
    write_file(html, htmlfile)
}

# Examples --------------------------------------------------------------------

example_bar_pop_region <- function() {

    df <- read_csv(DATASET_POP_FILE)
    df$region <- factor(df$region)
    df$region <- fct_reorder(df$region, df$population, max)

    plot <- ggplot(data = df) +
        geom_col(
            mapping = aes(
                x = population,
                y = region),
            fill = pilot_color("navy")) +
        geom_text_pilot(
            mapping = aes(
                x = population,
                y = region,
                label = format(population, digits = 2)),
            hjust = "center",
            nudge_x = -0.4) +
        labs(
            x = "Millions of people",
            y = NULL) +
        scale_x_continuous(
            limits = c(0, 10),
            breaks = seq(0, 10, 2),
            expand = c(0,0)) +
        scale_y_discrete(
            expand = expansion(add = c(0.6, 0.6))) +
        theme_pilot(
            axes = "b",
            grid = "")

    plot <- add_pilot_titles(
        plot,
        title = "Countries and regions vary in population",
        subtitle = "Population of countries and regions in mid-2020, United Kingdom")

    plot
}

example_line_migration <- function() {

    df <- read_csv(DATASET_MIGRATION_FILE)

    plot <- ggplot(
            data = df,
            mapping = aes(
                x = quarter,
                y = estimate,
                color = flow)) +
        geom_line(size = 1.3) +
        labs(
            color = NULL,
            x = NULL,
            y = "Thousands of people",
            caption = "Source: ONS, Provisional LTIM estimates") +
        scale_y_continuous(
            limits = c(0, 810),
            breaks = seq(0, 800, 200)) +
        coord_cartesian(expand = FALSE) +
        theme_pilot(axes = "b", grid = "h") +
        scale_color_manual(values = c(
            "Immigration" = pilot_color("navy"),
            "Net migration" = pilot_color("blue"))) +
        #theme(legend.position = "top", legend.direction = "horizontal")
        theme(
            legend.position = c(1, 0.98),
            legend.justification = c(1, 1),
            legend.direction = "horizontal")

    plot <- add_pilot_titles(
        plot,
        title = "Net migration fell after the EU referendum",
        subtitle = "International migration in the year ending each quarter")
}

example_area_electricity <- function() {

    df <- read_csv(DATASET_ELECTRICITY_FILE) %>%
        pivot_longer(
            cols = -date,
            names_to = "energy_source",
            values_to = "gwh")

    df$energy_source <- factor(
        df$energy_source,
        levels = c("other", "renewables"))

    plot <- ggplot(
        data = df,
        mapping = aes(x = date, y = gwh, fill = energy_source)) +
        geom_area() +
        labs(
            x = NULL,
            y = NULL,
            caption = "Source: BEIS, Digest of UK Energy Statistics, Table 5.3") +
        scale_x_date(
            expand = c(0, 0)) +
        scale_y_continuous(
            label = comma,
            limits = c(0, 402000),
            breaks = seq(0, 400000, 100000),
            expand = c(0, 0)) +
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
        theme_pilot(
            axes = "bl",
            grid = "",
            legend_position = "none") +
        scale_fill_manual(values = c(
            "renewables" = pilot_color("green"),
            "other" = pilot_color("navy")))

    plot <- add_pilot_titles(
        plot,
        title = "Renewables are growing as a share of electricity generation",
        subtitle = "Electricity generation by fuel type in the United Kingdom from 1996 to 2020, GWh")
}


example_bar_migration <- function() {

    df <- read_csv(DATASET_MIGRATION_NATIONALITY_FILE)
    df$year <- as.character(df$year)
    df$nationality <- factor(df$nationality, levels = c("Non-EU", "EU", "British"))

    plot <- ggplot(
        data = df,
        mapping = aes(x = year, y = estimate, fill = nationality)) +
        geom_col() +
        labs(
            x = NULL,
            y = NULL,
            fill = NULL,
            caption = "Source: ONS, Provisional LTIM estimates") +
        scale_x_discrete() +
        scale_y_continuous(
            limits = c(0, 710),
            breaks = seq(0, 700, 100),
            expand = c(0,0)) +
        theme_pilot(
            grid = "h",
            legend_position = "top-left",
            caption_position = "left") +
        scale_fill_manual(values = c(
            "British" = pilot_color("yellow"),
            "EU" = pilot_color("navy"),
            "Non-EU" = pilot_color("blue")))

    plot <- add_pilot_titles(
        plot,
        title = "Immigration is stable but the composition has changed",
        subtitle = "Immigration by nationality in each year ending September (000s)")
}

example_scatter_cons_facet <- function() {

    types <- c("London", "Other city", "Large town",
               "Medium town", "Small town", "Village")
    df <- read_csv(DATASET_CON_FILE)
    df <- df %>% filter(! is.na(classification))
    df$type <- factor(df$classification, levels = types)

    plot <- ggplot(
        data = df,
        mapping = aes(x = median_age, y = turnout, color = type)) +
        geom_point(
            shape = 16,
            size = 2,
            alpha = 0.65) +
        facet_wrap(~ type) +
        labs(
            x = "Median age",
            y = "Turnout",
            color = "Settlement class") +
        scale_x_continuous(
            limits = c(25, 55),
            breaks = seq(25, 55, 10)) +
        scale_y_continuous(
            limits = c(0.5, 0.8),
            label = percent_format(accuracy = 1)) +
        coord_cartesian(expand = FALSE) +
        theme_pilot(
            axes = "",
            grid = "hv",
            legend_position = "none") +
        scale_color_manual(values = c(
            "London" = pilot_color("navy"),
            "Other city" = pilot_color("blue"),
            "Large town" = pilot_color("brown"),
            "Medium town" = pilot_color("green"),
            "Small town" = pilot_color("orange"),
            "Village" = pilot_color("purple")))

    plot <- add_pilot_titles(
        plot,
        title = "Turnout was higher in older, less urban constituencies",
        subtitle = "Constituencies by age, turnout and settlement class, 2017")
}

example_scatter_rethinking <- function() {

    height_weight <- read_csv(DATASET_RETHINKING_HW_FILE)
    posterior_summary <- read_csv(DATASET_RETHINKING_PS_FILE)

    plot <- ggplot(
        data = posterior_summary,
        mapping = aes(x = weight)) +
        geom_ribbon(
            mapping = aes(
                ymin = lower_prediction,
                ymax = upper_prediction),
            fill = pilot_color("orange"),
            alpha = 0.5)  +
        geom_ribbon(
            mapping = aes(
                ymin = lower_parameter,
                ymax = upper_parameter),
            fill = pilot_color("brown"),
            alpha = 0.5)  +
        geom_line(
            mapping = aes(y = height),
            color = pilot_color("brown")) +
        geom_point(
            data = height_weight,
            mapping = aes(
                x = weight,
                y = height),
            shape = 16,
            size = 2,
            color = "#404040",
            alpha = 0.6) +
        labs(
            x = "Weight",
            y = "Height",
            caption = "Source: Richard McElreath, Statistical Rethinking, Figure 4.10") +
        scale_y_continuous(
            limits = c(120, 190)) +
        coord_cartesian(expand = FALSE) +
        theme_pilot(axes = "bl", grid = "hv", caption_position = "left")

    plot <- add_pilot_titles(
        plot,
        title = "Height increases as a function of weight",
        subtitle = "Fitted regression line, slope interval, and 89% prediction interval")
}
