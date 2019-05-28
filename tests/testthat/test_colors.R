### Test color functions
context("Color functions")

# Tests -----------------------------------------------------------------------

test_that("pilot_color returns the correct color for a color name", {
    purrr::map(names(pilot_colors), function(color_name) {
        expect_equal(
            pilot_color(color_name),
            unname(pilot_colors[color_name]))
    })
})
