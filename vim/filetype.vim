" markdown filetype file
augroup markdown
	 au! BufRead,BufNewFile *.mmd   setfiletype mmd
augroup END

augroup pgsql
	 au! BufRead,BufNewFile *.sql setfiletype pgsql
augroup END
