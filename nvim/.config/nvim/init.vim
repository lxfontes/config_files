" plugins
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vimplug_exists)
	echo "Installing Vim-Plug..."
	echo ""
	silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
" tooling
Plug 'tpope/vim-fugitive'
Plug 'godlygeek/tabular'
Plug 'ervandew/supertab'
Plug 'airblade/vim-rooter'
Plug 'tomtom/tcomment_vim'
Plug 'w0rp/ale'
Plug '/usr/local/opt/fzf' " fzf from brew
Plug 'neovim/nvim-lsp'
Plug 'mhinz/vim-signify'

" terraform / hcl
Plug 'hashivim/vim-terraform'
Plug 'fatih/vim-hclfmt'

" go
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}

" ruby
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }

" cosmetic
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()


let mapleader=' '
filetype plugin indent on
syntax on
set termguicolors                                        " 24-bit colors
set nobackup                                             " no regerts
set nowritebackup                                        " really no regerts
set fillchars=vert:┃                                     " vert = netrw
set textwidth=0                                          " never wrap text
set nowrap                                               " dont even try to break long lines
set colorcolumn=121                                      " keep a guide at this column
set noshowmode                                           " hide current mode from cmdline (as it will be in statusbar anyway)
set cursorline                                           " highlight current line
set splitbelow                                           " open split at bottom
set splitright                                           " open spit on the right
set ignorecase                                           " ignore case on searches
set smartcase                                            " if pattern contains at least 1 upper case, dont ignore case
set incsearch                                            " incremental search
set signcolumn=yes:1                                     " always show sign column for git goodies
set visualbell                                           " no noisy bells
set title                                                " set window title
set number                                               " always show line numbers
set numberwidth=3                                        " always spare 3 chars for line nums
set scrolloff=3                                          " scroll before we get to boundaries
set viminfo='200                                         " file history
set history=1000                                         " command history
set undofile                                             " turn on persistent undo
set undodir=~/.cache/nvim/                               " undo files on this dir
set autoindent                                           " indent stuff
set mouse=a                                              " enable mouse in all modes
set hidden                                               " hide buffers instead of deleting them
set encoding=utf-8                                       " force utf-8 encoding
set hlsearch                                             " highlight search results
set incsearch                                            " show search as you type
set nojoinspaces                                         " do not add spaces when joining lines ending in punctuation
set updatetime=750                                       " save swap & run plugins after this you stop typing for this amount
set expandtab                                            " spaces instead of tabs
set smarttab                                             " insert shift-width unless mid sentence
set clipboard=unnamedplus                                " use system clipboard
set magic                                                " sane regex
set shortmess+=c                                         " hide autocomplete msgs
set inccommand=nosplit                                   " shows you realtime what an :s command will do
set listchars=tab:»·,nbsp:+,trail:·,extends:→,precedes:← " catch special characters
set completeopt=menu,menuone,noinsert                    " always display completion, never pick a default
set wildmode=longest:list,full                           " complete longest string then menu
set showmatch                                            " show matching parenthesis
set matchtime=0                                          " parenthesis matching shouldn't move the cursor


colorscheme onedark

set tabstop=2
set shiftwidth=2
set softtabstop=2

" Resize splits when vim changes size 
autocmd VimResized * wincmd =

augroup autocomplete
  inoremap <silent><expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
	autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

augroup cursorline
  " remember cursor position. Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost * if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |   exe "normal g`\"" | endif

  " only show cursorline in active split/window
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

augroup css
  " adjust word boundary ('w' movement) to stop on dashes, otherwise completion wont work
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

augroup ruby
  au BufRead,BufNewFile *.pill set ft=ruby
  au BufRead,BufNewFile Gemfile set ft=ruby
  au BufRead,BufNewFile Appraisals set filetype=ruby
  au! BufRead,BufNewFile *.ejs setfiletype html
augroup END

augroup markdown
  au BufRead,BufNewFile *.md set filetype=markdown
  au FileType markdown setlocal spell
augroup END

augroup gitcommit
  autocmd FileType gitcommit setlocal spell
augroup END

augroup tabs
	nnoremap <tab> :bn <cr>
	nnoremap <s-tab> :bp <cr>
	nnoremap <silent> <s-t> :new<cr>
augroup END

" go
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_updatetime = 0 " use updatetime
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

augroup go
  " create a go doc comment based on the word under the cursor
  function! s:create_go_doc_comment()
    norm "zyiw
    execute ":norm O// "
    norm "zp
    execute ":norm A ..."
  endfunction
  nnoremap <leader>ui :<C-u>call <SID>create_go_doc_comment()<CR>
  au FileType go nmap <Leader>i <Plug>(go-info)
augroup END

"vim-airline/vim-airline
let g:airline_theme = 'biogoo'
let g:airline_extensions = ['branch', 'tabline', 'ale']
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#formatter = 'default'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" input nerd patched font
let g:airline_symbols.branch = ''
let g:airline_left_sep = ""
let g:airline_right_sep = ""

" ale
let g:ale_echo_msg_format = '%linter% | %s (%code%)'
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_save = 1
let g:ale_linters = {'go': ['gometalinter', 'gofmt' ]}
let g:ale_go_gometalinter_options = '--fast'
let g:ale_go_gobuild_options  = '-tags "integration"'
let g:ale_go_gofmt_options  = '-s'

" signify
let g:signify_sign_add                 = '✚'
let g:signify_sign_change              = ''
let g:signify_sign_delete              = '✖'
let g:signify_sign_delete_first_line   = '✕'

" rooter
let g:rooter_patterns = ['cmd/', 'Rakefile', 'Dockerfile', 'docker-compose.yml', 'vendor/', '.git/' ]
let g:rooter_silent_chdir = 1

" supertab
let g:SuperTabDefaultCompletionType = "context"

" mappings
map q: :echo "you are not quitting, lol"<cr>

" split vertically with <leader> v
" split horizontally with <leader> s
nmap <leader>v :vsplit<CR> <C-w><C-w>
nmap <leader>s :split<CR> <C-w><C-w>

nmap ]e <Plug>(ale_next)
nmap [e <Plug>(ale_previous)

" comments
vmap // :TComment<CR>

" Make it way easier to switch windows (<leader>w)
nmap <leader>w <C-w><C-w>_

"remove extra white space from line end
noremap <leader>s :%s/\s\+$//g<CR>

" search
nmap <leader>a :Ag<space>

" (override) takes search occurrences to the middle of the screen
nnoremap n nzzzv                    
nnoremap N Nzzzv

" reload vimrc
nnoremap gsv :so $MYVIMRC<CR>

nnoremap <silent> <C-p> :Files<CR>
nnoremap <leader><space> :Buffers<CR>
nnoremap <silent>`     <cmd>lua vim.lsp.buf.hover()<CR>

lua <<END
require'nvim_lsp'.gopls.setup{}
END
