return {
  'lervag/vimtex',
  ft = { 'tex', 'markdown' },
  config = function()
    ---------------------------------------------------------------------------
    -- === VimTeX (LaTeX) ===
    ---------------------------------------------------------------------------
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_compiler_latexmk = {
      build_dir = 'build',
      continuous = 1,
      callback = 1,
      options = { '-pdf', '-interaction=nonstopmode', '-synctex=1' },
    }

    -- Zathura forward & inverse sync
    vim.g.vimtex_view_general_viewer = 'zathura'
    vim.g.vimtex_view_general_options = '--synctex-forward @line:@col:@tex @pdf'
    vim.g.vimtex_view_zathura_activate = 1
    vim.g.vimtex_view_zathura_check_libsynctex = 1
    -- Optional: close quickfix window automatically after successful build
    vim.g.vimtex_quickfix_autoclose_after_keystrokes = 2

    ---------------------------------------------------------------------------
    -- === Unified keymaps ===
    ---------------------------------------------------------------------------
    local function build()
      local ft = vim.bo.filetype
      if ft == 'tex' then
        vim.cmd 'VimtexCompile'
      elseif ft == 'markdown' then
        local input = vim.fn.expand '%'
        local output = vim.fn.expand '%:r' .. '.pdf'
        vim.fn.jobstart({ 'pandoc', input, '-o', output, '--pdf-engine=xelatex', '--citeproc', '--standalone' }, {
          detach = true,
        })
        vim.notify('Building PDF with Pandoc…', vim.log.levels.INFO)
      else
        vim.notify('No build action for filetype: ' .. ft, vim.log.levels.WARN)
      end
    end

    local function view()
      local ft = vim.bo.filetype
      local pdf = vim.fn.expand '%:r' .. '.pdf'
      if ft == 'tex' then
        vim.cmd 'VimtexView'
      elseif ft == 'markdown' then
        vim.fn.jobstart({ 'zathura', pdf }, { detach = true })
      else
        vim.notify('No view action for filetype: ' .. ft, vim.log.levels.WARN)
      end
    end

    vim.keymap.set('n', '<leader>ll', build, { desc = 'Build PDF (LaTeX/Markdown)' })
    vim.keymap.set('n', '<leader>lv', view, { desc = 'View PDF (LaTeX/Markdown)' })

    ---------------------------------------------------------------------------
    -- === Quality-of-life defaults ===
    ---------------------------------------------------------------------------
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'tex', 'markdown' },
      callback = function()
        vim.opt_local.conceallevel = 0
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.spell = true
      end,
    })
  end,
}
