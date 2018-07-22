" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:
"
"          _                                _
"         | |                       __   __(_)_ __ ___
"      _ _| |  _    _   _ _    ____ \ \ / /| | '_ ` _ \
"     | |_| | | |  | | |  _ \ |____| \ V / | | | | | | |
"     | |___| \_|__|_/ | |_) |        \_/  |_|_| |_| |_|
"                      | ._ /
"                      |_|
"
"   You can find me at https://github.com/lovedianer/vim
" }

" Environment {

    " Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win32') || has('win64'))
        endfunction
    " }

    " Basics {
        set nocompatible        " Must be first line
        if !WINDOWS()
            set shell=/bin/sh
        endif
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if WINDOWS()
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }

    " Arrow Key Fix {
        if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
            inoremap <silent> <C-[>OC <RIGHT>
        endif
    " }

    " Select platform {
        let g:iswindows = 0
        let g:islinux = 0
        if (has("win32") || has("win64"))
            let g:iswindows = 1
        else
            let g:islinux = 1
        endif
    " }

    " Select terminal {
        if has("gui_running")
            let g:isGUI = 1
        else
            let g:isGUI = 0
        endif
    " }

" }

" Vundle {

    " git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

    set nocompatible              " be iMproved, required(禁用Vi兼容模式)
    filetype off                  " required(禁用文件类型侦测)

    if g:islinux
        set rtp+=~/.vim/bundle/Vundle.vim
        call vundle#begin()
    else
        set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
        call vundle#begin('$VIM/vimfiles/bundle/')
    endif

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    " Keep Plugin commands between vundle#begin/end.

    " My Plugins {
        " list only the plugin groups you will use
        if !exists('g:dup_vundle_groups')
            let g:dup_vundle_groups=['general', 'writing', 'programming', 'OmniCppComplete', 'java', 'python', 'php', 'javascript', 'html', 'repo', 'misc',]
        endif

        " General {
            if count(g:dup_vundle_groups, 'general')
                Plugin 'scrooloose/nerdtree'
                Plugin 'ctrlpvim/ctrlp.vim'
                Plugin 'bufexplorer.zip'
                Plugin 'minibufexpl.vim'
                Plugin 'vim-scripts/sessionman.vim'
                Plugin 'terryma/vim-multiple-cursors'
                Plugin 'tpope/vim-surround'
                Plugin 'tpope/vim-repeat'
                Plugin 'jiangmiao/auto-pairs'
                Plugin 'matchit.zip'
                Plugin 'easymotion/vim-easymotion'
                Plugin 'altercation/vim-colors-solarized'
                Plugin 'spf13/vim-colors'
                if (has("python") || has("python3")) && exists('g:dup_use_powerline') && !exists('g:dup_use_old_powerline')
                    Plugin 'Lokaltog/powerline', {'rtp':'/powerline/bindings/vim'}
                elseif exists('g:dup_use_powerline') && exists('g:dup_use_old_powerline')
                    Plugin 'Lokaltog/vim-powerline'
                else
                    Plugin 'vim-airline/vim-airline'
                    Plugin 'vim-airline/vim-airline-themes'
                endif
                Plugin 'bling/vim-bufferline'
                Plugin 'powerline/fonts'
                Plugin 'flazz/vim-colorschemes'
                Plugin 'nathanaelkane/vim-indent-guides'
                Plugin 'kana/vim-textobj-user'
                Plugin 'kana/vim-textobj-indent'
            endif
        " }

        " Writing {
            if count(g:dup_vundle_groups, 'writing')
                Plugin 'reedes/vim-litecorrect'
                Plugin 'reedes/vim-textobj-sentence'
                Plugin 'reedes/vim-textobj-quote'
                Plugin 'reedes/vim-wordy'
            endif
        " }

        " General Programming {
            if count(g:dup_vundle_groups, 'programming')
                " Pick one of the checksyntax, jslint, or syntastic
                "Plugin 'scrooloose/syntastic'
                Plugin 'mattn/webapi-vim'
                Plugin 'mattn/gist-vim'
                Plugin 'scrooloose/nerdcommenter'
                Plugin 'tpope/vim-commentary'
                Plugin 'godlygeek/tabular'
                Plugin 'luochen1990/rainbow'
                if executable('ctags')
                    Plugin 'majutsushi/tagbar'
                    Plugin 'taglist.vim'
                endif
            endif
        " }

        " Snippets & AutoComplete {
            if count(g:dup_vundle_groups, 'snipmate')
                Plugin 'garbas/vim-snipmate'
                Plugin 'honza/vim-snippets'
                " Source support_function.vim to support vim-snippets.
                if filereadable(expand("~/.vim/bundle/vim-snippets/snippets/support_functions.vim"))
                    source ~/.vim/bundle/vim-snippets/snippets/support_functions.vim
                endif
            elseif count(g:dup_vundle_groups, 'youcompleteme')
                Plugin 'Valloric/YouCompleteMe'
                Plugin 'SirVer/ultisnips'
                Plugin 'honza/vim-snippets'
            elseif count(g:dup_vundle_groups, 'neocomplcache')
                Plugin 'Shougo/neocomplcache'
                Plugin 'Shougo/neosnippet'
                Plugin 'Shougo/neosnippet-snippets'
                Plugin 'honza/vim-snippets'
            elseif count(g:dup_vundle_groups, 'neocomplete')
                Plugin 'Shougo/neocomplete.vim.git'
                Plugin 'Shougo/neosnippet'
                Plugin 'Shougo/neosnippet-snippets'
                Plugin 'honza/vim-snippets'
            elseif count(g:dup_vundle_groups, 'OmniCppComplete')
                Plugin 'OmniCppComplete'
            endif
        " }

        " Java {
            if count(g:dup_vundle_groups, 'java')
                Plugin 'artur-shaik/vim-javacomplete2'  "needs vim version>=7.4.143 & JDK8+
            endif
        " }

        " Python {
            if count(g:dup_vundle_groups, 'python')
                " Pick either python-mode or pyflakes & pydoc
                "Plugin 'klen/python-mode'  " cause INSERT MODE:cursor error
                Plugin 'yssource/python.vim'
                Plugin 'python_match.vim'
                Plugin 'pythoncomplete'
            endif
        " }

        " Go Lang {
            if count(g:dup_vundle_groups, 'go')
                Plugin 'fatih/vim-go'
            endif
        " }

        " PHP {
            if count(g:dup_vundle_groups, 'php')
                Plugin 'spf13/PIV'
                Plugin 'arnaud-lb/vim-php-namespace'
                Plugin 'beyondwords/vim-twig'
            endif
        " }

        " Javascript {
            if count(g:dup_vundle_groups, 'javascript')
                Plugin 'elzr/vim-json'
                Plugin 'groenewege/vim-less'
                Plugin 'pangloss/vim-javascript'
                Plugin 'briancollins/vim-jst'
                Plugin 'kchmck/vim-coffee-script'
            endif
        " }

        " HTML {
            if count(g:dup_vundle_groups, 'html')
                "Plugin 'amirh/HTML-AutoCloseTag'   " Download fail
                Plugin 'hail2u/vim-css3-syntax'
                Plugin 'gorodinskiy/vim-coloresque'
                Plugin 'tpope/vim-haml'
                Plugin 'mattn/emmet-vim'
            endif
        " }

        " Scala {
            if count(g:dup_vundle_groups, 'scala')
                Plugin 'derekwyatt/vim-scala'
                Plugin 'derekwyatt/vim-sbt'
                Plugin 'xptemplate'
            endif
        " }

        " Haskell {
            if count(g:dup_vundle_groups, 'haskell')
                Plugin 'travitch/hasksyn'
                Plugin 'dag/vim2hs'
                Plugin 'Twinside/vim-haskellConceal'
                Plugin 'Twinside/vim-haskellFold'
                Plugin 'lukerandall/haskellmode-vim'
                Plugin 'eagletmt/neco-ghc'
                Plugin 'eagletmt/ghcmod-vim'
                Plugin 'Shougo/vimproc.vim'
                Plugin 'adinapoli/cumino'
                Plugin 'bitc/vim-hdevtools'
            endif
        " }

        " Ruby {
            if count(g:dup_vundle_groups, 'ruby')
                Plugin 'tpope/vim-rails'
                let g:rubycomplete_buffer_loading = 1
                "let g:rubycomplete_classes_in_global = 1
                "let g:rubycomplete_rails = 1
            endif
        " }

        " Repo {
            if count(g:dup_vundle_groups, 'repo')
                Plugin 'vcscommand.vim'
                Plugin 'tpope/vim-fugitive'
                Plugin 'mhinz/vim-signify'
            endif
        " }

        " Misc {
            if count(g:dup_vundle_groups, 'misc')
                Plugin 'rust-lang/rust.vim'
                Plugin 'tpope/vim-markdown'
                Plugin 'spf13/vim-preview'
                Plugin 'tpope/vim-cucumber'
                Plugin 'cespare/vim-toml'
                Plugin 'quentindecock/vim-cucumber-align-pipes'
                Plugin 'saltstack/salt-vim'
            endif
        " }

    " }

    " All of your Plugins must be added before the following line
    call vundle#end()            " required
    filetype plugin indent on    " required
    " To ignore plugin indent changes, instead use:
    "filetype plugin on

    " Brief help
    " :PluginList       - lists configured plugins
    " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
    " :PluginSearch foo - searches for foo; append `!` to refresh local cache
    " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
    " see :h vundle for more details or wiki for FAQ

    " Install Plugins:
    " Launch vim and run :PluginInstall
    " To install from command line: vim +PluginInstall +qall

" }

" General {

    set background=dark             " Assume a dark background

    " Allow to trigger background
    function! ToggleBG()
        let s:tbg = &background
        " Inversion
        if s:tbg == "dark"
            set background=light
        else
            set background=dark
        endif
    endfunction
    noremap <leader>bg :call ToggleBG()<CR>

    " 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
    set encoding=utf-8                                    "设置gvim内部编码，默认不更改
    set fileencoding=utf-8                                "设置当前文件编码，可以更改，如：gbk（同cp936）
    set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "设置支持打开的文件的编码

    " 文件格式，默认 ffs=dos,unix
    set fileformat=unix                                   "设置新（当前）文件的<EOL>格式，可以更改，如：dos（windows系统常用）
    set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型

    if (g:iswindows && g:isGUI)
        "解决菜单乱码
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        "解决consle输出乱码
        language messages zh_CN.utf-8
    endif

    filetype plugin indent on       " Automatically detect file types.
    syntax on                       " Syntax highlighting
    "set mouse=a                    " Automatically enable mouse usage
    set mousehide                   " Hide the mouse cursor while typing
    scriptencoding utf-8

    "set expandtab                  " 将Tab键转换为空格
    set smarttab                    " 指定按一次backspace就删除shiftwidth宽度
    set textwidth=78

    set autoread                    " Set to auto read when a file is changed from the outside
    "set autowrite                  " Automatically write a file when leaving a modified buffer

    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    "set spell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator

    "set writebackup                    " 保存文件前建立备份，保存成功后删除该备份
    "set nobackup                       " 设置无备份文件
    "set noswapfile                     " 设置无临时文件
    "set vb t_vb=                       " 关闭提示音

    " Code fold {
        "set foldenable                 " 启用折叠
        set foldmethod=indent           " indent 折叠方式
        "set foldmethod=marker          " marker 折叠方式
        "set foldmethod=syntax
        set foldlevel=100               " Don't autofold anything (but I can still fold manually)
        "set foldopen-=search           " don't open folds when you search into them
        "set foldopen-=undo             " don't open folds when you undo stuff
        "set foldcolumn=4
    " }

" }

" Vim UI {

    if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
        let g:solarized_termcolors=256
        let g:solarized_termtrans=1
        let g:solarized_contrast="normal"
        let g:solarized_visibility="normal"
        colorscheme solarized                         " Load a colorscheme"
    endif

    " 设置代码配色方案
    if g:isGUI
        colorscheme Tomorrow-Night-Eighties     " Gvim配色方案
    else
        colorscheme desert                      " 终端配色方案
    endif

    set guifont=Courier\ New:h10
    "set guifont=consolas
    "set guifont=YaHei_Consolas_Hybrid:h10      " 设置字体:字号（字体名称空格用下划线代替）

    " 显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
    if g:isGUI
        set guioptions-=m
        set guioptions-=T
        set guioptions-=r
        set guioptions-=L
        nmap <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
            \set guioptions-=m <Bar>
            \set guioptions-=T <Bar>
            \set guioptions-=r <Bar>
            \set guioptions-=L <Bar>
        \else <Bar>
            \set guioptions+=m <Bar>
            \set guioptions+=T <Bar>
            \set guioptions+=r <Bar>
            \set guioptions+=L <Bar>
        \endif<CR>
    endif

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode
    set cursorline                  " Highlight current line
    "set cmdheight=2                " 设置命令行的高度为2，默认为1

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    "highlight clear CursorLineNr    " Remove highlight color from current line number

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=%{fugitive#statusline()} " Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    "set noincsearch                " 在输入要搜索的文字时，取消实时匹配
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    "set noignorecase               " 搜索模式里匹配大小写
    set smartcase                   " 如果搜索模式包含大写字符，不使用 'ignorecase' 选项，只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" }

" Formatting {

    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    "set splitbelow                  " Puts new split windows to the bottom of the current
    "set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    " To disable the stripping of whitespace, add the following:
    let g:dup_keep_trailing_whitespace = 1
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> if !exists('g:dup_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
    "autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    " preceding line best in a plugin but here for now.

    autocmd BufNewFile,BufRead *.coffee set filetype=coffee

    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell,rust setlocal nospell

" }

" Key (re)Mappings {

    " The default leader is '\', but many people prefer ',' as it's in a standard
    " location. To override this behavior and set it back to '\' (or any other
    " character)
    " let mapleader=','

    " Ctrl + K 插入模式下光标向上移动
    imap <C-k> <Up>
    " Ctrl + J 插入模式下光标向下移动
    imap <C-j> <Down>
    " Ctrl + H 插入模式下光标向左移动
    imap <C-h> <Left>
    " Ctrl + L 插入模式下光标向右移动
    imap <C-l> <Right>

    " 常规模式下输入 \cS 清除行尾空格
    nmap <leader>cS :%s/\s\+$//g<CR>:noh<CR>
    " 常规模式下输入 \cM 清除行尾 ^M(Windows换行符\r\n，*nix系统换行符是\n) 符号
    nmap <leader>cM :%s/\r//g<CR>:noh<CR>

    " Change Working Directory to that of the current file
    "cmap cwd lcd %:p:h
    "cmap cd. lcd %:p:h

    " For when you forget to sudo.. Really Write the file.
    "cmap w!! w !sudo tee % >/dev/null

" }

" Plugins Settings {

    " TextObj Sentence {
        if count(g:dup_vundle_groups, 'writing')
            augroup textobj_sentence
                autocmd!
                autocmd FileType markdown call textobj#sentence#init()
                autocmd FileType textile call textobj#sentence#init()
                autocmd FileType text call textobj#sentence#init()
            augroup END
        endif
    " }

    " TextObj Quote {
        if count(g:dup_vundle_groups, 'writing')
            augroup textobj_quote
                autocmd!
                autocmd FileType markdown call textobj#quote#init()
                autocmd FileType textile call textobj#quote#init()
                autocmd FileType text call textobj#quote#init({'educate': 0})
            augroup END
        endif
    " }

    " Ctags {
        set tags=./tags;
        " Make tags placed in .git/tags file available in all levels of a repository
        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot != ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif
    " }

    " cscope {
        " 用Cscope自己的话说 - "你可以把它当做是超过频的ctags"
        if has("cscope")
            " 设定可以使用 quickfix 窗口来查看 cscope 结果
            set cscopequickfix=s-,c-,d-,i-,t-,e-
            " 使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳转
            set cscopetag
            " 如果你想反向搜索顺序设置为1
            set csto=0
            " 在当前目录中添加任何数据库
            " 注释掉(vim启动提示错误：重复的 cscope 数据库未被加入) ++
            " 原因是：/etc/vimrc 中已经有如下定义
            " if filereadable("cscope.out")
            "    cs add cscope.out
            " 否则添加数据库环境中所指出的
            " elseif $CSCOPE_DB != ""
            "    cs add $CSCOPE_DB
            " endif
            " 注释掉(vim启动提示错误：重复的 cscope 数据库未被加入) --

            " add for autoload cscope +++
            function! LoadCscope()
                let db = findfile("cscope.out", ".;")
                if (!empty(db))
                let path = strpart(db, 0, match(db, "/cscope.out$"))
                set nocscopeverbose " suppress 'duplicate connection' error
                exe "cs add " . db . " " . path
                set cscopeverbose
                endif
                endfunction
            au BufEnter /* call LoadCscope()
            " add for autoload cscope ---

            set cscopeverbose
            " 快捷键设置
            " s: 查找本 C 符号
            nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
            " g: 查找本定义
            nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
            " c: 查找调用本函数的函数
            nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
            " t: 查找对其的赋值
            nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
            " e: 查找本 egrep 模式
            nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
            " f: 查找本文件
            nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
            " i: 查找包含本文件的文件
            nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
            " d: 查找本函数调用的函数
            nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

            " 在.bashrc中增加如下定义，这样：在终端的任何目录下，输入"haha"就可以生成ctags&cscope
            "alias haha='ctags_cscope_func'
            "ctags_cscope_func() {
                "ctags -R --c++-kinds=+px --fields=+aiKSz --extra=+q .
                "find . -name "*.h" -o -name "*.hh" -o -name "*.hpp" -o -name "*.hxx" -o -name "*.c" -o -name "*.cc" -o -name "*.cpp" -o -name "*.cxx" -o -name "*.java" > cscope.files
                "cscope -Rbq -i cscope.files
                "rm -rf cscope.files
            "}
        endif
    " }

    " NerdTree {
        if isdirectory(expand("~/.vim/bundle/nerdtree"))
        " 有目录村结构的文件浏览插件
        "map <C-n> :NERDTreeToggle<CR>
        map <C-e> :NERDTreeToggle<CR>
        nmap <leader>nt :NERDTreeFind<CR>
        " 将 NERDTree 的窗口设置在 vim 窗口的右侧（默认为左侧）
        let NERDTreeWinPos="right"
        " 当打开 NERDTree 窗口时，自动显示 Bookmarks
        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
        let g:NERDTreeDirArrowExpandable = '+'
        let g:NERDTreeDirArrowCollapsible = '-'
        let g:nerdtree_tabs_open_on_gui_startup=0
        endif
    " }

    " ctrlp {
        if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
            let g:ctrlp_map = '<c-p>'
            let g:ctrlp_cmd = 'CtrlP'
            let g:ctrlp_working_path_mode = 'rw'
            let g:ctrlp_root_markers = ['tags', 'cscope.out']
            "let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
            let g:ctrlp_custom_ignore = {
                \ 'dir':  '\v[\/]\.(git|hg|svn)$',
                \ 'file': '\v\.(exe|so|dll)$',
                \ 'link': 'some_bad_symbolic_links',
                \ }
        endif
    " }

    " TagBar {
        if isdirectory(expand("~/.vim/bundle/tagbar/"))
            nmap <leader>tb :TlistClose<CR>:TagbarToggle<CR>
            let g:tagbar_width=30                       " 设置窗口宽度
            let g:tagbar_left=1                         " 在左侧窗口中显示
        endif
    " }

    " TagList {
        if isdirectory(expand("~/.vim/bundle/taglist.vim/"))
            nmap <leader>tl :TagbarClose<CR>:Tlist<CR>
            let Tlist_Ctags_Cmd = '/usr/bin/ctags'
            let Tlist_Show_One_File=1                   " 只显示当前文件的tags
            let Tlist_Auto_Update=1                     " Automatically update the taglist to include newly edited files.
            let Tlist_File_Fold_Auto_Close=1            " 非当前文件，函数列表折叠隐藏
            "let Tlist_Enable_Fold_Column=0             " 使taglist插件不显示左边的折叠行
            let Tlist_Exit_OnlyWindow=1                 " 如果Taglist窗口是最后一个窗口则退出Vim
            "let Tlist_File_Fold_Auto_Close=1           " 自动折叠
            let Tlist_Show_Menu=1                       " 显示taglist菜单
            "let Tlist_Auto_Open=1                      " 启动vim自动打开taglist
            "let Tlist_WinWidth=30                      " 设置窗口宽度
            "let Tlist_Use_Right_Window=1               " 把taglist窗口放在屏幕的右侧，缺省在左侧
        endif
    " }

    " minibufexpl {
        if isdirectory(expand("~/.vim/bundle/minibufexpl.vim/"))
            " 快速浏览和操作Buffer
            " 主要用于同时打开多个文件并相与切换
            " let g:miniBufExplMapWindowNavArrows = 1   " 用Ctrl加方向键切换到上下左右的窗口中去
            let g:miniBufExplMapWindowNavVim = 1        " 用<C-k,j,h,l>切换到上下左右的窗口中去
            let g:miniBufExplMapCTabSwitchBufs = 1      " 功能增强（不过好像只有在Windows中才有用）
            " <C-Tab> 向前循环切换到每个buffer上,并在但前窗口打开
            " <C-S-Tab> 向后循环切换到每个buffer上,并在当前窗口打开
            " 在不使用 MiniBufExplorer 插件时也可用<C-k,j,h,l>切换到上下左右的窗口中去
            noremap <c-k> <c-w>k
            noremap <c-j> <c-w>j
            noremap <c-h> <c-w>h
            noremap <c-l> <c-w>l
            " 快捷键 mb 打开或关闭 MiniBufExplorer
            nmap mb :TMiniBufExplorer<CR>
        endif
    " }

    " indent_guides {
        if isdirectory(expand("~/.vim/bundle/vim-indent-guides/"))
            " The default mapping to toggle the plugin is <Leader>ig
            let g:indent_guides_enable_on_vim_startup = 0
            let g:indent_guides_start_level = 2
            let g:indent_guides_guide_size = 1

            " Setting custom indent colors
            " Here's an example of how to define custom colors instead of
            " using the ones the plugin automatically generates for you.
            let g:indent_guides_auto_colors = 0
            autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
            autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

            " Terminal Vim
            " When set background=dark is used, the following highlight colors will be defined:
            "hi IndentGuidesOdd  ctermbg=black
            "hi IndentGuidesEven ctermbg=darkgrey
            " Alternatively, when set background=light is used, the following highlight colors will be defined:
            "hi IndentGuidesOdd  ctermbg=white
            "hi IndentGuidesEven ctermbg=lightgrey
        endif
    " }

    " vim-airline {
        " Set configuration options for the statusline plugin vim-airline.
        " Use the powerline theme and optionally enable powerline symbols.
        " To use the symbols , , , , , , and .in the statusline
        " segments add the following to your .vimrc file:
        "let g:airline_powerline_fonts=1
        " If the previous symbols do not render for you then install a
        " powerline enabled font.

        " See `:echo g:airline_theme_map` for some more choices
        " Default in terminal vim is 'dark'
        if isdirectory(expand("~/.vim/bundle/vim-airline-themes/"))
            if !exists('g:airline_theme')
                let g:airline_theme = 'solarized'
            endif
            if !exists('g:airline_powerline_fonts')
                " Use the default set of separators with a few customizations
                let g:airline_left_sep='›'  " Slightly fancier than '>'
                let g:airline_right_sep='‹' " Slightly fancier than '<'
            endif
        endif
    " }

    " OmniComplete {
        " To disable omni complete, add the following:
        " let g:dup_no_omni_complete = 1
        if !exists('g:dup_no_omni_complete')
            if has("autocmd") && exists("+omnifunc")
                autocmd Filetype *
                    \if &omnifunc == "" |
                    \setlocal omnifunc=syntaxcomplete#Complete |
                    \endif
            endif

            hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
            hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
            hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

            " Some convenient mappings
            "inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
            if exists('g:dup_map_cr_omni_complete')
                inoremap <expr> <CR>     pumvisible() ? "\<C-y>" : "\<CR>"
            endif
            inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
            inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
            inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
            inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

            " Automatically open and close the popup menu / preview window
            au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
            set completeopt=menu,preview,longest
        endif
    " }

    " YouCompleteMe {
        if count(g:dup_vundle_groups, 'youcompleteme')
            let g:acp_enableAtStartup = 0

            " enable completion from tags
            let g:ycm_collect_identifiers_from_tags_files = 1

            " remap Ultisnips for compatibility for YCM
            let g:UltiSnipsExpandTrigger = '<C-j>'
            let g:UltiSnipsJumpForwardTrigger = '<C-j>'
            let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

            " Enable omni completion.
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

            " Haskell post write lint and check with ghcmod
            " $ `cabal install ghcmod` if missing and ensure
            " ~/.cabal/bin is in your $PATH.
            if !executable("ghcmod")
                autocmd BufWritePost *.hs GhcModCheckAndLintAsync
            endif

            " For snippet_complete marker.
            if !exists("g:dup_no_conceal")
                if has('conceal')
                    set conceallevel=2 concealcursor=i
                endif
            endif

            " Disable the neosnippet preview candidate window
            " When enabled, there can be too much visual noise
            " especially when splits are used.
            set completeopt-=preview
        endif
    " }

    " neocomplete {
        if count(g:dup_vundle_groups, 'neocomplete')
            let g:acp_enableAtStartup = 0
            let g:neocomplete#enable_at_startup = 1
            let g:neocomplete#enable_smart_case = 1
            let g:neocomplete#enable_auto_delimiter = 1
            let g:neocomplete#max_list = 15
            let g:neocomplete#force_overwrite_completefunc = 1


            " Define dictionary.
            let g:neocomplete#sources#dictionary#dictionaries = {
                        \ 'default' : '',
                        \ 'vimshell' : $HOME.'/.vimshell_hist',
                        \ 'scheme' : $HOME.'/.gosh_completions'
                        \ }

            " Define keyword.
            if !exists('g:neocomplete#keyword_patterns')
                let g:neocomplete#keyword_patterns = {}
            endif
            let g:neocomplete#keyword_patterns['default'] = '\h\w*'

            " Plugin key-mappings {
                " These two lines conflict with the default digraph mapping of <C-K>
                if !exists('g:dup_no_neosnippet_expand')
                    imap <C-k> <Plug>(neosnippet_expand_or_jump)
                    smap <C-k> <Plug>(neosnippet_expand_or_jump)
                endif
                if exists('g:dup_noninvasive_completion')
                    inoremap <CR> <CR>
                    " <ESC> takes you out of insert mode
                    inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
                    " <CR> accepts first, then sends the <CR>
                    inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
                    " <Down> and <Up> cycle like <Tab> and <S-Tab>
                    inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
                    inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
                    " Jump up and down the list
                    inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
                    inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
                else
                    " <C-k> Complete Snippet
                    " <C-k> Jump to next snippet point
                    imap <silent><expr><C-k> neosnippet#expandable() ?
                                \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                                \ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
                    smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

                    inoremap <expr><C-g> neocomplete#undo_completion()
                    inoremap <expr><C-l> neocomplete#complete_common_string()
                    "inoremap <expr><CR> neocomplete#complete_common_string()

                    " <CR>: close popup
                    " <s-CR>: close popup and save indent.
                    inoremap <expr><s-CR> pumvisible() ? neocomplete#smart_close_popup()."\<CR>" : "\<CR>"

                    function! CleverCr()
                        if pumvisible()
                            if neosnippet#expandable()
                                let exp = "\<Plug>(neosnippet_expand)"
                                return exp . neocomplete#smart_close_popup()
                            else
                                return neocomplete#smart_close_popup()
                            endif
                        else
                            return "\<CR>"
                        endif
                    endfunction

                    " <CR> close popup and save indent or expand snippet
                    imap <expr> <CR> CleverCr()
                    " <C-h>, <BS>: close popup and delete backword char.
                    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
                    inoremap <expr><C-y> neocomplete#smart_close_popup()
                endif
                " <TAB>: completion.
                inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
                inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

                " Courtesy of Matteo Cavalleri

                function! CleverTab()
                    if pumvisible()
                        return "\<C-n>"
                    endif
                    let substr = strpart(getline('.'), 0, col('.') - 1)
                    let substr = matchstr(substr, '[^ \t]*$')
                    if strlen(substr) == 0
                        " nothing to match on empty string
                        return "\<Tab>"
                    else
                        " existing text matching
                        if neosnippet#expandable_or_jumpable()
                            return "\<Plug>(neosnippet_expand_or_jump)"
                        else
                            return neocomplete#start_manual_complete()
                        endif
                    endif
                endfunction

                imap <expr> <Tab> CleverTab()
            " }

            " Enable heavy omni completion.
            if !exists('g:neocomplete#sources#omni#input_patterns')
                let g:neocomplete#sources#omni#input_patterns = {}
            endif
            let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
            let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
            let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
            let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
            let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
    " }

    " neocomplcache {
        elseif count(g:dup_vundle_groups, 'neocomplcache')
            let g:acp_enableAtStartup = 0
            let g:neocomplcache_enable_at_startup = 1
            let g:neocomplcache_enable_camel_case_completion = 1
            let g:neocomplcache_enable_smart_case = 1
            let g:neocomplcache_enable_underbar_completion = 1
            let g:neocomplcache_enable_auto_delimiter = 1
            let g:neocomplcache_max_list = 15
            let g:neocomplcache_force_overwrite_completefunc = 1

            " Define dictionary.
            let g:neocomplcache_dictionary_filetype_lists = {
                        \ 'default' : '',
                        \ 'vimshell' : $HOME.'/.vimshell_hist',
                        \ 'scheme' : $HOME.'/.gosh_completions'
                        \ }

            " Define keyword.
            if !exists('g:neocomplcache_keyword_patterns')
                let g:neocomplcache_keyword_patterns = {}
            endif
            let g:neocomplcache_keyword_patterns._ = '\h\w*'

            " Plugin key-mappings {
                " These two lines conflict with the default digraph mapping of <C-K>
                imap <C-k> <Plug>(neosnippet_expand_or_jump)
                smap <C-k> <Plug>(neosnippet_expand_or_jump)
                if exists('g:dup_noninvasive_completion')
                    inoremap <CR> <CR>
                    " <ESC> takes you out of insert mode
                    inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
                    " <CR> accepts first, then sends the <CR>
                    inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
                    " <Down> and <Up> cycle like <Tab> and <S-Tab>
                    inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
                    inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
                    " Jump up and down the list
                    inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
                    inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
                else
                    imap <silent><expr><C-k> neosnippet#expandable() ?
                                \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                                \ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
                    smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

                    inoremap <expr><C-g> neocomplcache#undo_completion()
                    inoremap <expr><C-l> neocomplcache#complete_common_string()
                    "inoremap <expr><CR> neocomplcache#complete_common_string()

                    function! CleverCr()
                        if pumvisible()
                            if neosnippet#expandable()
                                let exp = "\<Plug>(neosnippet_expand)"
                                return exp . neocomplcache#close_popup()
                            else
                                return neocomplcache#close_popup()
                            endif
                        else
                            return "\<CR>"
                        endif
                    endfunction

                    " <CR> close popup and save indent or expand snippet
                    imap <expr> <CR> CleverCr()

                    " <CR>: close popup
                    " <s-CR>: close popup and save indent.
                    inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()."\<CR>" : "\<CR>"
                    "inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"

                    " <C-h>, <BS>: close popup and delete backword char.
                    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
                    inoremap <expr><C-y> neocomplcache#close_popup()
                endif
                " <TAB>: completion.
                inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
                inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
            " }

            " Enable omni completion.
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

            " Enable heavy omni completion.
            if !exists('g:neocomplcache_omni_patterns')
                let g:neocomplcache_omni_patterns = {}
            endif
            let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
            let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
            let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
            let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
            let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
            let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'
    " }

    " Normal Vim omni-completion {
        " To disable omni complete, add the following:
        " let g:dup_no_omni_complete = 1
        elseif !exists('g:dup_no_omni_complete')
            " Enable omni-completion.
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

        endif
    " }

    " Snippets {
        if count(g:dup_vundle_groups, 'neocomplcache') ||
                    \ count(g:dup_vundle_groups, 'neocomplete')

            " Use honza's snippets.
            let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

            " Enable neosnippet snipmate compatibility mode
            let g:neosnippet#enable_snipmate_compatibility = 1

            " For snippet_complete marker.
            if !exists("g:dup_no_conceal")
                if has('conceal')
                    set conceallevel=2 concealcursor=i
                endif
            endif

            " Enable neosnippets when using go
            let g:go_snippet_engine = "neosnippet"

            " Disable the neosnippet preview candidate window
            " When enabled, there can be too much visual noise
            " especially when splits are used.
            set completeopt-=preview
        endif
    " }

    " OmniCppComplete {
        if count(g:dup_vundle_groups, 'OmniCppComplete')
             " 用于C/C++代码补全，这种补全主要针对命名空间、类、结构、共同体等进行补全
             " 使用前先执行如下 ctags 命令
             set completeopt=longest,menu           "关闭预览窗口
             let OmniCpp_NamespaceSearch = 2        "search namespaces in the current buffer and in included files
             let OmniCpp_ShowPrototypeInAbbr = 1    "display function parameter list
             let OmniCpp_MayCompleteScope = 1       "type in :: auto complete
             let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
        endif
    " }

    " Java {
        if count(g:dup_vundle_groups, 'java')
            if isdirectory(expand("~/.vim/bundle/vim-javacomplete2/"))
                autocmd FileType java setlocal omnifunc=javacomplete#Complete
            endif
        endif
    " }

    " PyMode {
        " Disable if python support not present
        if !has('python') && !has('python3')
            let g:pymode = 0
        endif

        if isdirectory(expand("~/.vim/bundle/python-mode"))
            let g:pymode_lint_checkers = ['pyflakes']
            let g:pymode_trim_whitespaces = 0
            let g:pymode_options = 0
            let g:pymode_rope = 0
        endif
    " }

    " PIV {
        if isdirectory(expand("~/.vim/bundle/PIV"))
            let g:DisableAutoPHPFolding = 0
            let g:PIVAutoClose = 0
        endif
    " }

    " GoLang {
        if count(g:dup_vundle_groups, 'go')
            let g:go_highlight_functions = 1
            let g:go_highlight_methods = 1
            let g:go_highlight_structs = 1
            let g:go_highlight_operators = 1
            let g:go_highlight_build_constraints = 1
            let g:go_fmt_command = "goimports"
            let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
            let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
            au FileType go nmap <Leader>s <Plug>(go-implements)
            au FileType go nmap <Leader>i <Plug>(go-info)
            au FileType go nmap <Leader>e <Plug>(go-rename)
            au FileType go nmap <leader>r <Plug>(go-run)
            au FileType go nmap <leader>b <Plug>(go-build)
            au FileType go nmap <leader>t <Plug>(go-test)
            au FileType go nmap <Leader>gd <Plug>(go-doc)
            au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
            au FileType go nmap <leader>co <Plug>(go-coverage)
        endif
    " }

    " nerdcommenter {
        if isdirectory(expand("~/.vim/bundle/nerdcommenter"))
            " Documentation: :help nerdcommenter

            " Settings
            " Add spaces after comment delimiters by default
            let g:NERDSpaceDelims = 1

            " Use compact syntax for prettified multi-line comments
            "let g:NERDCompactSexyComs = 1

            " Align line-wise comment delimiters flush left instead of following code indentation
            "let g:NERDDefaultAlign = 'left'

            " Set a language to use its alternate delimiters by default
            "let g:NERDAltDelims_java = 1

            " Add your own custom formats or override the defaults
            "let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/'  }  }

            " Allow commenting and inverting empty lines (useful when commenting a region)
            "let g:NERDCommentEmptyLines = 1

            " Enable trimming of trailing whitespace when uncommenting
            let g:NERDTrimTrailingWhitespace = 1
        endif
    " }

    " Fugitive {
        if isdirectory(expand("~/.vim/bundle/vim-fugitive/"))
            nnoremap <silent> <leader>gs :Gstatus<CR>
            nnoremap <silent> <leader>gd :Gdiff<CR>
            nnoremap <silent> <leader>gc :Gcommit<CR>
            nnoremap <silent> <leader>gb :Gblame<CR>
            nnoremap <silent> <leader>gl :Glog<CR>
            nnoremap <silent> <leader>gp :Git push<CR>
            nnoremap <silent> <leader>gr :Gread<CR>
            nnoremap <silent> <leader>gw :Gwrite<CR>
            nnoremap <silent> <leader>ge :Gedit<CR>
            " Mnemonic _i_nteractive
            nnoremap <silent> <leader>gi :Git add -p %<CR>
            nnoremap <silent> <leader>gg :SignifyToggle<CR>
        endif
    " }

    " Misc {
        if isdirectory(expand("~/.vim/bundle/matchit.zip"))
            let b:match_ignorecase = 1
        endif
    " }

" }

" GUI Settings {

    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T           " Remove the toolbar
        set lines=40                " 40 lines of text instead of 24
        if !exists("g:dup_no_big_font")
            if LINUX() && has("gui_running")
                set guifont=Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
            elseif OSX() && has("gui_running")
                set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
            elseif WINDOWS() && has("gui_running")
                set guifont=Andale_Mono:h10,Menlo:h10,Consolas:h10,Courier_New:h10
            endif
        endif
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
    endif

" }

" Functions {

    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }

" }

