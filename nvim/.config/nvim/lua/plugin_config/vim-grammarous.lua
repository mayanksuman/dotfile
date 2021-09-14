local g = vim.g

g.grammarous#default_comments_only_filetypes = {['*'] = 1, 'help' = 0, 'markdown' = 0}

g.grammarous#use_vim_spelllang = 1

let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
    nmap <buffer><C-g> <Plug>(grammarous-open-info-window)
    nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
    nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
    nmap <buffer><C-f> <Plug>(grammarous-fixit)
endfunction

function! g:grammarous#hooks.on_reset(errs) abort
    nunmap <buffer><C-g>
    nunmap <buffer><C-n>
    nunmap <buffer><C-p>
    nunmap <buffer><C-f>
endfunction
