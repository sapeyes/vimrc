" ------------------- "
" vim-plug 및 플러그인
" ------------------- "

" vim-plug 최초 설치
let vim_plug_just_installed = 0
if has('win32')
    let vim_plug_path = expand('~/vimfiles/autoload/plug.vim')
else
    let vim_plug_path = expand('~/.vim/autoload/plug.vim')
endif
if !filereadable(vim_plug_path)
    silent execute '!curl -fLo '.vim_plug_path.
                \' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    :execute 'source '.fnameescape(vim_plug_path)
    let vim_plug_just_installed = 1
endif

" 사용 플러그인 리스트
call plug#begin()
Plug 'davidhalter/jedi-vim'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'wkentaro/conque.vim'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'altercation/vim-colors-solarized'
Plug 'Valloric/YouCompleteMe'
Plug 'DeXP/xkb-switch-win'
call plug#end()

" 플러그인 최초 설치
if vim_plug_just_installed
    :PlugInstall
endif

set nocompatible
filetype plugin indent on


" ------------------- "
"  개별 플러그인 설정
" ------------------- "

" 1) YCM

" YCM 프로젝트 설정 (글로벌)
let g:ycm_global_ycm_extra_conf='$HOME/.vim/.ycm_extra_conf.py'

" YCM 프리뷰 윈도우 자동 사라지기 설정
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_autoclose_preview_window_after_completion=1

" 2) jedi-vim

" 파이썬 패스 설정
silent execute "py3 import os; sys.executable=os.path.join(sys.prefix, 'python.exe')"

" 자동완성 끄기
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#completions_enabled = 0
let g:jedi#completions_command = ""

" 함수 Signature 켜기
let g:jedi#show_call_signatures = "1"


" 3) Syntastic  // 문법체크(수동모드로 설정됨)
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_sign = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_mode_map = {'mode': 'passive'}
"let g:syntastic_python_checkers = ['flake8', 'python']
let g:syntastic_aggregate_errors = 1
let g:syntastic_error_symbol = 'X'
let g:syntastic_warning_symbol = 'W'
"let g:syntastic_style_warning_symbol = '?'
"let g:syntastic_style_error_symbol = 's'

"에러 표시 값 추가
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


" 3) Airline  // 상태바
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline#extensions#tabline#formatter = 'default'
"let g:airline_powerline_fonts = 1
"let g:airline_theme='solarized'
"let g:airline_solarized_bg='light'
let g:airline#extensions#tabline#fnamemod = ':t'

" 4) easymotion  // 코드 위치 지정하여 이동
"let g:EasyMotion_do_mapping = 0
"nmap <leader><leader>s <Plug>(easymotion-overwin-f)
"nmap <leader><leader>s <Plug>(easymotion-overwin-f2)
"map <leader><leader>j <Plug>(easymotion-j)
"map <leader><leader>k <Plug>(easymotion-k)


" 5) ctrlp.vim  // 검색기
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
            \'dir' : '__pycache__|dist|build',
            \'dot_dir' : '\v\.(git|hg|svn)$',
            \'file' : '\v\.(jpg|jpeg|png|bmp|exe|so|dll|toc|spec|py.|swp)$',
            \}

function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    execute ':CtrlP' . a:ctrlp_command_end
    call feedkeys(a:search_text)
endfunction


" 6) conque.vim  // vim 윈도우에서 상호작용 콘솔 프로그램 실행
function! CloseConqueTerm()
    if bufnr('python -i ') > -1
        execute 'bd '.bufnr('python -i ')
        echo 'ConqueTerm has been closed'
    else
        echo 'No ConqueTerm'
    endif
endfunction

"command! -complete=shellcmd -nargs=+ ConqueRunPy call s:RunPythonInConqueTermSplit(<q-args>)
"function! s:RunPythonInConqueTermSplit(cmdline)
"    let isfirst = 1
"    let words = []
"    for word in split(a:cmdline)
"        if isfirst
"            let isfirst = 0  " don't change first word (shell command)
"        else
"            if word[0] =~ '\v[%#<]'
"                let word = expand(word)
"            endif
"            let word = shellescape(word, 1)
"        endif
"    call add(words, word)
"    endfor
"    let expanded_cmdline = join(words)
"    echo expanded_cmdline
"    execute 'ConqueTermSplit '.expanded_cmdline
"endfunction

" 6) TagBar

" xkb-switch-win




" ------------------- "
"  vim 명령어
" ------------------- "

" 1) 쉘(도스) 명령어 결과확인 => :Shell 쉘명령 (ex > :Shell ls -alp)
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  let isfirst = 1
  let words = []
  for word in split(a:cmdline)
    if isfirst
      let isfirst = 0  " don't change first word (shell command)
    else
      if word[0] =~ '\v[%#<]'
        let word = expand(word)
      endif
      let word = shellescape(word, 1)
    endif
    call add(words, word)
  endfor
  let expanded_cmdline = join(words)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:  ' . a:cmdline)
  call setline(2, 'Expanded to:  ' . expanded_cmdline)
  call append(line('$'), substitute(getline(2), '.', '=', 'g'))
  silent execute '$read !'. expanded_cmdline
  1
endfunction


" ------------------- "
" VIM 설정
" ------------------- "

" 1) 인코딩

" Text encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set guifont=D2Coding\ ligature:h12:
"set guifont=DejaVu\ Sans\ Mono\ Powerline:h12:

" 2) 컬러 & 하이라이트

" 문법에 따른 하이라이트
syntax enable

" 색상 테마 지정하기
if (&term == "pcterm" || &term == "win32")
    silent execute '!chcp 65001'
    "set term=pcansi t_Co=256
    "set term=xterm t_Co=256
    "set mouse=a
    "let &t_AB="\e[48;5;%dm"
    "let &t_AF="\e[38;5;%dm"
    "inoremap <Char-0x07F> <BS>
    "nnoremap <Char-0x07F> <BS>
    "inoremap <Char-0x025> <LEFT>
    "nnoremap <Char-0x025> <LEFT>
    "colorscheme solarized
    "set background=dark
elseif has('gui')
    set background=dark
    colorscheme solarized
    set guioptions-=T
    set guioptions-=m
    set lines=30 columns=120
endif


" 검색어 하이라이트
set hlsearch

" 줄 번호 표기
set number

" 탭 및 잔여 빈칸 표기
set listchars=tab:>.,trail:.,extends:>,precedes:<,nbsp:~
set list


" 3) 검색 설정

" 대소문자 구분 없이 검색
set ignorecase

" 검색어에 대소문자가 섞일 경우 이를 알아서 검색
set smartcase


" 4-1) 탭 설정 (글로벌)

" 탭 사이즈 (탭의 크기를 지정된 스페이스만큼 보이게 함, 스페이스로 바꾸지는 않음)
set tabstop=4

" 들여쓰기 탭 스페이스 사이즈 (블록으로 코드줄을 선택한 뒤 키 >, < 들여쓰기 및 내어쓰기 할 경우)
set shiftwidth=4

" <BS>로 줄 가운데 공란이 있는 곳에서 빈칸을 지울경우 탭 사이즈 만큼 제거함
set softtabstop=4

" 탭 대신 스페이스 tabstop 사이즈만큼 입력합
" 기존 탭을 스페이스로 바꾸지는 않음
" 기존 <tab> -> 스페이스 바꾸려면 :retab
" 기존 <tab> -> 스페이스 커서에 위치한 해당줄만 바꾸려면 :retab.
"set expandtab

" 탭을 탭으로 입력 (기본값)
set noexpandtab

" ts, sw, sts 중 하나를 <TAB> <BS> 크기로 적절히 참고한다는데 잘 모르겠음
set smarttab

" 현재 들여쓰기를 다음줄 개행했을때 그대로 유지해줌
set ai

" ai 가 설정되어 있을때 문법에 따라 들여쓰기를 해줌
set si


" 4-2) 탭 설정 (파일 종류별)

autocmd FileType *.py set ai sw=4 ts=4 sta et fo=croql
autocmd FileType make setlocal noexpandtab
autocmd FileType *.txt setlocal noexpandtab
autocmd FileType *.md setlocal noexpandtab
autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType htmldjango setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType * set fo-=o

" 5) 기타설정

" 백스페이스로 지울 수 있는 문자 추가
set backspace=indent,eol,start

" 자동 줄바꿈 없애기
set nowrap

" 백업파일을 만들지 않음
set nobackup

" 마지막으로 수정된 곳에 커서 위치
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ endif

" 다른 파일로 넘어갈때 자동저장
set autowrite

" 다른 편집기에서 수정되었을때 자동으로 갱신
set autoread

" 히스토리 512개로 늘림
set history=512

" vim에서 복사된 것 클립보드로 넣기
set clipboard=unnamed

" ------------------- "
"  vim 조작 키 설정
" ------------------- "

" 1) 공통 단축키

" 리더키 (지연 조합키)
let mapleader = ","

" 2) .vimrc

" ,rc => .vimrc 열기
noremap <leader>rc :e ~/.vimrc<cr>

" ,src => .vimrc 를 다시 적용함
noremap <leader>rr :source ~/.vimrc<CR>

" 3) FK

" F2 => 파일 저장
inoremap <F2> <ESC><ESC>:w<CR>
noremap <F2> <ESC>:w<CR>

" F3 => 줄번호 커서위치 기준 토글
map <F3> <ESC>:set nu! relativenumber!<CR>

" F5 => 파이썬 명령 실행 (아래에 창 뜸)
map <F5> <F6>:execute 'ConqueTermSplit python -i '.expand('%').' '
imap <F5> <F6>:execute 'ConqueTermSplit python -i '.expand('%').' '
"map <F5> :ConqueRunPy python -i %
"imap <F5> :ConqueRunPy python -i %

" F6 => ConqueTerm 닫기
map <F6> <ESC>:call CloseConqueTerm()<CR>
imap <F6> <ESC>:call CloseConqueTerm()<CR>

" F12 => 문자열 끝 공백 제거
nnoremap <silent> <F12> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" 4) 버퍼조작

" ,jj  => 이전 버퍼 열기
inoremap <leader>jj <ESC><ESC>:bprevious<CR>
noremap <leader>jj <ESC>:bprevious<CR>

" ,jj  => 다음 버퍼 열기
inoremap <leader>kk <ESC><ESC>:bnext<CR>
noremap <leader>kk <ESC>:bnext<CR>

" ,bq => 버퍼 닫기
noremap <leader>bq :bd<CR>

" ,bl => 버퍼 리스트
noremap <leader>bl :ls<CR>

" 5) 편집기 관련

" <CTRL> + n => 검색된 글씨 하이라이트
noremap <c-n> :noh<CR>

" <CTRL> + u => gutter 지우기
noremap eu :sign unplace *<CR>

" jj or jk => 편집모드에서 빠져나옴
inoremap jj <ESC>
inoremap jk <ESC>

" ,q => 현재 vim 탭 종료
noremap <leader>q <ESC><ESC>:q<CR>

" 6) 윈도우 조작
noremap <leader>w- <c-w>-
noremap <leader>w_ <c-w>_
noremap <leader>w+ <c-w>+
noremap <leader>wh <c-w>h
noremap <leader>wj <c-w>j
noremap <leader>wk <c-w>k
noremap <leader>wl <c-w>l
inoremap <leader>wh <ESC><c-w>h
inoremap <leader>wj <ESC><c-w>j
inoremap <leader>wk <ESC><c-w>k
inoremap <leader>wl <ESC><c-w>l

" 7) 탭 조작
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm
map tt :tabnew
map ts :tab split<CR>

" 8) 코드 문법 확인

" eo => 문법 체크 후 오류내용 아래쪽 창으로 나옴
noremap eo :w<CR>:SyntasticCheck<CR>:lopen<CR><C-W><C-P>zz

" ec => 오류 안내 창 닫기
noremap ec :lclose<CR>

" en => 다음 오류 위치로 이동
noremap en :lnext<CR>

" en => 이전 오류 위치로 이동
noremap ep :lprev<CR>

" 9) 코드 Doc 및 정의/선언문 이동, 검색

" ,g => 소스코드 정의/선언문으로 이동(YCM)
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" ,G => 소스코드 정의/선언문으로 이동(jedi-vim)
let g:jedi#goto_command = "<leader>G"

" ,d => 소스코드 Doc 보기(YCM)
map <leader>d  :YcmCompleter GetDoc<CR>

" ,d => 소스코드 Doc 보기(jedi-vim)
let g:jedi#documentation_command = "<leader>D"

" ,U => 유사하게 작성한코드 있는지 검색하여 리스트로 보여줌
let g:jedi#usages_command = "<leader>U"

" ,U => 해당 변수 재정의
let g:jedi#rename_command = "<leader>R"

" ,ss => 파일 검색 (CtrlP)
let g:ctrlp_map = ',ss'

" ,st => 태그 검색 (CtrlP)
nnoremap <Leader>st :CtrlPBufTagAll<CR>

" ,st => 태그 검색 (CtrlP)
nnoremap <Leader>sr :CtrlPMRUFiles<CR>

" ,sl => Line 검색 (CtrlP)
nnoremap <Leader>sl :CtrlPLine<CR>

" ,sl => 해당 워드 검색 (CtrlP)
nnoremap <Leader>sw :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>

" Tagbar 토글
nnoremap ,tb :TagbarToggle<CR>

" nerdtree 토글
nnoremap ,nt :NERDTreeToggle<cr>

" 주석
vnoremap ,# :s/^/# /<cr>:noh<cr>
vnoremap ,-# :s/^# //<cr>:noh<cr>
