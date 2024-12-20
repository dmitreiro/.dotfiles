local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local virtual_text = true

local default_setup = function(server)
  lspconfig[server].setup({
    capabilities = lsp_capabilities,
  })
end

TogVirtualText = function()
  virtual_text = not virtual_text
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      {virtual_text = virtual_text}
    }
  )
end

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {"pylsp", "lua_ls"},
  handlers = {
    default_setup,
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        handlers = {
          ["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
              -- Disable virtual_text
              virtual_text = virtual_text
            }
          ),
        }
      })
    end,
    pylsp = function ()
    require('lspconfig').pylsp.setup {
      settings = {
        pylsp = {
          plugins = {
            -- formatter options
            black = { enabled = true },
            autopep8 = {enabled = false },
            yapf = {enabled = false },
            -- linter options
            pylint = { enabled = false,--[[ executable = "pylint"]] },
            pyflakes = { enabled = true },
            pycodestyle = {enabled = false },
            -- type checker
            pylsp_mypy = {enabled = true},
            -- auto-completion options
            jedi_completion = {fuzzy = true},
            -- import sorting
            pyls_isort = {enabled = true},
          },
        },
      },
      handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(
          vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = virtual_text,
            underline = false
          }
        )
      }
    }
    end,
  },
})

local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({
    -- Enter key confirms completion item
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl + space triggers completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})
