" Toggle spellcheck on F6
map <F6> :setlocal spell!<CR>
" Spellcheck language - I need it only with Russian stuff
:set spelllang=ru

" Show number lines on the left
:set number
" Turn on syntax highlighting
:syntax on
" I forgot what this does lol
filetype plugin indent on
" Change some colors
:hi MatchParen	ctermbg=4
:hi SpellBad	ctermbg=9
" When using TAB autocompletion, show a list of autocompletable things
:set wildmenu
" Disallow files to specify what settings should vim use. Actually screw it,
" this feature is cool so I'll keep it enabled
":set nomodeline
" Always leave 5 lines above and beyond cursor visible at all times
:set scrolloff=5
" Make highlighting brighter to make it visible
:set background=dark


" Write out the text while this mode thing is enabled
:command ArchAutoWrite autocmd TextChanged,TextChangedI <buffer> silent write
:command ArchAutoWriteStop autocmd! TextChanged,TextChangedI <buffer>
:command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'

" Execute command when writing without having
" to press Return when the command finishes
:command -nargs=1 ArchExecOnWrite autocmd BufWritePost * :Silent <args>
:command ArchExecOnWriteStop autocmd! BufWritePost *
