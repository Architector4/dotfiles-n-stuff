" Toggle spellcheck on F6
map <F6> :setlocal spell!<CR>
" Spellcheck language - I need it only with Russian stuff
:set spelllang=ru

" Show number lines on the left
:set number
" Turn on syntax highlighting
:syntax on
" I forgot what this does lol
" When using TAB autocompletion, show a list of autocompletable things
:set wildmenu
" Don't allow random files to tell vim which settings it should use.
" Actually screw it, this feature is cool so I'll keep it enabled.
":set nomodeline
" Always leave 5 lines above and beyond cursor visible at all times
:set scrolloff=5
" Make highlighting brighter to make it visible
:set background=dark

filetype plugin indent on
" Change some colors
" Set background color of matching parenthesis to blue
:hi MatchParen	ctermbg=4
" Set background color of a misspelled word to red
:hi SpellBad	ctermbg=1
" Set background color of a line that differs to green
:hi DiffChange	ctermbg=2
" Set background color of text that differs to red
:hi DiffText	ctermbg=4

" When ArchAutoWrite is enabled, write out the file every time it's changed
:command ArchAutoWrite autocmd TextChanged,TextChangedI <buffer> silent write
:command ArchAutoWriteStop autocmd! TextChanged,TextChangedI <buffer>
:command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'

" Execute command when writing without having to press Return when the command finishes
:command -nargs=1 ArchExecOnWrite autocmd BufWritePost * :Silent <args>
:command ArchExecOnWriteStop autocmd! BufWritePost *
