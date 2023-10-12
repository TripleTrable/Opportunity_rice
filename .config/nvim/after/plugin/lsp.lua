local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'rust_analyzer',
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set("n", "gh", '<cmd>ClangdSwitchSourceHeader<cr>', opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vc", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

end)

lsp.setup()

require('lspconfig').ltex.setup({
  filetypes = {  "markdown", "md", "tex" },  flags = { debounce_text_changes = 300 },
  settings = {
    ltex = {
      language = "de-DE",
      setenceCacheSize = 2000,
      additionalRules = {
      	enablePickyRules = true,
      	motherTongue = "de-DE",
      },
      trace = { server = "verbose" },
      disabledRules = {},
      hiddenFalsePositives = {},
      username = "x@y.z",
      apiKey = "tete",
    }
  },
  on_attach = on_attach,
})

local omnisharp_bin = "/home/lars/scripts/omnisharp_run"

local pid = vim.fn.getpid()
require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
}

require'lspconfig'.jdtls.setup
{
    cmd = {'/usr/bin/jdtls'},
}
