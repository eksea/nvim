call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'ayu-theme/ayu-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
Plug 'preservim/nerdcommenter'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'NLKNguyen/papercolor-theme'

call plug#end()

" ================================ eksea config begin ================================

" set termguicolors
" let ayucolor="light"
colorscheme PaperColor

set tabstop=2
set softtabstop=0 expandtab
set shiftwidth=2

" syntax on
" inoremap jk <esc>
set number
set encoding=utf-8
" use space as leader key
let mapleader = " "
set cursorline
highlight CursorLine term=bold cterm=bold guibg=#073e5b ctermbg=0

inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

packadd termdebug
let g:termdebug_wide=163
" nnoremap <leader>td :Termdebug<cr>
nnoremap <f5> :Termdebug<cr>
tnoremap <esc> <c-\><c-n>

" ================================ eksea config end ================================
nnoremap <leader>t :terminal<CR>

" ================================ commenter config end ================================
let g:NERDCreateDefaultMappings=0
let g:NERDSpaceDelims=1
nnoremap <leader>cc :call nerdcommenter#Comment(0, "toggle")<CR>
vnoremap <leader>cc :call nerdcommenter#Comment(0, "toggle")<CR>
" ================================ commenter config end ================================

" ================================ leaderF config begin ================================
nnoremap <leader>f :LeaderfFile<CR>
nnoremap <leader>b :LeaderfBuffer<CR>
" ================================ leaderF config end ================================

" ================================ git config begin ================================
highlight DiffAdd    cterm=bold ctermfg=161 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=161 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=161 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=161 ctermbg=17 gui=none guifg=bg guibg=Red
" ================================ git config end ================================

" ================================ ack config begin ================================
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" 不自动打开第一个搜索结果
cnoreabbrev Ack Ack!
nnoremap <leader>a :Ack<space>
nnoremap <leader>gf :AckFile<space>
" ================================ ack config end ================================

" ================================ defx config begin ================================
nnoremap <silent> <leader>dd :Defx<CR>
call defx#custom#option('_', {
      \ 'winwidth': 35,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 1,
      \ 'buffer_name': '',
      \ 'toggle': 1,
      \ 'resume': 1
      \ })

autocmd FileType defx call s:defx_mappings()

function! s:defx_mappings() abort
  " the action 'open' will open the file on the defx panel
  " nnoremap <silent><buffer><expr> f     defx#do_action('open')
  nnoremap <silent><buffer><expr> o     <SID>defx_toggle_tree()
  " the action 'search' doesn't work
  nnoremap <silent><buffer><expr> g     defx#do_action('search')
  nnoremap <silent><buffer><expr> sv     defx#do_action('drop', 'vsplit')
  nnoremap <silent><buffer><expr> ss     defx#do_action('drop', 'split')
  nnoremap <silent><buffer><expr> m     defx#do_action('rename')
  nnoremap <silent><buffer><expr> d     defx#do_action('remove')
  nnoremap <silent><buffer><expr> c     defx#do_action('new_file')
  nnoremap <silent><buffer><expr> C     defx#do_action('new_directory')
endfunction

function! s:defx_toggle_tree() abort
  if defx#is_directory()
    return defx#do_action('open_or_close_tree')
  endif
  return defx#do_action('multi', ['drop'])
endfunction
" ================================ defx config end ================================


" ================================ coc.vim config begin ================================
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
"if exists('*complete_info')
"  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"else
"  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"endif
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
let g:AutoPairsMapCR = 0


" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" 暂时没用到，把快捷键<leader>a让给ag用
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
" nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
" nnoremap <silent> <leader>d  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <leader>gc  :<C-u>CocList <cr>
nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>
" Show buffers
" nnoremap <silent> <leader>b :<C-u>CocList buffers<cr>
" search files
nnoremap <silent> <leader>gg :<C-u>CocList files<cr>
" ================================ coc.vim config end ================================
