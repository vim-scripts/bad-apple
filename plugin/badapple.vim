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


let s:grey=['#','o','.',' ']
function! s:PrintMap(change)
	for p in a:change
		let i=p[0]
		let j=p[1]
		let s:map[i][j]=s:grey[p[2]]
	endfor
	for i in range(1,s:R)
		let s=join(s:map[i-1],"")
		let s=substitute(s,".","&&","g")
		call setline(i,s)
	endfor
endfunction

function! s:Initialize()
	let s:R=48
	let s:C=64
	set go-=T
	if has("win32")
		set guifont=Terminal:h9
	else
	     	set guifont=Free\ Mono\ 8
	endif
	:res 50
	let s:map=s:Build2DArray(s:R,s:C,'#')
	call s:PrintMap([])
endfunction

function! s:Start()
	for line in s:data
		let change=[]
		for p in split(line," ")
			call add(change,split(p,","))
		endfor
		call s:PrintMap(change)
		redraw
		sleep 40m
	endfor
endfunction
call s:Initialize()
call s:Start()
