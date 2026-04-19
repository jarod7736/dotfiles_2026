execute pathogen#infect()
call pathogen#helptags()

autocmd vimenter * NERDTree
set directory^=/tmp/vimswap//

set runtimepath^=~/.vim/bundle/ctrlp.vim

set nu
set hidden
let mapleader = " " " map leader to space
nnoremap ' `
nnoremap ` '

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>tw :set wrap<CR>
nnoremap <leader>b :BuffersToggle<CR>

nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

nnoremap <leader>w <C-w>s<C-w>l

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

map <C-j> :bprev<CR>
map <C-k> :bnext<CR>

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

map <leader>cp :CtrlP<cr>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

try
	set switchbuf=useopen,usetab,newtab
	set stal=2
catch
endtry

noremap <leader>m mmHmt:%s/<C-v><cr>//ge<cr>'tzt'm

map <leader>pp :setlocal paste!<cr>

map <leader>a ggVG

map <leader>v :sp ~/.vimrc<cr> " open vimrc in a buffer

" reload
au BufWritePost .vimrc so ~/.vimrc

set history=1000

set ignorecase
set smartcase
set title
set scrolloff=3
set ruler
set ts=2

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

set hlsearch
set incsearch
set showmatch

set vb
set showmode
set showcmd
set ch=2
set cursorline

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
