set runtimepath^=$XDG_CONFIG_HOME/vim
set runtimepath+=$XDG_CONFIG_HOME/vim/after
let vim_dir = "$XDG_CONFIG_HOME/vim"

call plug#begin()
Plug 'jiangmiao/auto-pairs' "auto completes [] and () and makes life a bit easier
Plug 'tpope/vim-commentary' "Comment stuff
Plug 'tpope/vim-surround' "Allows me to change { to [ and what not
Plug 'wellle/targets.vim' "adds more targets like [ or , - lazy but useful
Plug 'lervag/vimtex'
Plug 'github/copilot.vim'
Plug 'dunstontc/vim-vscode-theme'
if v:version >= 800
    Plug 'Sirver/ultisnips'
endif
Plug 'itchyny/lightline.vim'
call plug#end()

let g:mapleader = "\\"

"Global options
filetype plugin indent on
syntax on "activates syntax highlighting among other things
set background=dark "set hg group to dark
set backspace=indent,eol,start "Fixes the backspace
colorscheme dark_plus 
set encoding=utf-8 "required by YCM
set expandtab
set foldlevel=99
set foldmethod=indent "fold your code.
set hidden "work with multiple unsaved buffers.
set incsearch "highlights as you search
set ignorecase
set smartcase
set rnu nu "sets line numbers
set splitbelow splitright
if (has("termguicolors"))
    set termguicolors
endif
let skip_defaults_vim=1
set viminfo=""
set omnifunc=syntaxcomplete#Complete
set undodir="~/.local/state/vim/undo"
set undofile
let g:netrw_dirhistmax = 0

let g:clipboard = {
                \   'name': 'WslClipboard',
                \   'copy': {
                \      '+': 'clip.exe',
                \      '*': 'clip.exe',
                \    },
                \   'paste': {
                \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                \   },
                \   'cache_enabled': 0,
                \ }

hi  Normal       guibg=NONE ctermbg=NONE
hi  NormalFloat  guibg=NONE ctermbg=NONE
set laststatus=2
set showcmd
set shiftwidth=4
set autoindent
set smartindent

"Mapping
map <up>        :resize -2<cr>
map <down>      :resize +2<cr>
map <left>      :vertical resize -2<cr>
map <right>     :vertical resize +2<cr>
nnoremap <leader>pv :Ex<CR>
noremap <leader>e <C-w><C-w>
noremap <leader>z [s1z=
noremap <leader>p "+p
noremap <leader>P "+P
noremap <leader>f :Files<cr>
noremap <leader>c :cd %:p:h<cr>:pwd<cr>
noremap <leader><cr> o<Esc>
noremap <space>h <C-w>h
noremap <space>j <C-w>j
noremap <space>k <C-w>k
noremap <space>l <C-w>l
inoremap jk <Esc>
vnoremap <leader>y "+y
nmap <leader>1 :bn<cr>
nmap <leader>2 :bp<cr>
nmap <leader>3 :retab<cr>
nmap <leader>5 :call SpellToggle()<cr>

function! SpellToggle()
    if &spell
      setlocal spell! spelllang&
    else
      setlocal spell spelllang=en_us
    endif
endfunction

"Lightline
let g:lightline = {
      \ 'colorscheme': 'rosepine_moon',
      \ }

"Vimtex configs
let g:tex_flavor='latex'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_view_method='general'
let g:vimtex_view_general_viewer='/usr/bin/zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=2
let g:tex_conceal='abdmgs'

