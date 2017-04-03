call plug#begin('~/.vim/plugged')
Plug 'Shougo/vimfiler.vim'
Plug 'tomasr/molokai'
Plug 'majutsushi/tagbar'
Plug 'sbdchd/neoformat'
Plug 'Shougo/neocomplete.vim'
Plug 'w0rp/ale'
Plug 'Shougo/unite.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-shell'
Plug 'xolox/vim-misc'
Plug 'brookhong/cscope.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-startify'
Plug 'Shougo/vimproc.vim'
Plug 'airblade/vim-gitgutter'
Plug 'lambdalisue/vim-gita'
Plug 'itchyny/vim-gitbranch'
call plug#end()

" �����ñ��������Ч
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" vimproc
let g:vimproc_dll_path=$VIMRUNTIME."/vimproc.dll"

" >>
" �������
let $LANG = 'zh_CN.UTF-8'
set langmenu=zh_CN
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,gbk,latin1
"����consle�������
language messages zh_CN.utf-8
" Set extra options when running in GUI mode
set guitablabel=%M\ %t
set linespace=2
set noimdisable

" <<

" leader
let mapleader="\<Space>"

" >>
" �ļ��������

" �����ļ��������
filetype on
" ������⵽�Ĳ�ͬ���ͼ��ض�Ӧ�Ĳ��
filetype plugin on

" <<

" >>
" vim �����ǲ������ݼ�

" ���ÿ�ݼ���ѡ���ı��鸴����ϵͳ������
vnoremap <Leader>y "+y
" ���ÿ�ݼ���ϵͳ����������ճ����vim
nmap <Leader>p "+p

" �����ݼ����浱ǰ��������
nmap <Leader>w :w<CR>
" �����ݼ��˳���ǰ��������
nmap <Leader>q :q<CR>
" �����ݼ��������д�������
nmap <Leader>W :wa<CR>

" <<

" >>
" ����

" ����ʵʱ��������
set incsearch

" ����ʱ��Сд������
set ignorecase

" �رռ���ģʽ
set nocompatible

" vim ����������ģʽ���ܲ�ȫ
set wildmenu

" ����buffer
set so=3

" ������ʾ״̬��
set laststatus=2

" ��ʾ��굱ǰλ��
set ruler

" �����к���ʾ
set number

" ������ʾ��ǰ��
set cursorline

" ������ʾ�������
set hlsearch
" <<

" >>
" Ӫ��רע����

" ��ɫ����
set background=dark
colorscheme molokai
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h14
let g:molokai_original = 1
let g:rehash256 = 1
set renderoptions=type:directx,renmode:5,taamode:1

" ��ֹ�����˸
set gcr=n-v-c:block-Cursor/lCursor-blinkon0,ve:ver35-Cursor-blinkon0,o:hor50-Cursor-blinkon0,i-ci:ver25-Cursor/lCursor-blinkon0,r-cr:hor20-Cursor/lCursor-blinkon0,sm:block-Cursor-blinkon0

" ��ֹ��ʾ������
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" ��ֹ��ʾ�˵��͹�����
set guioptions-=m
set guioptions-=T

" ȫ��
fun! ToggleFullscreen()
	call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)
endf
" ȫ����/�ؿ�ݼ�
map <silent> <F11> :call ToggleFullscreen()<CR>
" ���� vim ʱ�Զ�ȫ��
autocmd VimEnter * call ToggleFullscreen()

" <<

" �������
" >>

" startify {
let g:startify_custom_header = [
			\'                     _                        ',
			\'              __   _(_)_ __ ___               ',
			\'  ____________\ \ / / | -_ - _ \ ____________ ',
			\'  _____________\ V /| | | | | | |____________ ',
			\'                \_/ |_|_| |_| |_|             ',
			\'                                              ',
			\'                                              ',
			\]
 
let g:startify_list_order = [
           \ ['   Recent Files:'],
           \ 'files',
           \ ['   Project:'],
           \ 'dir',
           \ ['   Sessions:'],
           \ 'sessions',
           \ ['   Bookmarks:'],
           \ 'bookmarks',
           \ ['   Commands:'],
           \ 'commands',
           \ ]

let g:startify_change_to_vcs_root = 1
" }

" asyncrun {
    nnoremap <silent> <Leader>dr :call <SID>compile_and_run()<CR>
	nnoremap <silent> <Leader>ds :exec 'AsyncStop!'<CR>
    augroup SPACEVIM_ASYNCRUN
        autocmd!
        autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
    augroup END
    function! s:compile_and_run()
        exec 'w'
        if &filetype == 'c'
            exec 'AsyncRun! gcc % -o %<; ./%<'
        elseif &filetype == 'cpp'
            exec 'AsyncRun! g++ -std=c++11 % -o %<; ./%<'
        elseif &filetype == 'java'
            exec 'AsyncRun! javac %; java %<'
        elseif &filetype == 'python'
            exec 'AsyncRun! python '.shellescape(@%, 1)
        endif
    endfunction
" }

" cscope & ctags {
let g:cscope_silent = 1
nnoremap  gi :call CscopeFind('g', expand('<cword>'))<CR>
nnoremap  gd <C-]>
nnoremap <leader>fl :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>ft :call ToggleLocationList()<CR>
nnoremap  <C-g> :call CscopeFind('s', expand('<cword>'))<CR>
nnoremap  <C-n> :call CscopeFind('c', expand('<cword>'))<CR>
" }

" neocomplete {
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#enable_auto_select = 1
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"   
" }

" ale {
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_keep_list_window_open = 1
"let g:ale_open_list = 1
let g:ale_lint_on_enter = 0
let g:ale_sign_column_always = 1
let g:ale_sign_error = '*'
let g:ale_sign_warning = '~'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_statusline_format = ['E %d', 'W %d', '? ok']
highlight clear ALEErrorSign
highlight clear ALEWarningSign
nnoremap <silent> gE <Plug>(ale_previous_wrap)
nnoremap <silent> ge <Plug>(ale_next_wrap)
nnoremap <Leader>ts :ALEToggle<CR>
let g:ale_python_pylint_executable = 'pylint'
let g:ale_python_pylint_options = '-rcfile ~/pylint.rc'
let g:ale_java_javac_options = '-encoding UTF-8'
" }

" Tagbar {
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_show_linenumbers = 1
let g:tagbar_sort = 0
nmap <C-o> :TagbarToggle<CR>
" }

" vimfiler {
nnoremap <silent> <C-p> ::VimFilerExplorer -find<CR>
let g:vimfiler_as_default_explorer = 1
let g:unite_kind_file_use_trashbox = 1
call vimfiler#custom#profile('default', 'context', {
      \ 'winwidth' : 32,
	  \ 'direction' : "topleft",
	  \ 'auto-cd' : 1,
      \ })
" }

" Unite  {
call unite#custom#source('file,file/new,buffer,file_rec/async',
	\ 'matchers', 'matcher_fuzzy')
let g:unite_matcher_fuzzy_max_input_length = 5
let g:unite_source_rec_async_command =
        \ ['ag', '--follow', '--nocolor', '--nogroup',
		\  '--hidden', '-g', '']
call unite#custom#source(
		\ 'buffer', 'converters',
		\ ['converter_file_directory'])
call unite#custom#source(
        \ 'file_rec/async', 'converters',
        \ ['converter_file_directory'])
nnoremap <silent> <leader>fp :<C-u>Unite -start-insert file<CR>
nnoremap <silent> <leader>ff :<C-u>Unite -start-insert file_rec/async:!<CR>
nnoremap <silent> <leader>fr :<C-u>Unite -start-insert buffer<CR>
nnoremap <silent> <leader>fb :<C-u>Unite bookmark<CR>
nnoremap <silent> <leader>fc :<C-u>UniteWithCurrentDir<CR>
" }

" UltiSnips {
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsEditSplit="vertical"
nmap <C-o> :TagbarToggle<CR>
" }

" commentary {
" vmap <C-/> gc
" }

" git {
nnoremap <Leader> gc :Gita commit
nnoremap <Leader> gf :Gita chaperone
" }

" airline {
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s:'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#fnametruncate = 0
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#default#section_truncate_width = {
            \ 'b': 79,
            \ 'x': 60,
            \ 'y': 88,
            \ 'z': 45,
            \ 'warning': 80,
            \ 'error': 80,
            \ }
let g:airline#extensions#default#layout = [
            \ [ 'a', 'error', 'warning', 'b', 'c' ],
            \ [ 'x', 'y', 'z' ]
            \ ]
" }
" <<
