#' Save a plot as an svg
#'
#' @param plot A plot object.
#' @param filename Filename to save to an svg.
#' @param width Width of the image in inches.
#' @param height Height of the image in inches.
#' @export

save_svg <- function(plot, filename, width, height) {
    grDevices::svg(
        filename = filename,
        width = width,
        height = height)
    print(plot)
    device <- grDevices::dev.off()
}

#' Save a plot as a png
#'
#' @param plot A plot object.
#' @param filename Filename to save to a png.
#' @param width Width of the image in inches.
#' @param height Height of the image in inches.
#' @param dpi Number of pixels per inch for the png. The default is 400.
#' @export

save_png <- function(plot, filename, width, height, dpi = 400) {

    svgname <- file.path(
        tempdir(),
        stringr::str_glue("saveplot-{uuid::UUIDgenerate()}.svg"))

    grDevices::svg(
        filename = svgname,
        width = width,
        height = height)
    print(plot)
    grDevices::dev.off()

    rsvg::rsvg_png(
        svgname,
        filename,
        width = width * dpi,
        height = height * dpi)
}
