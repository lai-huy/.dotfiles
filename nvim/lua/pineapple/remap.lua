vim.keymap.set('n', '<Up>', ':resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Down>', ':resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>pv', ':Ex<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>e', '<C-w><C-w>', { noremap = true })
vim.keymap.set('n', '<Leader>z', '[s1z=', { noremap = true })
vim.keymap.set('n', '<Leader>p', '"+p', { noremap = true })
vim.keymap.set('n', '<Leader>P', '"+P', { noremap = true })
vim.keymap.set('n', '<Leader>f', ':Files<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>c', ':cd %:p:h<CR>:pwd<CR>', { noremap = true })
vim.keymap.set('n', '<Leader><CR>', 'o<Esc>', { noremap = true })
vim.keymap.set('n', '<Space>h', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<Space>j', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<Space>k', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<Space>l', '<C-w>l', { noremap = true })
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })
vim.keymap.set('n', '<Leader>y', '"+y', { noremap = true })
vim.keymap.set('x', '<Leader>y', '"+y', { noremap = true })
vim.keymap.set('n', '<Leader>1', ':bn<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>2', ':bp<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>3', ':retab<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>5', ':lua SpellToggle()<CR>', { noremap = true })
vim.keymap.set('n', '<M-Up>', [[:<C-U>exec("exec 'norm m`' | move -" .. (1+v:count1))<CR>``]], { silent = true })
vim.keymap.set('n', '<M-Down>', [[:<C-U>exec("exec 'norm m`' | move +" .. (0+v:count1))<CR>``]], { silent = true })
vim.keymap.set('i', '<M-Up>', '<C-O>m`<C-O>:move -2<CR><C-O>``', { silent = true })
vim.keymap.set('i', '<M-Down>', '<C-O>m`<C-O>:move +1<CR><C-O>``', { silent = true })
vim.keymap.set('v', '<M-Up>', [[:<C-U>exec("'<,'>move '<-" .. (1+v:count1))<CR>gv]], { silent = true })
vim.keymap.set('v', '<M-Down>', [[:<C-U>exec("'<,'>move '>+" .. (0+v:count1))<CR>gv]], { silent = true })

function SpellToggle()
    if vim.bo.spell then
        vim.bo.spell = false
        vim.bo.spelllang = ''
    else
        vim.bo.spell = true
        vim.bo.spelllang = 'en_us'
    end
end

