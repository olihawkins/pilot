### Functions to create a gallery of examples using the theme and scales

# Imports ---------------------------------------------------------------------

library(tidyverse)
library(scales)
devtools::load_all(".")

# Constants -------------------------------------------------------------------

DATASET_DIR <- "datasets"
DATASET_CON_FILE <- file.path(DATASET_DIR, "constituencies.csv")
DATASET_MIGRATION_FILE <- file.path(DATASET_DIR, "migration.csv")
DATASET_MIGRATION_NATIONALITY_FILE <- file.path(DATASET_DIR, "migration-nationality.csv")
DATASET_NURSES_FILE <- file.path(DATASET_DIR, "nurses.csv")

GALLERY_DIR <- "."
GALLERY_FILE <- "gallery.html"

GALLERY_BAR_CONS_REGION_NAME <- file.path("bar-cons-region")
GALLERY_LINE_MIGRATION_NAME <- file.path("line-migration")
GALLERY_BAR_MIGRATION_NAME <- file.path("bar-migration")
GALLERY_AREA_NURSES_NAME <- file.path("area-nurses")
GALLERY_SCATTER_CONS_TYPE_NAME <- file.path("scatter-cons-type")
GALLERY_SCATTER_CONS_FACET_NAME <- file.path("scatter-cons-facet")

SVG_WIDTH <- 7.7
SVG_HEIGHT <- 5.65

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
    examples[[GALLERY_BAR_CONS_REGION_NAME]] = example_bar_cons_region
    examples[[GALLERY_LINE_MIGRATION_NAME]] = example_line_migration
    examples[[GALLERY_BAR_MIGRATION_NAME]] = example_bar_migration
    examples[[GALLERY_AREA_NURSES_NAME]] = example_area_nurses
    examples[[GALLERY_SCATTER_CONS_TYPE_NAME]] = example_scatter_cons_type
    examples[[GALLERY_SCATTER_CONS_FACET_NAME]] = example_scatter_cons_facet

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

example_bar_cons_region <- function() {

    df <- read_csv(DATASET_CON_FILE)
    df$region <- factor(df$region)
    df$region <- fct_rev(reorder(df$region, df$region, length))

    plot <- ggplot(data = df) +
        geom_bar(
            mapping = aes(x = region),
            fill = pilot_color("magenta")) +
        geom_text_pilot(
            stat = "count",
            mapping = aes(x = region, label = ..count..),
            vjust = "top",
            nudge_y = -3) +
        labs(
            x = "Country or region",
            y = "Number of constituencies",
            caption = "olihawkins.com") +
        scale_x_discrete(
            expand = expansion(add = c(0.5, 0.5))) +
        scale_y_continuous(expand = c(0,0)) +
        theme_pilot(axes = "b", grid = "h", caption_position = "left") +
        theme(legend.position = "none")

    plot <- add_pilot_titles(
        plot,
        title = "Countries and regions vary in representation",
        subtitle = "Constituencies by country or region, United Kingdom")

    plot
}

example_line_migration <- function() {

    df <- read_csv(DATASET_MIGRATION_FILE)

    plot <- ggplot(
            data = df,
            mapping = aes(x = quarter, y = estimate, color = flow)) +
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
            "Immigration" = pilot_color("blue"),
            "Net migration" = pilot_color("sky"))) +
        #theme(legend.position = "top", legend.direction = "horizontal")
        theme(
            legend.position = c(1, 0.98),
            legend.justification = c(1, 1),
            legend.direction = "horizontal")

    plot <- add_pilot_titles(
        plot,
        title = "Net migration has fallen since the EU referendum",
        subtitle = "International migration in the year ending each quarter")
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
            "EU" = pilot_color("blue"),
            "Non-EU" = pilot_color("sky")))

    plot <- add_pilot_titles(
        plot,
        title = "Immigration is stable but the composition has changed",
        subtitle = "Immigration by nationality in each year ending September, Thousands")
}

example_area_nurses <- function() {

    df <- read_csv(DATASET_NURSES_FILE) %>%
        pivot_longer(
            cols = -date,
            names_to = "care_setting",
            values_to = "number")

    df$care_setting <- factor(
        df$care_setting,
        levels = c("neonatal", "maternity"))

    plot <- ggplot(
            data = df,
            mapping = aes(x = date, y = number, fill = care_setting)) +
        geom_area() +
        labs(
            x = NULL,
            y = NULL) +
        scale_y_continuous(
            label = comma,
            limits = c(0, 9020),
            breaks = seq(0, 9000, 3000)) +
        scale_x_date() +
        coord_cartesian(expand = FALSE) +
        annotate_pilot(
            x = as.Date("2015-01-01"),
            y = 5500,
            label = "Neonatal nurses",
            color = "#202020",
            hjust = 0) +
        annotate_pilot(
            x = as.Date("2015-01-01"),
            y = 1500,
            label = "Maternity nurses",
            color = "#ffffff",
            hjust = 0) +
        theme_pilot(axes = "b", grid = "h") +
        scale_fill_manual(values = c(
            "neonatal" = pilot_color("sky"),
            "maternity" = pilot_color("blue"))) +
        theme(legend.position = "none")

    plot <- add_pilot_titles(
        plot,
        title = "Neonatal nurses have overtaken maternity nurses",
        subtitle = "Maternity and neonatal nurses in England")
}

example_scatter_cons_type <- function() {

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
            size = 2) +
        labs(
            x = "Median age",
            y = "Turnout",
            color = "Settlement class",
            caption = "olihawkins.com") +
        scale_x_continuous(
            limits = c(25, 55)) +
        scale_y_continuous(
            limits = c(0.5, 0.8),
            label = percent_format(accuracy = 1)) +
        coord_cartesian(expand = FALSE) +
        theme_pilot(grid = "hv") +
        scale_color_manual(values = c(
            "London" = pilot_color("blue"),
            "Other city" = pilot_color("sky"),
            "Large town" = pilot_color("mint"),
            "Medium town" = pilot_color("yellow"),
            "Small town" = pilot_color("green"),
            "Village" = pilot_color("magenta")))

    plot <- add_pilot_titles(
        plot,
        title = "Turnout was higher in older, less urban constituencies",
        subtitle = "Constituencies by age, turnout and settlement class, 2017")
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
            color = "Settlement class",
            caption = "olihawkins.com") +
        scale_x_continuous(
            limits = c(25, 55)) +
        scale_y_continuous(
            limits = c(0.5, 0.85),
            label = percent_format(accuracy = 1)) +
        coord_cartesian(expand = FALSE) +
        theme_pilot(axes = "", grid = "hv") +
        scale_color_manual(values = c(
            "London" = pilot_color("blue"),
            "Other city" = pilot_color("sky"),
            "Large town" = pilot_color("mint"),
            "Medium town" = pilot_color("yellow"),
            "Small town" = pilot_color("green"),
            "Village" = pilot_color("magenta"))) +
        theme(legend.position ="None")

    plot <- add_pilot_titles(
        plot,
        title = "Turnout was higher in older, less urban constituencies",
        subtitle = "Constituencies by age, turnout and settlement class, 2017")
}



