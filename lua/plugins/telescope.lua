local M = {}

M.telescope = require('telescope')
M.builtin = require('telescope.builtin')
M.actions = require('telescope.actions')
M.themes = require('telescope.themes')

function M.setup()

    local ivy = M.themes.get_ivy({
        show_untracked = true
    })

    local map = {
        { '<leader>', {
            { 'f', function()
                if not pcall(M.builtin.git_files, ivy) then
                    M.builtin.find_files(ivy)
                end
            end },
            { 'f', {
                { 'g', function()
                    M.builtin.live_grep(ivy)
                end },
                { 'b', function()
                    M.builtin.buffers(ivy)
                end },
                { 'h', function()
                    M.builtin.help_tags(ivy)
                end },
                { 't', function()
                    M.search_todos()
                end },
                { 'n', function()
                    M.open_config()
                end }
            }},
        }}
    }

    return map

end

function M.config()

    M.telescope.setup({
        defaults = {
            preview = {
                check_mine_type = false,
                timeout = 500
            },
            file_ignore_patterns = {
                '.git/*'
            },
            prompt_prefix = '> ',
            selection_caret = '> ',
            sorting_strategy = 'ascending',
            color_devicons = true,
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
                    ['<c-k>'] = M.actions.move_selection_previous,
                    ['<c-j>'] = M.actions.move_selection_next
                },
                n = {
                    ['<Esc>'] = M.actions.close
                }
            }
        },
        dynamic_preview_title = true,
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = 'smart_case'
            }
        }
    })

    M.telescope.load_extension('fzf')

end

function M.search_todos()

    M.builtin.grep_string {
        prompt_prefix = 'Search toods > ',
        search = ' TODO:',
        file_ignore_patterns = {
            'snips/*'
        }
    }

end

function M.open_config()

    M.builtin.git_files {
        prompt_prefix = 'Neovim > ',
        cwd = '~/appdata/local/nvim'
    }

end

return M
