local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<leader>e", ":Lex 30<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Replacing string
keymap("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", opts)

-- Turning file executable
keymap("n", "<leader><leader>x", "<cmd>!chmod +x %<CR>", opts)

-- Executing file
keymap("n", "<leader>x", "<cmd>w<CR><cmd>!%<CR>", opts)

-- Pushing line below to current
keymap("n", "J", "mzJ`z", opts)

-- Remaps to keep cursor on screen center
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Does nothing if Q is pressed
keymap("n", "Q", "<nop>", opts)

-- QuickFix commands
-- keymap("n", "<C-k>", "<cmd>cnext<CR>zz", opts)
-- keymap("n", "<C-j>", "<cmd>cprev<CR>zz", opts)
-- keymap("n", "<leader>k", "<cmd>lnext<CR>zz", opts)
-- keymap("n", "<leader>j", "<cmd>lprev<CR>zz", opts)

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- keymap('n', '<space>e', vim.diagnostic.open_float, opts)
-- keymap('n', '[d', vim.diagnostic.goto_prev, opts)
-- keymap('n', ']d', vim.diagnostic.goto_next, opts)
-- keymap('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<Tab>", ">gv", opts)
keymap("v", "<S-Tab>", "<gv", opts)

-- Move text up and down
keymap("v", "<S-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<S-k>", ":m '<-2<CR>gv=gv", opts)

-- Don't yank deleted text
keymap("v", "p", "\"_dP", opts)

keymap("n", "<leader>y", "\"+y", opts)
keymap("v", "<leader>y", "\"+y", opts)

keymap("n", "<leader>d", "\"_d", opts)
keymap("v", "<leader>d", "\"_d", opts)

-- Map <Tab> and <S-Tab> to increment and decrement tabs in visual mode
-- keymap('v', '<Tab>', ":s/^/\\t/<CR><ESC>", opts)
-- keymap('v', '<S-Tab>', ":s/^\\t//<CR><ESC>", opts)


-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    keymap('n', 'gD', vim.lsp.buf.declaration, opts)
    -- keymap('n', 'gd', vim.lsp.buf.definition, opts)
    keymap('n', 'K', vim.lsp.buf.hover, opts)
    keymap('n', 'gi', vim.lsp.buf.implementation, opts)
    keymap('n', 'gk', vim.lsp.buf.signature_help, opts)
    keymap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    keymap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    keymap('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    keymap('n', 'gd', vim.lsp.buf.type_definition, opts)
    keymap('n', '<space>rn', vim.lsp.buf.rename, opts)
    keymap({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    keymap('n', 'gr', vim.lsp.buf.references, opts)
    keymap('n', '<space>fm', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

