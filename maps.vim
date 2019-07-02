" custom maps
" Author: Viacheslav Lotsmanov

let mapleader = ','

" flying between buffers
" (c) https://bairuidahu.deviantart.com/art/Flying-vs-Cycling-261641977
nn <leader>bl :ls<CR>:b<space>
nn <leader>bd :ls<CR>:bd<space>
nn <leader>bD :ls<CR>:bd!<space>
nn <leader>bp :b#<CR>
nn <leader>bo :bro o<cr>
nn <leader><space> :ls<cr>
nn <space><leader> :o<cr>

nn <leader>r :let @/ = ''<CR>:ec 'Reset search'<CR>

" 'cr' means 'config reload'
nn <leader>cr :so $MYVIMRC<CR>

" CtrlSpace panel open
nn <C-Space> :CtrlSpace<CR>

" nnoremap <leader>n :NERDTreeMirrorToggle<CR>
nn <leader>n  :NERDTreeToggle<CR>
nn <leader>N  :NERDTreeToggle<CR><C-w>p
nn <leader>fn :NERDTreeFind<CR>
nn <leader>fo :NERDTreeFind<CR><C-w>p
nn <leader>fb :NERDTreeFind<CR><C-w>p:TagbarOpen<CR>
nn <leader>t  :TagbarToggle<CR>
nn <leader>u  :GundoToggle<CR>
nn <leader>'  :cal LanguageClient_contextMenu()<CR>

" UltiSnips map without conflicts
" with own <Tab> maps for visual and select modes.
if has('python3') || has('python')
	" FIXME for js/ts snippets UltiSnips#SnippetsInCurrentScope() returns empty
	"       dictionary if a snippet doesn't have space character before while
	"       UltiSnips#ExpandSnippet() correctly expands such a snippet
	fu! s:IsSnippetExpandable()
		retu !(
			\ col('.') <= 1
			\ || !empty(matchstr(getline('.'), '\%' . (col('.') - 1) . 'c\s'))
			\ || empty(UltiSnips#SnippetsInCurrentScope())
			\ )
	endf

	ino <expr> <Tab> <SID>IsSnippetExpandable()
		\ ? '<C-R>=UltiSnips#ExpandSnippet()<CR>' : '<Tab>'

	" FIXME fix the issue with UltiSnips#SnippetsInCurrentScope() and you wont
	"       need this hack to force expanding anymore
	ino <C-x><Tab> <C-R>=UltiSnips#ExpandSnippet()<CR>
en

com! FZFGit cal fzf#run({
	\ 'source': 'git ls-files',
	\ 'sink': 'e',
	\ 'down': '40%',
	\ 'options': '--color=' . (&bg == 'light' ? 'light' : 'dark'),
	\})

com! FZFMy cal fzf#run({
	\ 'sink': 'e',
	\ 'down': '40%',
	\ 'options': '--color=' . (&bg == 'light' ? 'light' : 'dark'),
	\})

fu! g:FuzzyGitFileMaps()
	nn <A-p> :tabnew<CR>:FZFGit<CR>
	nn <C-p> :FZFGit<CR>
endf

" fuzzy search for a file
nn <A-p> :tabnew<CR>:FZFMy<CR>
nn <C-p> :FZFMy<CR>

" prevent triggering `s` when `<leader>s` is pressed
" but next symbol not in time.
" can't use `<Nop>` because it affects pressing this second time,
" maybe it's some bug of neovim or something, when i press `<leader>s` wait some
" time and again `<leader>s` then `s` is triggered, strange. that's why it
" solved by these hacks.
nn <leader>s  <Esc>
nn <leader>sw <Esc>
xn <leader>s  <C-g><C-g>
xn <leader>sw <C-g><C-g>

" GitGutter keys
no <leader>gg :GitGutterAll<CR>
nn <leader>gv :GitGutterPreviewHunk<CR>
nn <Leader>ga :GitGutterStageHunk<CR>
nn <Leader>gr :GitGutterUndoHunk<CR>
nm ]c         <Plug>GitGutterNextHunk
nm [c         <Plug>GitGutterPrevHunk

" git status in new tab
nn <leader>gs :tabnew %<CR>:Gstatus<CR><C-w>o
nn <leader>gS :Gstatus<CR><C-w>o

" modes togglers
nn <leader>mw :WrapToggle<CR>
nn <leader>mp :PasteToggle<CR>
nn <leader>ml :ListToggle<CR>
nn <leader>mn :RelativeNumberToggle<CR>
nn <leader>m] :DelimitMateSwitch<CR>
nn <leader>mg :GitGutterToggle<CR>
nn <leader>mc :AutoClearSpacesAtEOFToggle<CR>
nn <leader>mt :AutoTrimSpacesAtEOFToggle<CR>

" some buffer configs
nn <leader>ft :se ft=
nn <leader>fl :se fdl=
nn <leader>fm :se fdm=

" some windows things
nn <leader>sww :9999winc < \| se wiw=
nn <leader>swh :9999winc - \| se wh=
nn <leader>swW :se wfw \| 9999winc < \| se wiw=
nn <leader>swH :se wfh \| 9999winc - \| se wh=


" Neomake
nn <leader>si :NeomakeInfo<CR>
nn <leader>sc :Neomake<CR>


" show hint
nn <leader>sh :ShowHint<CR>


" EasyAlign
xm <Enter> <Plug>(EasyAlign)
nm ga <Plug>(EasyAlign)
" short EasyAlign aliases
xn <leader>:  :EasyAlign/:/<CR>
xn <leader>g: :EasyAlign : {'lm':0,'stl':0}<CR>
" haskell record syntax (align by '=' inside braces)
xn <leader>=  :EasyAlign/\({.*\\|,.*\)\@<==/<CR>
" haskell alone '='
xn <space>=   :EasyAlign/ = /{'lm':0,'rm':0}<CR>
nn <leader>a  :EasyAlign
xn <leader>a  :EasyAlign
xn <leader>A  :EasyAlign/  /{'lm':0,'rm':0}
	\<left><left><left><left><left><left><left><left><left>
	\<left><left><left><left><left><left><left><left>


" CtrlSF bindings
nm <leader>sf <Plug>CtrlSFPrompt
xm <leader>sf <Plug>CtrlSFVwordPath
xm <leader>sF <Plug>CtrlSFVwordExec
nm <leader>sn <Plug>CtrlSFCwordPath
nm <leader>sN <Plug>CtrlSFCwordExec
nm <leader>sp <Plug>CtrlSFPwordPath
nm <leader>sP <Plug>CtrlSFPwordExec
nn <leader>so :CtrlSFOpen<CR>
nn <leader>st :CtrlSFToggle<CR>

" doesn't work with visual-block selection
fu! s:get_selected_text()
	let [l:line_a, l:col_a] = getpos("'<")[1:2]
	let [l:line_b, l:col_b] = getpos("'>")[1:2]
	let l:lines = getline(l:line_a, l:line_b)
	if len(l:lines) == 0 | retu '' | el
		let l:lines[-1] = l:lines[-1][: l:col_b - 1  ]
		let l:lines[ 0] = l:lines[ 0][  l:col_a - 1 :]
		retu join(l:lines, "\n")
	en
endf

" escape quotes to put them inside double single quotes '...'
fu! s:escq(x)
	retu
	\ substitute(
	\ substitute(
	\ substitute(
	\ a:x, '''', '&&', 'g'),
	\ '\"', '\\&', 'g'),
	\ '|', ("'.'".'\\|'."'.'"), 'g')
endf

" git-grep shortcuts
" (kinda like CtrlSF maps but with 'g' instead of 's')
" normal mode: this window
nn <leader>gf :exe'te'\|put='git grep -nIF -- '.shellescape('').
	\' \\| git-grep-nvr.sh<C-v><CR>'\|star
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
" normal mode: new window (horizontal split)
nn <space>gf :exe'TE'\|put='git grep -nIF -- '.shellescape('').
	\' \\| git-grep-nvr.sh<C-v><CR>'
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left>
" normal mode: new window (vertical split)
nn <space>Gf :exe'VTE'\|put='git grep -nIF -- '.shellescape('').
	\' \\| git-grep-nvr.sh<C-v><CR>'
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left>
" normal mode: improve UX when press wrong keys
nn <leader>g <Nop>
nn  <space>g <Nop>
nn  <space>G <Nop>
" visual mode: this window
xn <leader>gf <Esc>:exe'te'\|put='git grep -nIF -- '.
	\shellescape('<C-r>=<SID>escq(<SID>get_selected_text())<CR>').
	\' \\| git-grep-nvr.sh<C-v><CR>'\|star
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
" visual mode: new window (horizontal split)
xn <space>gf <Esc>:exe'TE'\|put='git grep -nIF -- '.
	\shellescape('<C-r>=<SID>escq(<SID>get_selected_text())<CR>').
	\' \\| git-grep-nvr.sh<C-v><CR>'
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left>
" visual mode: new window (vertical split)
xn <space>Gf <Esc>:exe'VTE'\|put='git grep -nIF -- '.
	\shellescape('<C-r>=<SID>escq(<SID>get_selected_text())<CR>').
	\' \\| git-grep-nvr.sh<C-v><CR>'
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left>
" visual mode: improve UX when press wrong keys
xn <leader>g <Nop>
xn  <space>g <Nop>
xn  <space>G <Nop>
" visual mode: trigger immediately, without pressing enter
xm <leader>gF <leader>gf<CR>
xm  <space>gF  <space>gf<CR>
xm  <space>GF  <space>Gf<CR>
" word under cursor: this window
no <leader>gn :exe'te'\|put='git grep -nIF -- '.
	\shellescape('<C-r>=<SID>escq(expand('<cword>'))<CR>').
	\' \\| git-grep-nvr.sh<C-v><CR>'\|star
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
" word under cursor: new window (horizontal split)
no <space>gn :exe'TE'\|put='git grep -nIF -- '.
	\shellescape('<C-r>=<SID>escq(expand('<cword>'))<CR>').
	\' \\| git-grep-nvr.sh<C-v><CR>'
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left>
" word under cursor: new window (vertical split)
no <space>Gn :exe'VTE'\|put='git grep -nIF -- '.
	\shellescape('<C-r>=<SID>escq(expand('<cword>'))<CR>').
	\' \\| git-grep-nvr.sh<C-v><CR>'
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left>
" word under cursor: trigger immediately, without pressing enter
nm <leader>gN <leader>gn<CR>
nm  <space>gN  <space>gn<CR>
nm  <space>GN  <space>Gn<CR>
" from highlighted search: this window
nn <leader>gp :exe'te'\|put='git grep -nIF -- '.
	\shellescape('<C-r>=<SID>escq(@/)<CR>').
	\' \\| git-grep-nvr.sh<C-v><CR>'\|star
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
" from highlighted search: new window (horizontal split)
nn <space>gp :exe'TE'\|put='git grep -nIF -- '.
	\shellescape('<C-r>=<SID>escq(@/)<CR>').
	\' \\| git-grep-nvr.sh<C-v><CR>'
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left>
" from highlighted search: new window (vertical split)
nn <space>Gp :exe'VTE'\|put='git grep -nIF -- '.
	\shellescape('<C-r>=<SID>escq(@/)<CR>').
	\' \\| git-grep-nvr.sh<C-v><CR>'
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
	\<Left><Left><Left><Left><Left>
" from highlighted search: trigger immediately, without pressing enter
nm <leader>gP <leader>gp<CR>
nm  <space>gP  <space>gp<CR>
nm  <space>GP  <space>Gp<CR>


" Make Hoogle search easier (because I use it very often)
nn <A-g> :Hoogle<space>
xn <A-g> <Esc>:Hoogle <C-r>=<SID>escq(<SID>get_selected_text())<CR><CR>


" EasyMotion bindings (<Space> for overwin-mode, <Leader> for current window)

"  L----  ('L' - with <leader> or ' ' - without it)
" QWerty  (uppercase means it have map)
" SS----  ('S' - overwin with <space>)

" move anywhere ('q' means 'quick (move)')
nm q         <Plug>(easymotion-bd-w)
xm q         <Plug>(easymotion-bd-w)
nm <Space>q  <Plug>(easymotion-overwin-w)
" doesn't make sense with 'overwin' mode
xm <Space>q  <Nop>
" some plugins uses 'q' map to close window.
" by using 'g' prefix we still able to call easymotion.
nm gq        <Plug>(easymotion-bd-w)
xm gq        <Plug>(easymotion-bd-w)

" move to place with specific symbols
nm <leader>w <Plug>(easymotion-bd-f2)
xm <leader>w <Plug>(easymotion-bd-f2)
nm <Space>w  <Plug>(easymotion-overwin-f2)
" doesn't make sense with 'overwin' mode
xm <Space>w  <Nop>

" just another hook as `<leader>e` but for single symbol
nm <leader>e <Plug>(easymotion-bd-f)
xm <leader>e <Plug>(easymotion-bd-f)
nm <Space>e  <Plug>(easymotion-overwin-f)
" doesn't make sense with 'overwin' mode
xm <Space>e  <Nop>

" LL-L  ('L' - with <leader> or ' ' - without it)
" ZXcV  (uppercase means it have map)
" -S--  ('S' - overwin with <space>)

" move over the line
nm <leader>z <Plug>(easymotion-lineanywhere)
xm <leader>z <Plug>(easymotion-lineanywhere)

" move between lines
" (also between empty lines with indentation)
nm <leader>x <Plug>(easymotion-bd-jk)
xm <leader>x <Plug>(easymotion-bd-jk)
nm <Space>x  <Plug>(easymotion-overwin-line)
xm <Space>x  <Nop>

" turn on visual mode and select to specific place
nm <leader>v v<Plug>(easymotion-bd-w)
nm <leader>V V<Plug>(easymotion-bd-jk)

" move by direction
nm <leader>l <Plug>(easymotion-lineforward)
xm <leader>l <Plug>(easymotion-lineforward)
nm <leader>h <Plug>(easymotion-linebackward)
xm <leader>h <Plug>(easymotion-linebackward)
nm <leader>j <Plug>(easymotion-j)
xm <leader>j <Plug>(easymotion-j)
nm <leader>k <Plug>(easymotion-k)
xm <leader>k <Plug>(easymotion-k)

" search (with 'incsearch' plugin)
nm g/        <Plug>(incsearch-easymotion-/)
nm g?        <Plug>(incsearch-easymotion-?)
nm <leader>/ <Plug>(incsearch-easymotion-stay)


" quickhl
nm <Space>m <Plug>(quickhl-manual-this)
xm <Space>m <Plug>(quickhl-manual-this)
nm <Space>M <Plug>(quickhl-manual-reset)
xm <Space>M <Plug>(quickhl-manual-reset)
nm <Space>n <Plug>(quickhl-cword-toggle)


" remove word selection symbols after paste from search
nm  <leader>c/  ds\ds>
" plugs to prevent mess about triggering default 'p' or 'P'
map <leader>p   <Nop>
map <leader>P   <Nop>
" paste searched word and clean it
map <leader>p/  '/phds\ds>
map <leader>P/  '/Phds\ds>
nm  <leader>po  <A-.>jP
nm  <leader>pO  <A-,>kP

" another alias to system X clipboard
no '<Space> "+
no <Space>' "*
" another alias to 'last yank' register
no <A-y> "0

fu! s:copy_many_lines_as_one(sys_clipboard)
	let l:view = winsaveview() | let l:buf = a:sys_clipboard ? '"+' : ''
	exe 'norm! gvJgv'.l:buf.'yu'
	cal winrestview(l:view)
endf

" copy multiple selected lines as one single line
xn <leader>y <Esc>:cal <SID>copy_many_lines_as_one(0)<CR>
" copy multiple selected lines as one single line to system clipboard
xn <leader>Y <Esc>:cal <SID>copy_many_lines_as_one(1)<CR>


" forward version of <C-h>
no! <C-l> <Del>


" colorscheme stuff
no <leader>ss <Esc>:set background=
no <leader>sb :BackgroundToggle<CR>
no <leader>sB :GruvboxContrastRotate<CR>

nn gy Y:let @0 = substitute(@0, '.', ' ', 'g')<CR>:ec<CR>
nn gY Y:let @0 = substitute(@0, '[^\r\n\t]', ' ', 'g')<CR>:ec<CR>
xn gy y:let @0 = substitute(@0, '.', ' ', 'g')<CR>:ec<CR>
xn gY y:let @0 = substitute(@0, '[^\r\n\t]', ' ', 'g')<CR>:ec<CR>

" walking between windows (hjkl)
nn <C-h>     :winc h<CR>
xn <C-h>     <Esc>:winc h<CR>
nn <C-j>     :winc j<CR>
xn <C-j>     <Esc>:winc j<CR>
nn <C-k>     :winc k<CR>
xn <C-k>     <Esc>:winc k<CR>
nn <C-l>     :winc l<CR>
xn <C-l>     <Esc>:winc l<CR>
" walking between windows (arrow keys)
nn <C-Left>  :winc h<CR>
xn <C-Left>  <Esc>:winc h<CR>
nn <C-Right> :winc l<CR>
xn <C-Right> <Esc>:winc l<CR>
nn <C-Up>    :winc k<CR>
xn <C-Up>    <Esc>:winc k<CR>
nn <C-Down>  :winc j<CR>
xn <C-Down>  <Esc>:winc j<CR>
" windows size minimization/maximization/normalization
nn <A-=>     :winc =<CR>
nn <A-->     :winc _<CR>
nn <A-\>     :winc \|<CR>

" scrolling windows by alt+arrow keys in any direction
nn <A-Left>  zh
xn <A-Left>  zh
nn <A-Right> zl
xn <A-Right> zl
nn <A-Up>    <C-y>
xn <A-Up>    <C-y>
nn <A-Down>  <C-e>
xn <A-Down>  <C-e>

" resizing windows by alt+shift+arrow keys
nn <A-S-Left>  :winc <<CR>
xn <A-S-Left>  <Esc>:winc <<CR>
nn <A-S-Right> :winc ><CR>
xn <A-S-Right> <Esc>:winc ><CR>
nn <A-S-Up>    :winc +<CR>
xn <A-S-Up>    <Esc>:winc +<CR>
nn <A-S-Down>  :winc -<CR>
xn <A-S-Down>  <Esc>:winc -<CR>

" zoom buffer hack ('fz' means 'full size')
nn <leader>fz :999winc ><CR>:999winc +<CR>
xn <leader>fz <Esc>:999winc ><CR>:999winc +<CR>gv

" moving between history in command mode
cno <C-p> <Up>
cno <C-n> <Down>

" moving tabs
nn <C-S-PageUp>   :tabm-1<CR>
nn <C-S-PageDown> :tabm+1<CR>

" jump by half of screen by pageup/pagedown
nm <PageUp>     <C-u>
nm <PageDown>   <C-d>
xm <PageUp>     <C-u>
xm <PageDown>   <C-d>
" default jump by pageup/pagedown with shift prefix
nm <S-PageUp>   <C-b>
nm <S-PageDown> <C-f>
xm <S-PageUp>   <C-b>
xm <S-PageDown> <C-f>

" get rid off randomly turning ex-mode on
nm Q     <Nop>
nm gQ    <Nop>
nm <A-Q> <Nop>

" remap macros key under leader
" default 'q' remapped to easymotion call
no <leader>q q

xn   <Tab> <Esc>
snor <Tab> <Esc>
tno  <Leader><Tab> <C-\><C-n>
tno  <Leader><Esc> <C-\><C-n>

" thanks to Minoru for the advice to swap ; and :
no ; :
nn : :Commands<CR>

" thanks to r3lgar for the advice (swap default <leader> and comma)
no \ ;
no \| ,

" because working with clipboard registers is more important
no ' "
no " '
no "" ''
nn '' :reg<CR>

" custom behavior of big R in visual mode
xn R r<Space>R

" break line but keep same column position for rest of the line
fu! s:split_next_line(new_col_offset, stay)
	let l:pos=getcurpos() | let l:line=getline('.') | let l:vc=virtcol('$')
	if l:pos[4] >= l:vc
		pu=repeat(' ', l:pos[4] - 1 + a:new_col_offset)
		cal setline(l:pos[1], l:line[:l:pos[2]])
	el
		pu=repeat(' ', l:pos[4] - 1 + a:new_col_offset) . l:line[l:pos[2] - 1:]
		cal setline(l:pos[1], l:line[:l:pos[2] - 2])
	en
	if a:stay
		cal setpos('.', l:pos)
	elsei l:pos[4] >= l:vc
		let l:pos[1] += 1 | let l:pos[2] = l:pos[4] + a:new_col_offset
		let l:pos[3] = 0 | unlet l:pos[4] | cal setpos('.', l:pos)
	en
endf
ino <A-CR> <C-o>:cal <SID>split_next_line( 0, 0)<CR>
" cannot map <S-CR> to make <A-S-CR> alternative
" imap <A-S-CR> <C-o>:cal <SID>split_next_line(-1, 0)<CR>
ino <A-'>  <C-o>:cal <SID>split_next_line( 0, 1)<CR>
ino <A-">  <C-o>:cal <SID>split_next_line(-1, 1)<CR>
fu! s:split_prev_line(new_col_offset, stay)
	let l:pos=getcurpos() | let l:line=getline('.') | let l:vc=virtcol('$')
	if l:pos[4] >= l:vc
		pu!=repeat(' ', l:pos[4] - 1 + a:new_col_offset)
		cal setline(l:pos[1] + 1, l:line[:l:pos[2]])
	el
		pu!=repeat(' ', l:pos[4] - 1 + a:new_col_offset) . l:line[l:pos[2] - 1:]
		cal setline(l:pos[1] + 1, l:line[:l:pos[2] - 2])
	en
	if a:stay
		let l:pos[1] += 1 | cal setpos('.', l:pos)
	elsei l:pos[4] >= l:vc
		let l:pos[2] = l:pos[4] + a:new_col_offset | let l:pos[3] = 0
		unlet l:pos[4] | cal setpos('.', l:pos)
	en
endf
ino <A-\>  <C-o>:cal <SID>split_prev_line( 0, 0)<CR>
ino <A-\|> <C-o>:cal <SID>split_prev_line(-1, 0)<CR>
ino <A-]>  <C-o>:cal <SID>split_prev_line( 0, 1)<CR>
ino <A-}>  <C-o>:cal <SID>split_prev_line(-1, 1)<CR>

fu! s:new_line_after()
	let l:x = getpos('.') | pu='' | cal setpos('.', l:x)
endf
nn <A-.> :cal <SID>new_line_after()<CR>
fu! s:new_line_before()
	let l:x = getpos('.') | pu!='' | let l:x[1] += 1 | cal setpos('.', l:x)
endf
nn <A-,> :cal <SID>new_line_before()<CR>
nm <leader>o <A-.>ji
nm <leader>O <A-,>ki

" add space without moving cursor
im <A-Space> <Space><Left>


" custom numbers line keys

nn  ! #:ShowSearchIndex<CR>
nn g! :let @/='\V\<'.expand('<cword>').'\>'<CR>:ShowSearchIndex<CR>
xn  ! :<C-u>cal VisualStarSearchSet('?')<CR>?<C-R>=@/<CR><CR>:ShowSearchIndex<CR>
xn g! :<C-u>cal VisualStarSearchSet('?')<CR>:ShowSearchIndex<CR>
nn  @ *:ShowSearchIndex<CR>
nn g@ :let @/='\V\<'.expand('<cword>').'\>'<CR>:ShowSearchIndex<CR>
xn  @ :<C-u>cal VisualStarSearchSet('/')<CR>/<C-R>=@/<CR><CR>:ShowSearchIndex<CR>
xn g@ :<C-u>cal VisualStarSearchSet('/')<CR>:ShowSearchIndex<CR>
" no ! #
" no @ *

" begin/end of line ignoring indentation and trailing whitespaces
no  #  ^
no g# g^
no  $ g_
no g$ g$

" default behavior of %
" noremap %

" noremap ^ 0
" we already have 0, I never use this key (^) this way
" let's remap it to '|' that in case was remapped too
no  ^ \|
no g^ g0

" opposite to 0
no  &  $
no g& g$

" macros call
no  *  @
no g* g@

" swapping j/k with gj/gk
nn  j gj
xn  j gj
nn  k gk
xn  k gk
nn gj  j
xn gj  j
nn gk  k
xn gk  k

" relative tabnext by default
nn gt :<C-u>exe join(repeat(['tabnext'], v:count1), '\|')<CR>
xn gt :<C-u>exe join(repeat(['tabnext'], v:count1), '\|')<CR>
" original behavior via <leader> key
nn <leader>gt gt
xn <leader>gt gt

" additional move over cursor history (as alternative to ^O/^I).
" moving over changelist (see :changes).
nn <A-o> g;
nn <A-i> g,

" navigating by tabs
nm <A-f> gt
nm <A-b> gT
nm <A-1> 1,gt
nm <A-2> 2,gt
nm <A-3> 3,gt
nm <A-4> 4,gt
nm <A-5> 5,gt
nm <A-6> 6,gt
nm <A-7> 7,gt
nm <A-8> 8,gt
nm <A-9> 9,gt
nm <A-0> 10,gt

" default maps disabled for plugin
cno <expr> <CR> '<CR>' . (getcmdtype() =~ '[/?]' ? ':ShowSearchIndex<CR>' : '')
nn n n:ShowSearchIndex<CR>
nn N N:ShowSearchIndex<CR>

nn <A-t> :tabe<CR>
nn <A-w> :tabc<CR>

" quick hook for 'IndentText'
xn <A-i>   ym0gvc<Esc>`0:cal<space>IndentText()<CR>
xn <A-S-i> ym0gvI<Esc>`0:cal<space>IndentText()<CR>

" pasting from default buffer in insert/cmdline mode
no! <A-p> <C-r>"
no! <A-y> <C-r>0

" to create short aliases for tTfF jumps to unicode symbols
fu! s:UnicodeJumpsShortcuts(ascii, uni)
	for mpfx in ['n', 'x']
		for apfx in ['', 'd', 'c']
			exe l:mpfx.'no '.l:apfx.'t<A-'.a:ascii.'> '.l:apfx.'t'.a:uni
			exe l:mpfx.'no '.l:apfx.'T<A-'.a:ascii.'> '.l:apfx.'T'.a:uni
			exe l:mpfx.'no '.l:apfx.'f<A-'.a:ascii.'> '.l:apfx.'f'.a:uni
			exe l:mpfx.'no '.l:apfx.'F<A-'.a:ascii.'> '.l:apfx.'F'.a:uni
		endfo
	endfo
endf

" based on snippets for Haskell
cal s:UnicodeJumpsShortcuts(';', '∷')
cal s:UnicodeJumpsShortcuts(':', '∷')
cal s:UnicodeJumpsShortcuts('<', '←')
cal s:UnicodeJumpsShortcuts('>', '→')
cal s:UnicodeJumpsShortcuts('[', '⇐')
cal s:UnicodeJumpsShortcuts(']', '⇒')
cal s:UnicodeJumpsShortcuts('.', '∘')
cal s:UnicodeJumpsShortcuts(',', '•')
cal s:UnicodeJumpsShortcuts('A', '∀')
cal s:UnicodeJumpsShortcuts('a', '∧') " 'a' for 'and'
cal s:UnicodeJumpsShortcuts('o', '∨') " 'o' for 'or'
cal s:UnicodeJumpsShortcuts('=', '≡')
cal s:UnicodeJumpsShortcuts('-', '≠')
cal s:UnicodeJumpsShortcuts('_', '≢')
cal s:UnicodeJumpsShortcuts('l', '≤') " 'l' for 'less'
cal s:UnicodeJumpsShortcuts('g', '≥') " 'g' for 'greater'
cal s:UnicodeJumpsShortcuts('+', '⧺')
cal s:UnicodeJumpsShortcuts('*', '⋅')
cal s:UnicodeJumpsShortcuts('x', '×')
cal s:UnicodeJumpsShortcuts('/', '÷')
cal s:UnicodeJumpsShortcuts('e', '∈')
cal s:UnicodeJumpsShortcuts('E', '∉')
cal s:UnicodeJumpsShortcuts('3', '∋')
cal s:UnicodeJumpsShortcuts('#', '∌')
cal s:UnicodeJumpsShortcuts('Z', 'ℤ')
cal s:UnicodeJumpsShortcuts('N', 'ℕ')
cal s:UnicodeJumpsShortcuts('Q', 'ℚ')
cal s:UnicodeJumpsShortcuts('R', 'ℝ')
cal s:UnicodeJumpsShortcuts('B', '𝔹')
cal s:UnicodeJumpsShortcuts('P', 'π')
cal s:UnicodeJumpsShortcuts('8', '∞')
cal s:UnicodeJumpsShortcuts('d', '…') " 'd' for 'dots'
cal s:UnicodeJumpsShortcuts('{', '«')
cal s:UnicodeJumpsShortcuts('}', '»')
cal s:UnicodeJumpsShortcuts('v', '⋄')
cal s:UnicodeJumpsShortcuts('r', '◇') " 'r' for 'rhombus'
