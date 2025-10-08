# system('xrdb -merge ~/.Xresources')
# system('wmctrl -r "Terminal" -e 0,727,0,950,-1; wmctrl -r "Terminal" -b toggle,maximized_vert')

options(repos=c(CRAN="https://mirrors.nic.cz/R", 'http://cran.rstudio.org'))
.libPaths(c('~/GD/4SYNCFILES/R_libs/', .libPaths()))


.adjustwidth <- function(...) {
	options(width=Sys.getenv("COLUMNS"))
  options(width=system("tput cols", intern=TRUE),
          dplyr.width = getOption('width'))
	TRUE
}
invisible(addTaskCallback(.adjustwidth))

# capabilities("tcltk")
# if('colorout' %in% rownames(utils::installed.packages()) == FALSE) {
#   if('devtools' %in% rownames(utils::installed.packages()) == FALSE) {
#     utils::install.packages('devtools')
#   }
#   devtools::install_github('jalvesaq/colorout')
# }
library(colorout)

# library(setwidth)
# library(plyr)
# library(tidyverse)

# q <- function(save="no", ...) {
  # quit(save=save, ...)
# }
# pwd <- function() getwd()
# cd <- function() setwd()

options(showWarnCalls = T,  # These 2 make errors easier to see.
        showErrorCalls = T, 
        # repos = 'http://cran.rstudio.org',  # Set CRAN 
        pdfviewer = 'okular',  # on Linux, use okular as the pdf viewer
        prompt = 'R> ',  # Set prompt
        digits = 5, 
        # max.print=3000,
        show.signif.stars = FALSE,
        stringsAsFactors = FALSE,
        # verbose = FALSE,
        quietly = FALSE,
        RStata.StataPath ='Dropbox/software/Stata12/StataSE-64.exe',
        crayon.enabled = FALSE
        )

if (interactive()) utils::loadhistory(file = "~/.Rhistory")

# More history
Sys.setenv(R_HISTSIZE='100000')
if (interactive()) {
  .Last <- function() try(savehistory("~/.Rhistory"))
}
