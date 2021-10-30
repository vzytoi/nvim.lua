local M = {}

function M.setup()

    local ivy = require('telescope.themes').get_ivy({
        show_untracked = true
    })

    local builtin = require('telescope.builtin')

    local map = {
        { '<leader>', {
            { 'f', function()
                if not pcall(builtin.git_files, ivy) then
                    builtin.find_files(ivy)
                end
            end },
            { 'f', {
                { 'g', function()
                    builtin.live_grep(ivy)
                end },
                { 'b', function()
                    builtin.buffers(ivy)
                end },
                { 'h', function()
                    builtin.help_tags(ivy)
                end }
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
                case_mode = "smart_case"
            }
        }
    }

    require('telescope').load_extension('fzf')

end

return M
