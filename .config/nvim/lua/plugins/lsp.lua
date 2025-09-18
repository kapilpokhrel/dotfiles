-- LSP
return {
    'neovim/nvim-lspconfig',
    -- cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'mason-org/mason.nvim' },
        { 'mason-org/mason-lspconfig.nvim' },
    },
    init = function()
        -- Reserve a space in the gutter
        -- This will avoid an annoying layout shift in the screen
        vim.opt.signcolumn = 'yes'
    end,
    config = function()
        local lsp_defaults = require('lspconfig').util.default_config

        -- Add cmp_nvim_lsp capabilities settings to lspconfig
        -- This should be executed before you configure any language server
        lsp_defaults.capabilities = vim.tbl_deep_extend(
            'force',
            lsp_defaults.capabilities,
            require('cmp_nvim_lsp').default_capabilities()
        )
        -- MASON SETUP
        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = { 'lua_ls', 'clangd', 'pylsp', 'gopls', 'jsonls' },
            automatic_enable = {
                -- We are setting them on our own
                exclude = {
                    "pylsp",
                    "lua_ls",
                    "gopls",
                    "clangd",
                }
            }
        })

        -- DIAGNOSTICS
        vim.diagnostic.config({
            -- virtual_text = true,
            virtual_text = {
                format = function(diagnostic)
                    if diagnostic.code then
                        return string.format("[%s] %s", diagnostic.code, diagnostic.message)
                    end
                    return diagnostic.message
                end,
            },
            float = {
                format = function(diagnostic)
                    if diagnostic.code then
                        return string.format("[%s] %s", diagnostic.code, diagnostic.message)
                    end
                    return diagnostic.message
                end,
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '✘',
                    [vim.diagnostic.severity.WARN] = '▲',
                }
            }
        })
        -- KEYMAPS (for any attached LSP)
        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = { buffer = event.buf }
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'x' }, '<F3>', function()
                    vim.lsp.buf.format({ async = true })
                end, opts)
                vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
            end,
        })

        local lspconfig = require('lspconfig')
        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })
        lspconfig.clangd.setup {
            cmd = { "clangd", "--fallback-style=webkit" },
        }
        lspconfig.gopls.setup {
            settings = {
                gopls = {
                    analyses = {
                        unreachable = true,
                        unusedvariable = true,
                        unusedparams = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                    usePlaceholders = true,
                },
            },
            on_attach = function(client, bufnr)
                -- Enable formatting on save for Go files
                if client.name == "gopls" then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = vim.api.nvim_create_augroup("GoFormat", { clear = true }),
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end,
                    })
                end
            end,
        }
        lspconfig.pylsp.setup {
            cmd = { "pylsp", "-vvv", "--log-file", "/tmp/lsp.log" },
            settings = {
                pylsp = {
                    plugins = {
                        ruff = {
                            enabled = true,
                            formatEnabled = true,
                            executable = "~/.local/share/nvim/mason/packages/python-lsp-server/bin/ruff",
                            -- config = "<path_to_custom_ruff_toml>", -- Custom config for ruff to use
                            extendSelect = { "I", "C90" }, -- Rules that are additionally used by ruff
                            format = { "I" },              -- Rules that are marked as fixable by ruff that should be fixed when running textDocument/formatting
                            unsafeFixes = false,           -- Whether or not to offer unsafe fixes as code actions. Ignored with the "Fix All" action
                            outputFormatr = "pylint",

                            -- Rules that are ignored when a pyproject.toml or ruff.toml is present:
                            lineLength = 100,                                                      -- Line length to pass to ruff checking and formatting
                            indentWidth = 4,
                            exclude = { "__about__.py" },                                          -- Files to be excluded by ruff checking
                            select = { "A", "B", "E", "F", "T10", "SIM", "N", "W", "PLE", "PLR" }, -- Rules to be enabled by ruff
                            ignore = { "W293" },
                            perFileIgnores = { ["__init__.py"] = "CPY001" },                       -- Rules that should be ignored for specific files
                            preview = false,                                                       -- Whether to enable the preview style linting and formatting.
                            targetVersion = "py310",                                               -- The minimum python version to target (applies for both linting and formatting).
                        },
                    }
                }
            }
        }
    end
}
