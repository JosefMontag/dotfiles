
# ~/.Rprofile — modernized

# ── Repositories ─────────────────────────────────────────────────────────────
options(
  repos = c(
    CRAN = "https://cran.rstudio.com", 
    CZ = "https://mirrors.nic.cz/R"
  )
)

# ── Integration Checks (R.nvim / VSCode) ───────────────────────────────────
if (nzchar(Sys.getenv("RNVIMSERVER"))) options(editor = "nvim")
if (nzchar(Sys.getenv("RADIAN_VERSION"))) options(crayon.enabled = TRUE)

# ── Auto-Healing Toolchain ─────────────────────────────────────────────────
if (interactive()) {  # <--- THIS GUARD IS CRITICAL
  local({
    # Now it is safe to assume utils is loaded
    installed <- rownames(utils::installed.packages())
    core_tools <- c("devtools", 
                  "languageserver", 
                  "tidyverse"
    )
    missing <- setdiff(core_tools, installed)
    
    if (length(missing) > 0) {
      cat(sprintf("\n[!] Missing core tools: %s\n", 
          paste(missing, collapse = ", ")))
      if (readline("    Install now? (y/n): ") == "y") {
        install(missing)
      } else {
        install.packages("pak", 
          repos = sprintf("https://r-lib.github.io/p/pak/devel/%s/%s/%s", 
            .Platform$pkgType, R.Version()$os, R.Version()$arch))
        pak::pkg_install(missing)
      }
      message("\n[✔] Ready. Restart R.")
    }
  }
  })
}

# Load some libraries by default

if (interactive()) {
  # These are fine because they are for YOU, not the script
  suppressMessages(require(devtools)) 
  suppressMessages(require(pak))
}
