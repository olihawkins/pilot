### Test plotting functions
context("Plotting functions")

# Imports ---------------------------------------------------------------------

source("gallery.R")

# Setup -----------------------------------------------------------------------

test_that("theme and scales render example_scatter_mpg correctly", {
    expect_true(compare_examples(
        GALLERY_SCATTER_MPG_NAME,
        example_scatter_mpg))
})

test_that("theme and scales render example_scatter_cons_type correctly", {
    expect_true(compare_examples(
        GALLERY_SCATTER_CONS_TYPE_NAME,
        example_scatter_cons_type))
})

test_that("theme and scales render example_bar_cons_type correctly", {
    expect_true(compare_examples(
        GALLERY_BAR_CONS_TYPE_NAME,
        example_bar_cons_type))
})

test_that("theme and scales render example_bar_cons_region correctly", {
    expect_true(compare_examples(
        GALLERY_BAR_CONS_REGION_NAME,
        example_bar_cons_region))
})

test_that("theme and scales render example_line_stocks correctly", {
    expect_true(compare_examples(
        GALLERY_LINE_STOCKS_NAME,
        example_line_stocks))
})
