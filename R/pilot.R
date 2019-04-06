#' pilot: Personal plotting tools
#'
#' Plotting tools for personal projects.
#'
#' @docType package
#' @name pilot
#' @importFrom ggplot2 %+replace%
#' @importFrom magrittr %>%
#' @importFrom rlang .data
NULL

# Tell R CMD check about new operators
if(getRversion() >= "2.15.1") {
    utils::globalVariables(c(".", ":="))
}
