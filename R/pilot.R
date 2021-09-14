#' pilot: A minimal and accessible ggplot2 theme
#'
#' A minimal, general purpose ggplot2 theme with an accessible discrete color palette.
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
