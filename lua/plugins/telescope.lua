local M = {}

function M.setup()

    local ivy = require('telescope.themes').get_ivy({})

    local builtin = require('telescope.builtin')

    local map = {
        { '<leader>', {
            { 'f', function()
                if not pcall(builtin.git_files, ivy) then
                    builtin.find_files(ivy)
                end
            end },
            { 'f', {
                { 'g', '<Cmd>Telescope live_grep theme=get_ivy<CR>' },
                { 'b', '<Cmd>Telescope buffers theme=get_ivy<CR>' },
                { 'h', '<Cmd>Telescope help_tags theme=get_ivy<CR>' }
            }},
        }}
    }

    return map

end

function M.config()

    local actions = require('telescope.actions')

    require('telescope').setup {
        defaults = {
            file_ignore_patterns = {
                '.git/*'
            },
            prompt_prefix = '> ',
            vimgrep_arguments = {
                'rg',
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--smart-case',
                '--hidden',
            },
            pickers = {
                find_files = {
                    find_command = { 'fd', '--type=file', '--hidden', '--smart-case' },
                }
            },
            mappings = {
                i = {
                    ['<c-k>'] = actions.move_selection_previous,
                    ['<c-j>'] = actions.move_selection_next
                },
                n = {
                    ['<Esc>'] = actions.close
                }
            }
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = 'smart_case',
            },
        },
    }

    require('telescope').load_extension('fzf')

end

return M
