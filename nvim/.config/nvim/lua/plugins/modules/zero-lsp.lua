return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        build = ':MasonUpdate'
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required

      { 'onsails/lspkind.nvim' },
    },
    config = function()
      local lsp = require('lsp-zero').preset('recommended')
      local lspconfig = require('lspconfig')

      lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
      lspconfig.eslint.setup({
        filestypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json'},
        settings = {
          format = { enable = true },
          lint = { enable = true },
        },
      })

      lsp.ensure_installed({
        'tsserver',
        'eslint',
        'rust_analyzer'
      })

      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local cmp_mappings = lsp.defaults.cmp_mappings({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
      })

      lsp.setup_nvim_cmp({
        mapping = cmp_mappings
      })

      lsp.on_attach(function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
        -- set insert mode signature help
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr })

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
      end)

      -- (Optional) Configure lua language server for neovim
      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

      lsp.setup()
    end
  },
  -- inlay hints
  {
    'simrat39/inlay-hints.nvim',
    config = function()
      require("inlay-hints").setup({
        only_current_line = false,
        eol = {
          right_align = false,
        }
      })
    end
  },
}
