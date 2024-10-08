## !/usr/bin/Rscript
# lang <- Sys.getenv("QUARTO_PROFILE")

# args <- commandArgs(trailingOnly = TRUE)

# lang <- "fr"

library(tidyverse)

book <- langs <- c("en", "fr", "es")

lang <- basename(getwd())
o_lang <- setdiff(langs, lang)
print(o_lang)

files <- list.files("_book",
  pattern = ".html", recursive = TRUE
)

for (j in o_lang) {
  o_files <- list.files(paste0("../", j, "/_book"),
    pattern = ".html", recursive = TRUE
  )
  com_files <- intersect(files, o_files)
  for (k in seq_along(com_files)) {
    readLines(paste0("_book/", com_files[k])) |>
      stringr::str_replace(
        pattern = paste0("/", j, '">'),
        replace = paste0("/", j, "/", com_files[k], '">')
      ) |>
      writeLines(con = paste0("_book/", com_files[k]))
  }
}
