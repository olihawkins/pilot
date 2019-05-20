### Functions to create a gallery of examples using the theme and scales

# Imports ---------------------------------------------------------------------

library(ggplot2)
library(grDevices)
library(magrittr)
library(purrr)
library(readr)
library(stringr)

# Constants -------------------------------------------------------------------

DATASET_DIR <- "datasets"
DATASET_CON_FILE <- file.path(DATASET_DIR, "constituencies.csv")
DATASET_STOCKS_FILE <- file.path(DATASET_DIR, "stocks.csv")

GALLERY_DIR <- "gallery"
GALLERY_TEST_FILE <- file.path(GALLERY_DIR, "test.svg")
GALLERY_SCATTER_MPG_NAME <- file.path("scatter-mpg")
GALLERY_SCATTER_CONS_TYPE_NAME <- file.path("scatter-cons-type")
GALLERY_SCATTER_CONS_FACET_NAME <- file.path("scatter-cons-facet")
GALLERY_BAR_CONS_TYPE_NAME <- file.path("bar-cons-type")
GALLERY_BAR_CONS_REGION_NAME <- file.path("bar-cons-region")
GALLERY_LINE_STOCKS_NAME <- file.path("line-stocks")

SVG_WIDTH <- 8
SVG_HEIGHT <- 5

# Build gallery ---------------------------------------------------------------

build_example <- function(example_name, example_func) {

    svgfile <- file.path(GALLERY_DIR, stringr::str_glue("{example_name}.svg"))
    grDevices::svg(filename = svgfile, width = SVG_WIDTH, height = SVG_HEIGHT)
    print(example_func())
    dev.off()
}

build_gallery <- function() {

    examples <- list()
    examples[[GALLERY_SCATTER_MPG_NAME]] = example_scatter_mpg
    examples[[GALLERY_SCATTER_CONS_TYPE_NAME]] = example_scatter_cons_type
    examples[[GALLERY_SCATTER_CONS_FACET_NAME]] = example_scatter_cons_facet
    examples[[GALLERY_BAR_CONS_TYPE_NAME]] = example_bar_cons_type
    examples[[GALLERY_BAR_CONS_REGION_NAME]] = example_bar_cons_region
    examples[[GALLERY_LINE_STOCKS_NAME]] = example_line_stocks

    h <- SVG_HEIGHT * 100
    w <- SVG_WIDTH * 100

    elements <- purrr::map_chr(names(examples), function(example_name) {
        build_example(example_name, examples[[example_name]])
        element <- stringr::str_glue(
            "<p>
            <img src=\"{example_name}.svg\" height=\"{h}\" width=\"{w}\" />
            </p>")
    })

    elements <- stringr::str_c(elements, collapse = "")

    html <- stringr::str_glue(
        "<html><head></head><body>{elements}</body></html>")

    htmlfile <- file.path(GALLERY_DIR, stringr::str_glue("gallery.html"))
    readr::write_file(html, htmlfile)
}

# Compare examples ------------------------------------------------------------

compare_examples <- function(example_name, example_func) {

    svg(
        filename = GALLERY_TEST_FILE,
        width = SVG_WIDTH,
        height = SVG_HEIGHT)
    print(example_func())
    dev.off()

    expname <- file.path(GALLERY_DIR, stringr::str_glue("{example_name}.svg"))
    exp <- readr::read_file(expname)
    obs <- readr::read_file(GALLERY_TEST_FILE)

    exp <- stringr::str_replace_all(exp, "<g id=\"surface[0-9]{1,}\">", "")
    obs <- stringr::str_replace_all(obs, "<g id=\"surface[0-9]{1,}\">", "")

    exp == obs
}

# Examples --------------------------------------------------------------------

example_scatter_mpg <- function() {

    mpg <- ggplot2::mpg

    p <- ggplot2::ggplot(mpg, ggplot2::aes(displ, hwy, color = class)) +
        ggplot2::geom_point() +
        ggplot2::labs(
            x = "Engine displacement (litres)",
            y = "Highway mileage (mpg)",
            title = "Bigger engines are more fuel efficient",
            subtitle = "Highway mileage by engine displacement",
            caption = "@olihawkins",
            colour = "Vehicle type") +
        ggplot2::xlim(0, 8) +
        ggplot2::ylim(10, 50) +
        ggplot2::coord_cartesian(expand = FALSE) +
        theme_pilot() +
        scale_color_pilot()
}

example_scatter_cons_type <- function() {

    types <- c("London", "Other city", "Large town",
               "Medium town", "Small town", "Village")
    cs <- suppressMessages(readr::read_csv(DATASET_CON_FILE))
    cs <- cs %>% dplyr::filter(! is.na(classification))
    cs$type <- factor(cs$classification, levels = types)


    p <- ggplot2::ggplot(cs, ggplot2::aes(
            median_age, turnout, color = type)) +
        ggplot2::geom_point() +
        ggplot2::labs(
            x = "Median age",
            y = "Turnout",
            title = "Turnout was higher in older, less urban constituencies",
            subtitle = "Constituencies by age, turnout and settlement class, 2017",
            color = "Settlement class",
            caption = "@olihawkins") +
        ggplot2::scale_x_continuous(
            limits = c(25, 55)) +
        ggplot2::scale_y_continuous(
            limits = c(0.5, 0.8),
            label = scales::percent_format(accuracy = 1)) +
        ggplot2::coord_cartesian(expand = FALSE) +
        theme_pilot() +
        scale_color_pilot()
}

example_scatter_cons_facet <- function() {

    types <- c("London", "Other city", "Large town",
               "Medium town", "Small town", "Village")
    cs <- suppressMessages(readr::read_csv(DATASET_CON_FILE))
    cs <- cs %>% dplyr::filter(! is.na(classification))
    cs$type <- factor(cs$classification, levels = types)

    p <- ggplot2::ggplot(cs, ggplot2::aes(
            median_age, turnout, color = type)) +
        ggplot2::geom_point() +
        ggplot2::facet_wrap(~ type) +
        ggplot2::labs(
            x = "Median age",
            y = "Turnout",
            title = "Turnout was higher in older, less urban constituencies",
            subtitle = "Constituencies by age, turnout and settlement class, 2017",
            color = "Settlement class",
            caption = "@commonslibrary") +
        ggplot2::scale_x_continuous(
            limits = c(25, 55)) +
        ggplot2::scale_y_continuous(
            limits = c(0.5, 0.85),
            label = scales::percent_format(accuracy = 1)) +
        ggplot2::coord_cartesian(expand = FALSE) +
        theme_pilot() +
        scale_color_pilot() +
        ggplot2::theme(legend.position ="None")
}

example_bar_cons_type <- function() {

    types <- c("London", "Other city", "Large town",
        "Medium town", "Small town", "Village")
    cs <- suppressMessages(readr::read_csv(DATASET_CON_FILE))
    cs <- cs %>% dplyr::filter(! is.na(classification))
    cs$type <- factor(cs$classification, levels = types, ordered = FALSE)

    p <- ggplot2::ggplot(cs, ggplot2::aes(type, fill = type)) +
        ggplot2::geom_bar() +
        ggplot2::labs(
            x = "Settlement class",
            y= "Number of constituencies",
            title = "Around half of constituencies are towns",
            subtitle = "Constituencies by settlement class, Great Britain",
            caption = "@olihawkins") +
        ggplot2::scale_x_discrete(
            expand =ggplot2::expand_scale(add = c(0.5, 0.5))) +
        ggplot2::scale_y_continuous(expand = c(0,0)) +
        theme_pilot(grid = "h") +
        # ggplot2::theme(
        #     axis.text.x = ggplot2::element_text(family = "Courier")) +
        scale_fill_pilot(guide = "none")
}

example_bar_cons_region <- function() {

    cs <- suppressMessages(readr::read_csv(DATASET_CON_FILE))
    cs$region <- factor(cs$region)
    cs$region <- forcats::fct_rev(reorder(cs$region, cs$region, length))

    p <- ggplot2::ggplot(cs, ggplot2::aes(region, fill = region)) +
        ggplot2::geom_bar() +
        ggplot2::labs(
            x = "Country or region",
            y = "Number of constituencies",
            title = "Countries and regions vary in representation",
            subtitle = "Constituencies by country or region, United Kingdom",
            caption = "@olihawkins") +
        ggplot2::scale_x_discrete(
            expand =ggplot2::expand_scale(add = c(0.5, 0.5))) +
        ggplot2::scale_y_continuous(expand = c(0,0)) +
        theme_pilot(grid = "h") +
        scale_fill_pilot(guide = "none")
}

example_line_stocks <- function() {

    stocks <- suppressMessages(readr::read_csv(DATASET_STOCKS_FILE))
    codes <- c("AMZN", "AAPL", "GOOG", "MSFT", "ORCL", "IBM")
    stocks$date <- lubridate::dmy(stocks$date)
    stocks <- cltools::get_indices(stocks)
    stocks <- tidyr::gather(stocks, stock, value, -date)
    stocks$stock <- factor(stocks$stock, levels = codes)

    p <- ggplot2::ggplot(stocks,
            ggplot2::aes(date, value, color = stock)) +
        ggplot2::geom_line() +
        ggplot2::labs(
            x = NULL,
            y = "Price index",
            title = "Amazon has done pretty well lately",
            subtitle = "Change in the value of tech stocks during the last decade (baseline = 100)",
            caption = "@olihawkins",
            color = NULL) +
        ggplot2::scale_y_continuous(
            label = scales::comma,
            limits = c(0, 2700)) +
        ggplot2::coord_cartesian(expand = FALSE) +
        theme_pilot(axes = "b", g = "h") +
        scale_color_pilot()
}
