" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" function {{{
function! EnsureDirExits (dir)
  if !isdirectory(a:dir)
    if exists("*mkdir")
      call mkdir(a:dir, 'p')
      echo "Created directory: " . a:dir
    else
      echo "please create directory: " . a:dir
    endif
  endif
endfunction
" }}}
"
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-unimpaired'
Plug 'w0rp/ale'
Plug 'junegunn/fzf',{'dir': '~/.fzf', 'do': './install --all'}
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
" Plug ('radenling/vim-dispatch-neovim')
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'leafgarland/typescript-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'liuchengxu/eleline.vim'
Plug 'tomtom/tcomment_vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'mileszs/ack.vim'
Plug 'fatih/vim-go'
Plug 'rbgrouleff/bclose.vim'
Plug 'posva/vim-vue'
Plug 'easymotion/vim-easymotion'
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier',{
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'vue', 'yaml', 'html'] }
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

Plug 'Valloric/YouCompleteMe'

Plug 'wannesm/wmgraphviz.vim'

Plug 'terryma/vim-multiple-cursors'
" ColorScheme
Plug 'morhetz/gruvbox'

Plug 'gagoar/StripWhiteSpaces'
Plug 'sedm0784/vim-you-autocorrect'
Plug 'thinca/vim-quickrun'
Plug 'christoomey/vim-tmux-navigator'
Plug 'corylanou/vim-present'
Plug 'dart-lang/dart-vim-plugin'
Plug 'simnalamburt/vim-mundo'
Plug 'rust-lang/rust.vim'
Plug 'travisjeffery/vim-auto-mkdir'
Plug 'majutsushi/tagbar'
Plug 'francoiscabrol/ranger.vim'
" Plug ('sheerun/vim-polyglot')
Plug 'natebosch/vim-lsc'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'

Plug 'racer-rust/vim-racer'
call plug#end()

" Command for fzf {{{
nnoremap <C-p> :<C-u>FZF<CR>
" }}}
" Command for shortkey {{{
inoremap jj <ESC>
" }}}
" basic {{{
set nocompatible
syntax enable
syn on
filetype plugin indent on
set mouse=a
set showcmd
set showmode
set backspace=indent,eol,start
set hidden
set wildmenu
set wildmode=list:longest
set ignorecase
set smartcase
set number
set relativenumber
set ruler
set incsearch
set hlsearch
set wrap
set scrolloff=3
set title
set visualbell
set shell=bash

set ofu=syntaxcomplete#Complete

set laststatus=2
" set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
" Map cursor for insert mode
let &t_SI .= "\<Esc>[5 q"
" solid block
let &t_EI .= "\<Esc>[2 q"
" }}}
" Tabs, spaces, wrapping ------------------- {{{
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set wrap
set textwidth=110 "80-width lines is for 1995"
let &wrapmargin=&textwidth
set formatoptions=qrn1
set nu
set ic
" }}}
" copy {{{
" pbcopy
set clipboard=unnamed
" }}}
" Color Scheme {{{
set t_Co=256
set background=dark
hi Search term=reverse cterm=reverse gui=reverse ctermfg=237
colorscheme gruvbox
" }}}
" mapleader {{{
let mapleader = " "
let maplocalleader = "\\"
" }}}
" shortkey {{{
nnoremap <leader>ev :e ~/.config/nvim/init.vim<CR>
nnoremap <ESC><ESC> :nohlsearch<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>gl :Gist -l<Space>
nnoremap <leader>gi :GoImport<Space>
nnoremap <leader>/ :Ack!<Space>
nnoremap <leader>s :ALENextWrap<CR>
nnoremap <leader>m :TagbarToggle<CR>
nnoremap <leader>c :Bclose<CR>

" terminail
if has('nvim')
  tnoremap <ESC> <C-\><C-n>
  tnoremap <C-v><ESC> <ESC>
else
  tnoremap <ESC> <C-\><C-n>
endif
" }}}
" Nerdtree {{{
map <leader>n :NERDTreeToggle<cr>
" }}}
" split naviagation {{{
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" }}}
" vim-quickrun {{{
let g:quickrun_config = {
\    "_" : {
\        "outputter" : "message",
\    },
\}
" }}}
" ale always {{{
let g:ale_sign_column_always=1
let g:ale_fixers = {'javascript': ['prettier_standard']}
let g:ale_linters = {'javascript': ['']}
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_standard_use_global=1
let g:ale_fixers = {'css': ['prettier']}

" max line length that prettier will wrap on
" Prettier default: 80
let g:prettier#config#print_width = 80

" number of spaces per indentation level
" Prettier default: 2
let g:prettier#config#tab_width = 2

" use tabs over spaces
" Prettier default: false
let g:prettier#config#use_tabs = 'false'

" print semicolons
" Prettier default: true
let g:prettier#config#semi = 'true'

" single quotes over double quotes
" Prettier default: false
let g:prettier#config#single_quote = 'true'

" print spaces between brackets
" Prettier default: true
let g:prettier#config#bracket_spacing = 'false'

" put > on the last line instead of new line
" Prettier default: false
let g:prettier#config#jsx_bracket_same_line = 'true'

" avoid|always
" Prettier default: avoid
let g:prettier#config#arrow_parens = 'always'

" none|es5|all
" Prettier default: none
let g:prettier#config#trailing_comma = 'all'

" flow|babylon|typescript|css|less|scss|json|graphql|markdown
" Prettier default: babylon
let g:prettier#config#parser = 'flow'

" cli-override|file-override|prefer-file
let g:prettier#config#config_precedence = 'prefer-file'

" always|never|preserve
let g:prettier#config#prose_wrap = 'preserve'

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
" }}}
" youcompleteme ultisnips {{{
" make ycm compatible with ultisnips (using supertab)
let g:ycm_key_list_select_completion = ['<c-n>', '<down>']
let g:ycm_key_list_previous_completion = ['<c-j>', '<up>']
let g:supertabdefaultcompletiontype = '<c-n>'

" better key bindings for ultisnipsexpandtrigger
let g:ultisnipsexpandtrigger = "<tab>"
let g:ultisnipsjumpforwardtrigger = "<tab>"
let g:ultisnipsjumpbackwardtrigger = "<s-tab>"
" }}}
" vim-mundo ------- {{{
set undofile
" check 'vim-mundo directory'
call EnsureDirExits($HOME . '/.vim/tmp/undo')
set undodir=~/.vim/tmp/undo
nnoremap <leader>u :MundoToggle<cr>
let g:mundo_debug = 1
let g:mundo_preview_bottom = 1
let g:mundo_tree_statusline = "mundo"
let g:mundo_preview_statusline = "mundo preview"
" }}}
" Dart-vim-plugin {{{
let dart_format_on_save = 1
" }}}
" range {{{
map <leader>f :Ranger<CR>
let g:NERDTreeHijackNetrw = 0 "// add this line if you use NERDTree
let g:ranger_replace_netrw = 1 "// open ranger when vim open a directory
" }}}
" ale always {{{
let g:ale_sign_column_always=1
let g:ale_fixers = {'javascript': ['prettier_standard']}
let g:ale_fixers = {'typescript': ['prettier_standard']}
let g:ale_linters = {'javascript': ['']}
let g:ale_linters = {'typescript': ['']}
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_standard_use_global=1
" }}}
" dart {{{
let g:lsc_server_commands = {'dart': 'dart_language_server'}
let g:lsc_auto_map = v:true " Use defaults
" ... or set only the keys you want mapped, defaults are:
" let g:lsc_auto_map = {
"     \ 'GoToDefinition': '<C-]>',
"     \ 'FindReferences': 'gr',
"     \ 'NextReference': '<C-n>',
"     \ 'PreviousReference': '<C-p>',
"     \ 'FindImplementations': 'gI',
"     \ 'FindCodeActions': 'ga',
"     \ 'DocumentSymbol': 'go',
"     \ 'WorkspaceSymbol': 'gS',
"     \ 'ShowHover': 'K',
"     \ 'Completion': 'completefunc',
"     \}
autocmd CompleteDone * silent! pclose
" let g:lsc_trace_level = 'verbose'
"
let g:lsc_preview_split_direction = 'above'
" }}}
" vim-go ----------------------------------- {{{
  let g:go_auto_type_info=1
  let g:go_fmt_autosave = 1
  let g:go_fmt_command = "goimports"
  let g:go_goimports_bin = "goimports -tabs=false -tabwidth=4"
  let g:go_fmt_fail_silently = 1
  let g:go_fmt_experimental = 1
  let g:go_doc_keywordprg_enabled = 1
  " let g:go_bin_path = expand("~/bin")
  let g:go_bin_path = $HOME."/bin"
  let g:go_highlight_array_whitespace_error = 1
  let g:go_highlight_chan_whitespace_error = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_space_tab_error = 1
  let g:go_highlight_trailing_whitespace_error = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_build_constraints = 1
  let g:go_snippet_engine = "ultisnips"
  let g:go_gocode_propose_source=0

  let g:go_metalinter_autosave = 1
  "let g:go_metalinter_autosave_enabled = ['vet', 'golint']
  "let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
  " shortkey
  " au FileType go nmap <Leader>s <Plug>(go-implements)
  nnoremap <leader>es :vsplit ~/.config/nvim/plugged/vim-snippets/snippets/

  set invsplitbelow
  let g:go_term_mode = "split"
  let g:go_term_enabled = 1
  "let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
  let g:syntastic_go_checkers = ['gometalinter']
  let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
  let g:go_list_type = "quickfix"
  nnoremap <leader>m :TagbarToggle<CR>
" }}}.
" Error and warning signs. {{{
" let g:ale_sign_error = '⤫'
" let g:ale_sign_warning = '⚠'
" }}}
" rust {{{
let g:LanguageClient_autoStart = 0
nnoremap <leader>lcs :LanguageClientStart<CR>
" if you want it to turn on automatically
" let g:LanguageClient_autoStart = 1

" let g:LanguageClient_serverCommands = {
"     \ 'python': ['pyls'],
"     \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
"     \ 'javascript': ['javascript-typescript-stdio'],
"     \ 'go': ['go-langserver'] }
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'] }

let g:racer_experimental_completer = 1
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)
" }}}
" ack {{{
" let g:ackpreview = 1
let g:ack_use_dispatch = 1
" }}}
" graphviz {{{
let g:WMGraphviz_output="png"
" }}}
" gitgutter {{{
let g:gitgutter_max_signs = 2500
" }}}
