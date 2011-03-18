let s:data=readfile("data")


function! s:Build2DArray(n,m,v)
	let res=[]
	for i in range(a:n)
		let row=[]
		for j in range(a:m)
			call add(row,a:v)
		endfor
		call add(res,row)
	endfor
	return res
endfunction


function! s:PrintMap(change)
	for p in a:change
		let i=p[0]-1
		let j=p[1]-1
		let s:map[i][j]=p[2]
	endfor
	for i in range(1,s:R)
		let s=join(s:map[i-1],"")
		call setline(i,s)
	endfor
endfunction

function! s:Initialize()
	let firstLine=split(s:data[0],' ')
	let s:R=firstLine[0]
	let s:C=firstLine[1]
	let s:sleepTime=1000/firstLine[2]
	set go-=T
	if has("win32")
		set guifont=Terminal:h9
	else
	     	set guifont=Free\ Mono\ 8
	endif
	:res 50
	let s:map=s:Build2DArray(s:R,s:C,' ')
	call s:PrintMap([])
endfunction

function! s:Start()
	for line in s:data[1:]
		call s:PrintMap(map(split(line,"|"),"split(v:val,'_')"))
		redraw
		sleep 70m
	endfor
endfunction
call s:Initialize()
call s:Start()
