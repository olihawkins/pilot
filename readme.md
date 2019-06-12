# pilot

pilot is a general purpose ggplot2 theme with an accessible discrete color palette.

## Fonts

This theme uses "Avenir Next" and "Avenir Next Demi Bold" as the base and title fonts by default. Use the `base_family` and `title_family` arguments to `theme_pilot()` to use other fonts.

## Installation

Install from GitHub using devtools.

``` r
install.packages("devtools")
devtools::install_github("olihawkins/pilot")
```

## Colors

This theme includes an accessible discrete color palette, comprising six colors that are visually distinct to people with the most commmon types of color blindness.

These colors are available in a named vector called `pilot_colors`.

The base color names are:

* __blue__
* __sky__
* __mint__
* __yellow__
* __green__
* __magenta__

You can use the `pilot_color` function to return the unnamed hex code value for a given name. This makes it easy to map specific colors to categorical variables using the `scale_color_manual()` and `scale_fill_manual()` functions.

```r
scale_color_manual(values = c(
    "a" = pilot_color("blue"),
    "b" = pilot_color("yellow"))
```

These colors are also avaialable as ggplot2 scales with a range of palettes representing different subsets of the colors (see below). However, care should be taken in how you use these scales. For convenience these scales support ggplot2's color interpolation feature. But expanding the six color palette to represent more than six categories risks creating new colors that are no longer visually distinct to people with color blindness. The sequence of colours in the main palette has been chosen to reduce this risk, but if you want ensure the colors remain distinct you should use these scales with discrete data that has the same number of categories as the palette you choose.

## Theme

Set the theme for the session with:

```r
library(ggplot2)
library(pilot)

theme_set(theme_pilot())
```

Or apply the theme directly to a specific plot with `+ theme_pilot()`.

---

_pilot_::__theme_pilot__(_background = "#ffffff"_, _base_family = "Avenir Next"_, _title_family = "Avenir Next Demi Bold"_, _subtitle = TRUE_, _axes = ""_, _grid = "hv"_)

Sets the theme with the following arguments:

* __background__  A hexadecimal color code for the canvas color. The default is "#ffffff".
* __base_family__ The font family name to use for the base font as a string. The default is "Avenir Next".
* __title_family__ The font family name to use for the chart title font as a string. The default is "Avenir Next Demi Bold".
* __subtitle__ Boolean to indicate whether the plot has a subtitle. This argument controls the spacing after the title, so that it is smaller when a subtitle is present. The default is TRUE.
* __axes__ A string to indicate which axes should have axis lines and ticks. Designate the axes to show by including a particular character in the string: "t" for top, "r" for right, "b" for bottom, "l" for left. You will need to position the axes correctly with ggplot, and turn on any secondary axes, in order for the specified axes lines and ticks to be displayed. The default is "", meaning no axes are shown by default.
* __grid__ A string to indicate which gridlines should be shown. Designate which gridlines to show by including a particular character in the string: "h" for horizontal, "v" for vertical. The default is "hv", meaning both gridlines are shown by default.

---

## Scales

Use `scale_color_pilot()` or `scale_fill_pilot()` as approriate. Both functions have the same signature. Please see the note on colors above for appropiate use of these scales.

---

_pilot_::__scale_color_pilot__(_palette = "main"_, _discrete = TRUE_, _reverse = FALSE_, _..._)

_pilot_::__scale_fill_pilot__(_palette = "main"_, _discrete = TRUE_, _reverse = FALSE_, _..._)

Sets the scales with the following arguments:

* __palette__ The name of a palette. Valid names are:
    * _main_ - The main six color palette
    * _blues_ - blue, sky
    * _greens_ - green, mint
    * _blumag_ - blue, magenta
    * _dark_ - blue, green, magenta
    * _light_ - sky, mint, yellow
    * _blugrn_ - blue, sky, mint, green
    * _five_ - blue, sky, mint, yellow, green
* __discrete__ Boolean to indicate if color aesthetic is discrete.
* __reverse__ Boolean to indicate whether palette should be reversed.
* __...__ Additional arguments passed to `discrete_scale` or `scale_color_gradient`, depending on the value of `discrete`.

---

