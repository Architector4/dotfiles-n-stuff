" Toggle spellcheck on F6
map <F6> :setlocal spell!<CR>
" Spellcheck language
:set spelllang=ru,en

" Map double press of "MENU" key to "ESCAPE" key when in Insert mode
:imap [29~ <Esc><Esc>

" Show number lines on the left, both relative and absolute
":set number relativenumber
" actually just normal numbers are fine
:set number
" Turn on syntax highlighting
:syntax on
" When using TAB autocompletion, show a list of autocompletable things
":set wildmenu
" Make TAB autocompletion bash-like
:set wildmode=longest,list
" Don't allow random files to tell vim which settings it should use.
" Actually screw it, this feature is cool so I'll keep it enabled.
":set nomodeline
" Always leave 5 lines above and beyond cursor visible at all times
:set scrolloff=5
" Make highlighting brighter to make it visible
:set background=dark
" make the TTY fast
:set ttyfast
" Don't put double space after periods when joining lines with space
:set nojoinspaces
" Enable mouse, actually
:set mouse=a

filetype plugin indent on
" Change some colors
" Set background color of matching parenthesis to blue
:hi MatchParen	ctermbg=4
" Set background color of a misspelled word to red
:hi SpellBad	ctermbg=1
" Set background color of a line that differs to deep blue
" (probably needs a 32bit color supporting terminal tho)
:hi DiffChange	ctermbg=20
" Set background color of text that differs to red
:hi DiffText	ctermbg=4
" Set colors for gvim
highlight Normal guifg=white guibg=black

" When ArchAutoWrite is enabled, write out the file every time it's changed
:command ArchAutoWrite autocmd TextChanged,TextChangedI <buffer> silent write
:command ArchAutoWriteStop autocmd! TextChanged,TextChangedI <buffer>
:command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'

" Execute command when writing without having to press Return when it's done
:command -nargs=1 ArchExecOnWrite autocmd BufWritePost * :Silent <args>
" Same, but show the result in foreground and have you press Return when it's done
:command -nargs=1 ArchExecOnWriteFG autocmd BufWritePost * !<args>
:command ArchExecOnWriteStop autocmd! BufWritePost *

" Return neovim to normal vim behavior
" Don't jump all over the place when searching
:set noincsearch
" Don't replace highlighting on search results
:set nohlsearch
" Don't randomly shrink cursor depending on mode
:set guicursor=
" Don't use new color scheme due to multiple readability issues
if has('nvim')
	:set notermguicolors
	:colorscheme vim
endif

" Disable syntax highlighting if using vimdiff mode,
" since colors tend to conflict lol
if &diff
	syntax off
endif
