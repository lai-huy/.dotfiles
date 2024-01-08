vim.api.nvim_set_keymap('n', '<Up>', ':resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Down>', ':resize +2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>pv', ':Ex<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>e', '<C-w><C-w>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>z', '[s1z=', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>p', '"+p', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>P', '"+P', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>f', ':Files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>c', ':cd %:p:h<CR>:pwd<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader><CR>', 'o<Esc>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Space>h', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<Space>j', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<Space>k', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<Space>l', '<C-w>l', { noremap = true })
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('x', '<Leader>y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>1', ':bn<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>2', ':bp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>3', ':retab<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>5', ':lua SpellToggle()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<M-Up>', [[:<C-U>exec("exec 'norm m`' | move -" .. (1+v:count1))<CR>``]], { silent = true })
vim.api.nvim_set_keymap('n', '<M-Down>', [[:<C-U>exec("exec 'norm m`' | move +" .. (0+v:count1))<CR>``]], { silent = true })
vim.api.nvim_set_keymap('i', '<M-Up>', '<C-O>m`<C-O>:move -2<CR><C-O>``', { silent = true })
vim.api.nvim_set_keymap('i', '<M-Down>', '<C-O>m`<C-O>:move +1<CR><C-O>``', { silent = true })
vim.api.nvim_set_keymap('v', '<M-Up>', [[:<C-U>exec("'<,'>move '<-" .. (1+v:count1))<CR>gv]], { silent = true })
vim.api.nvim_set_keymap('v', '<M-Down>', [[:<C-U>exec("'<,'>move '>+" .. (0+v:count1))<CR>gv]], { silent = true })

function SpellToggle()
    if vim.bo.spell then
        vim.bo.spell = false
        vim.bo.spelllang = ''
    else
        vim.bo.spell = true
        vim.bo.spelllang = 'en_us'
    end
end

