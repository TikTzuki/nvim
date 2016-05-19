"autocmd commands
"Author: Viacheslav Lotsmanov

if has('autocmd')
	
	autocmd BufNewFile,BufRead
		\ *.json.example,.jshintrc,.babelrc,.eslintrc
		\ set ft=json
	autocmd BufNewFile,BufRead *.gyp set ft=json
	autocmd BufNewFile,BufRead *.yaml.example set ft=yaml
	autocmd BufNewFile,BufRead *.ts set ft=typescript
	autocmd BufNewFile,BufRead Makefile set noexpandtab
	
	" because some custom `indentexpr`s has annoying issues
	autocmd FileType
		\ ls,coffee,stylus,jade,html,jst,sh,faust,javascript.jsx
		\ set indentexpr=
	
	" haskell default indentation config
	autocmd FileType haskell,cabal setlocal et ts=2 sts=2 sw=2
endif

"vim: set noet :
