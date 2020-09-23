
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" vim-bootstrap

"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
let vimplug_exists=expand('~/.local/share/nvim/site/autoload/plug.vim')

let g:vim_bootstrap_langs = "python"
let g:vim_bootstrap_editor = "vim"				" nvim or vim

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif


" Required:
call plug#begin(expand('~/.vim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'vim-pandoc/vim-pandoc'
let g:pandoc#modules#disabled = ['folding']
""let g:pandoc#biblio#sources = "g"
""let g:pandoc#biblio#bibs = ['/home/guest/stuff/myreseach.bib']
let g:pandoc#spell#enabled = 0
Plug 'lervag/vimtex'
let g:tex_flavor = 'latex'
Plug 'preservim/nerdcommenter'
Plug 'bling/vim-airline'
Plug 'chrisbra/csv.vim'
Plug 'junegunn/limelight.vim'
let g:limelight_conceal_ctermfg = 'gray'
"let g:limelight_conceal_ctermfg = 240
Plug 'junegunn/goyo.vim'
" enable autocompletion in vim
" pynvim needs to be installed
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" A bunch of useful language related snippets (ultisnips is the engine).
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'vimwiki/vimwiki'
"Plug 'xuhdev/vim-latex-live-preview'
" If you don't have nodejs and yarn
" use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
" see: https://github.com/iamcco/markdown-preview.nvim/issues/50
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
"Plug 'lifepillar/vim-solarized8'
call plug#end()

" -----------------------------------------------------------------------------
" Color settings
" -----------------------------------------------------------------------------
"colors pyte
"colorscheme gruvbox
"colorscheme pyte
" Gruvbox comes with both a dark and light theme.
"set background=dark
" This needs to come last, otherwise the colors aren't correct.
syntax on

" -----------------------------------------------------------------------------
" Basic Settings
"   Research any of these by running :help <setting>
" -----------------------------------------------------------------------------

" Vim UI {
    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode
    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:>-,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
" }



" Formatting {
"    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
"    set expandtab                   " Tabs are spaces, not tabs
"    set tabstop=4                   " An indentation every four columns
"    set softtabstop=4               " Let backspace delete indent
" }

" custom-mods {

" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"--------------------Work with encrypted files in vim---------------------------
" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff
augroup encrypted
  au!

  " First make sure nothing is written to ~/.viminfo while editing
  " an encrypted file.
  autocmd BufReadPre,FileReadPre *.gpg set viminfo=
  " We don't want a various options which write unencrypted data to disk
  autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup

  " Switch to binary mode to read the encrypted file
  autocmd BufReadPre,FileReadPre *.gpg set bin
  autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg2 --decrypt 2> /dev/null

  " Switch to normal mode for editing
  autocmd BufReadPost,FileReadPost *.gpg set nobin
  autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

  " Convert all text to encrypted text before writing
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg2 --default-recipient-self -ae 2>/dev/null
  " Undo the encryption so we are back in the normal text, directly
  " after the file has been written.
  autocmd BufWritePost,FileWritePost *.gpg u
augroup END

set clipboard=unnamedplus "requires +clipboard
"Enable using the mouse for moving cursor and visual select
set mouse=a
"set mouse-=a  "disable automatic visual mode on mouse select
"save backup files ending with ~ to a different location
set backupdir-=.
set backupdir=~/tmp,/tmp
set undodir-=.
set undodir=~/tmp,/tmp

"function to change case of visual block
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv
"
nnoremap <F5> "=strftime("%a %d %b %Y")<CR>P
inoremap <F5> <C-R>=strftime("%a %d %b %Y")<CR>
nnoremap <F5> :VimtexCompile<CR>
autocmd FileType python compiler pylint
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
vnoremap <f5> :redirect(current.window.buffer) !python<CR>

" Always use the same virtualenv for vim, regardless of what Python
" environment is loaded in the shell from which vim is launched
"let g:vim_virtualenv_path = '/home/guest/snakes'
"if exists('g:vim_virtualenv_path')
    "pythonx import os; import vim
    "pythonx activate_this = os.path.join(vim.eval('g:vim_virtualenv_path'), 'bin/activate_this.py')
    "pythonx with open(activate_this) as f: exec(f.read(), {'__file__': activate_this})
"endif
"
"
"

" This is new style
"call deoplete#custom#var('omni', 'input_patterns', {
      "\ 'tex': g:vimtex#re#deoplete
      "\})
"}
"

set number relativenumber
set nohlsearch
" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %
" Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>
" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritepre * %s/\n\+\%$//e
" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>g :setlocal spell! spelllang=en_us<CR>
" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set bg=light \| set linebreak<CR>
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


"hi clear SpellBad
hi SpellBad ctermbg=darkred ctermfg=white
" Set style for gVim
hi SpellBad gui=undercurl
set tags=./tags;,tags;./.tags;,.tags; "set ctags to custom hidden file"
set undofile "Save undos after file closes
noremap S :%s//g<Left><Left>
set spellfile=$HOME/Dropbox/vim-spell/en.utf-8.add

map <C-n> :NERDTreeToggle<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

    " NerdTree {
	    let NERDTreeShowBookmarks=1
	    let NERDTreeMouseMode=2
	    "let NERDTreeShowHidden=1
    " }
iabbrev *** •
iabbrev +++ ▸
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/','path_html':'~/vimwiki_html/',
	    \ 'syntax': 'markdown', 'ext': '.md'}]
