
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
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
Plug 'vim-airline/vim-airline'
"" Color
Plug 'tomasr/molokai'
" Gruvbox theme.
Plug 'gruvbox-community/gruvbox'
Plug 'junegunn/limelight.vim'
"let g:limelight_conceal_ctermfg = 'gray'
"let g:limelight_conceal_ctermfg = 240

Plug 'junegunn/goyo.vim'
" If you don't have nodejs and yarn
" use pre build
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
"let g:mkdp_auto_start = 1

"Plug 'plasticboy/vim-markdown'
"let g:vim_markdown_folding_disabled = 1

"if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
"  Plug 'Shougo/deoplete.nvim'
"  Plug 'roxma/nvim-yarp'
"  Plug 'roxma/vim-hug-neovim-rpc'
"endif
let g:deoplete#enable_at_startup = 1

"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
"Plug 'ncm2/ncm2-jedi'
"set completeopt=noinsert,menuone,noselect

"Plug 'roxma/nvim-completion-manager'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
"let g:ncm2_jedi#python_version = 3
Plug 'davidhalter/jedi-vim'
"let g:jedi#popup_on_dot = 0
"let g:jedi#popup_select_first = 0
"let g:jedi#show_call_signatures = "0"
let g:jedi#completions_enabled = 0
Plug 'vim-pandoc/vim-pandoc'
let g:pandoc#modules#disabled = ['folding']
let g:pandoc#biblio#sources = "g"
let g:pandoc#biblio#bibs = ['/home/guest/stuff/myreseach.bib']
Plug 'kana/vim-fakeclip' "to get +clipboard functionality"
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

"set clipboard=unnamedplus "requires +clipboard 
set mouse-=a  "disable automatic visual mode on mouse select
"save backup files ending with ~ to a different location
set backupdir-=.
set backupdir=~/tmp,/tmp
set undodir-=.
set undodir=~/tmp,/tmp
" }
