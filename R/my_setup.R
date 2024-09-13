# book-specific code to include on every page

if (requireNamespace("knitr", quietly = TRUE)) {

  library(glossary)
  glossary::glossary_path("psyteachr") # change to include/glossary.yml or psyteachr for user defined
  glossary_popup("hover") # "click", "hover" or "none"

  # default knitr options ----
  knitr::opts_chunk$set(
    echo       = TRUE,
    results    = "hold",
    out.width  = '100%',
    fig.width  = 8,
    fig.height = 5,
    fig.align  = 'center',
    dpi = 96
  )
}

# Code from Lisa to help with table formatting as Quarto does not currently work well with kableExtra

glossary_table <- function(as_kable = TRUE) {
  glossary <- glossary_options("table")
  if (is.null(glossary))
    glossary <- list()
  term <- names(glossary)
  linked_term <- term
  if (!is.null(glossary_path()) && glossary_path() == "psyteachr") {
    lcterm <- gsub(" ", "-", tolower(term), fixed = TRUE)
    first_letter <- substr(lcterm, 1, 1)
    linked_term <- paste0(" [", lcterm, "](https://psyteachr.github.io/glossary/",
                          first_letter, "#", lcterm, "){target='_blank' class='glossary'} ")
  }
  if (is.null(term)) {
    data.frame()
  } else if (as_kable) {
    the_list <- data.frame(term = linked_term, definition = unlist(glossary))
    kable(the_list[order(term), ],
          escape = FALSE,
          row.names = FALSE, )
  } else {
    the_list <- data.frame(term = term, definition = unlist(glossary))
    the_list[order(term), ]
  }
}
