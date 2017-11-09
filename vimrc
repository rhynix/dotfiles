let s:current_script_path = expand('<sfile>:p')

if exists('*minpac#init')
  call minpac#init()
  call minpac#add('git@github.com:sheerun/vim-polyglot.git')
  call minpac#add('git@gitlab.com:protesilaos/tempus-themes-vim.git')
endif

packloadall

colorscheme tempus_totus

set termguicolors
set number relativenumber
set cc=80
set hidden
set nohlsearch
set expandtab shiftwidth=2
set undofile
set grepprg=rg\ --vimgrep\ --no-heading
set list

let g:netrw_nammer = 0

autocmd FileType gitcommit setlocal spell cc=72
autocmd FileType text setlocal textwidth=78
autocmd FileType javascriptreact setlocal syntax=javascript

function! FormatFile()
  let view = winsaveview()
  keepjumps normal! gggqG
  call winrestview(view)
endfunction

if !exists("*s:InitMinPac")
  function! s:InitMinPac()
    packadd minpac
    execute ":source " . s:current_script_path
  endfunction
endif

command! PackUpdate call s:InitMinPac() | call minpac#update()
command! PackClean  call s:InitMinPac() | call minpac#clean()
command! PackStatus call s:InitMinPac() | call minpac#status()
