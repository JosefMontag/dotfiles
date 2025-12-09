
# ~/.Rprofile — modernized

# ── Repositories ─────────────────────────────────────────────────────────────
options(
  repos = c(
    CRAN = "https://cran.rstudio.com", 
    CZ = "https://mirrors.nic.cz/R"
  )
)

# ── Library paths ─────────────────────────────────────────────────────────────
# local_lib <- "~/GD/4SYNCFILES/R_libs"
# if (!dir.exists(local_lib)) dir.create(local_lib, recursive = TRUE)
# .libPaths(c(local_lib, .libPaths()))

# # ── Console width auto-adjustment ─────────────────────────────────────────────
# # Works both in radian and standard R terminals
# .adjust_width <- function(...) {
#   cols <- as.integer(Sys.getenv("COLUMNS", ""))
#   if (is.na(cols) || cols <= 0) {
#     cols <- tryCatch(
#       as.integer(system("tput cols", intern = TRUE)), 
#       error = function(e) 80
#     )
#   }
#   options(width = cols, dplyr.width = cols)
#   TRUE
# }
# invisible(addTaskCallback(.adjust_width))
#
# # ── Color output ──────────────────────────────────────────────────────────────
# # colorout speeds up and colorizes output; safe if installed
# if (requireNamespace("colorout", quietly = TRUE)) {
#   library(colorout)
# } else {
#   message("Tip: install.packages('colorout') for colored output.")
# }
#
# # ── Basic options ─────────────────────────────────────────────────────────────
# options(
#   showWarnCalls = TRUE,
#   showErrorCalls = TRUE,
#   pdfviewer = "okular",
#   prompt = "R> ",
#   digits = 5,
#   show.signif.stars = FALSE,
#   stringsAsFactors = FALSE,
#   crayon.enabled = FALSE,
#   width = 80
# )
#
# # ── Session / History ─────────────────────────────────────────────────────────
# # if (interactive()) {
# #   utils::loadhistory("~/.Rhistory")
# #   Sys.setenv(R_HISTSIZE = "100000")
# #   .Last <- function() try(utils::savehistory("~/.Rhistory"), silent = TRUE)
# # }
#
# # ── Integration / Environment-specific tweaks ─────────────────────────────────
# if (nzchar(Sys.getenv("RNVIMSERVER"))) {
#   # Running inside Neovim via r.nvim
#   options(editor = "nvim")
# }
#
# if (nzchar(Sys.getenv("RADIAN_VERSION"))) {
#   # Adjust radian-specific behavior (radian handles colors itself)
#   options(crayon.enabled = TRUE)
# }

# ── Optional extras ───────────────────────────────────────────────────────────
# Uncomment if you frequently use tidyverse or similar:
# suppressPackageStartupMessages(library(tidyverse))
