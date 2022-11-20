" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/autoload/custom/colorscheme.vim
" Author: Sainnhe Park
" Email: i@sainnhe.dev
" License: Anti-996 && MIT
" =============================================================================

function custom#colorscheme#everforest_dark() abort "{{{
  let g:everforest_disable_italic_comment = 1
  let g:everforest_enable_italic = g:vim_italicize_keywords
  let g:everforest_lightline_disable_bold = 1
  let g:everforest_better_performance = 1
  set background=dark
  colorscheme everforest
  if g:vim_mode ==# 'full'
    call custom#utils#switch_lightline_color_scheme('everforest')
  endif
endfunction "}}}
function custom#colorscheme#everforest_light() abort "{{{
  let g:everforest_disable_italic_comment = 1
  let g:everforest_enable_italic = g:vim_italicize_keywords
  let g:everforest_lightline_disable_bold = 1
  let g:everforest_better_performance = 1
  set background=light
  colorscheme everforest
  if g:vim_mode ==# 'full'
    call custom#utils#switch_lightline_color_scheme('everforest')
  endif
endfunction "}}}
function custom#colorscheme#gruvbox_material_dark() abort "{{{
  let g:gruvbox_material_background = 'medium'
  let g:gruvbox_material_foreground = 'material'
  let g:gruvbox_material_visual = 'grey background'
  let g:gruvbox_material_cursor = 'green'
  let g:gruvbox_material_disable_italic_comment = 1
  let g:gruvbox_material_enable_italic = g:vim_italicize_keywords
  let g:gruvbox_material_statusline_style = 'mix'
  let g:gruvbox_material_lightline_disable_bold = 1
  let g:gruvbox_material_better_performance = 1
  set background=dark
  colorscheme gruvbox-material
  if g:vim_mode ==# 'full'
    call custom#utils#switch_lightline_color_scheme('gruvbox_material')
  endif
endfunction "}}}
function custom#colorscheme#gruvbox_mix_dark() abort "{{{
  let g:gruvbox_material_background = 'medium'
  let g:gruvbox_material_foreground = 'mix'
  let g:gruvbox_material_visual = 'grey background'
  let g:gruvbox_material_cursor = 'green'
  let g:gruvbox_material_disable_italic_comment = 1
  let g:gruvbox_material_enable_italic = g:vim_italicize_keywords
  let g:gruvbox_material_statusline_style = 'mix'
  let g:gruvbox_material_lightline_disable_bold = 1
  let g:gruvbox_material_better_performance = 1
  set background=dark
  colorscheme gruvbox-material
  if g:vim_mode ==# 'full'
    call custom#utils#switch_lightline_color_scheme('gruvbox_material')
  endif
endfunction "}}}
function custom#colorscheme#gruvbox_material_light() abort "{{{
  let g:gruvbox_material_background = 'soft'
  let g:gruvbox_material_foreground = 'material'
  let g:gruvbox_material_visual = 'green background'
  let g:gruvbox_material_cursor = 'auto'
  let g:gruvbox_material_disable_italic_comment = 1
  let g:gruvbox_material_enable_italic = g:vim_italicize_keywords
  let g:gruvbox_material_statusline_style = 'mix'
  let g:gruvbox_material_lightline_disable_bold = 1
  let g:gruvbox_material_better_performance = 1
  set background=light
  colorscheme gruvbox-material
  if g:vim_mode ==# 'full'
    call custom#utils#switch_lightline_color_scheme('gruvbox_material')
  endif
endfunction "}}}
function custom#colorscheme#edge_dark() abort "{{{
  let g:edge_style = 'aura'
  let g:edge_disable_italic_comment = 1
  let g:edge_enable_italic = g:vim_italicize_keywords
  let g:edge_cursor = 'blue'
  let g:edge_lightline_disable_bold = 1
  let g:edge_better_performance = 1
  set background=dark
  colorscheme edge
  if g:vim_mode ==# 'full'
    call custom#utils#switch_lightline_color_scheme('edge')
  endif
endfunction "}}}
function custom#colorscheme#edge_light() abort "{{{
  let g:edge_style = 'aura'
  let g:edge_disable_italic_comment = 1
  let g:edge_enable_italic = g:vim_italicize_keywords
  let g:edge_cursor = 'purple'
  let g:edge_lightline_disable_bold = 1
  let g:edge_better_performance = 1
  set background=light
  colorscheme edge
  if g:vim_mode ==# 'full'
    call custom#utils#switch_lightline_color_scheme('edge')
  endif
endfunction "}}}
function custom#colorscheme#sonokai() abort "{{{
  let g:sonokai_style = 'default'
  let g:sonokai_disable_italic_comment = 1
  let g:sonokai_enable_italic = g:vim_italicize_keywords
  let g:sonokai_cursor = 'blue'
  let g:sonokai_lightline_disable_bold = 1
  let g:sonokai_better_performance = 1
  set background=dark
  colorscheme sonokai
  if g:vim_mode ==# 'full'
    call custom#utils#switch_lightline_color_scheme('sonokai')
  endif
endfunction "}}}
function custom#colorscheme#sonokai_shusia() abort "{{{
  let g:sonokai_style = 'shusia'
  let g:sonokai_disable_italic_comment = 1
  let g:sonokai_enable_italic = g:vim_italicize_keywords
  let g:sonokai_cursor = 'blue'
  let g:sonokai_lightline_disable_bold = 1
  let g:sonokai_better_performance = 1
  set background=dark
  colorscheme sonokai
  if g:vim_mode ==# 'full'
    call custom#utils#switch_lightline_color_scheme('sonokai')
  endif
endfunction "}}}
function custom#colorscheme#sonokai_andromeda() abort "{{{
  let g:sonokai_style = 'andromeda'
  let g:sonokai_disable_italic_comment = 1
  let g:sonokai_enable_italic = g:vim_italicize_keywords
  let g:sonokai_cursor = 'blue'
  let g:sonokai_lightline_disable_bold = 1
  let g:sonokai_better_performance = 1
  set background=dark
  colorscheme sonokai
  if g:vim_mode ==# 'full'
    call custom#utils#switch_lightline_color_scheme('sonokai')
  endif
endfunction "}}}
function custom#colorscheme#sonokai_atlantis() abort "{{{
  let g:sonokai_style = 'atlantis'
  let g:sonokai_disable_italic_comment = 1
  let g:sonokai_enable_italic = g:vim_italicize_keywords
  let g:sonokai_cursor = 'blue'
  let g:sonokai_lightline_disable_bold = 1
  let g:sonokai_better_performance = 1
  set background=dark
  colorscheme sonokai
  if g:vim_mode ==# 'full'
    call custom#utils#switch_lightline_color_scheme('sonokai')
  endif
endfunction "}}}
function custom#colorscheme#sonokai_maia() abort "{{{
  let g:sonokai_style = 'maia'
  let g:sonokai_disable_italic_comment = 1
  let g:sonokai_enable_italic = g:vim_italicize_keywords
  let g:sonokai_cursor = 'blue'
  let g:sonokai_lightline_disable_bold = 1
  let g:sonokai_better_performance = 1
  set background=dark
  colorscheme sonokai
  if g:vim_mode ==# 'full'
    call custom#utils#switch_lightline_color_scheme('sonokai')
  endif
endfunction "}}}
function custom#colorscheme#sonokai_espresso() abort "{{{
  let g:sonokai_style = 'espresso'
  let g:sonokai_disable_italic_comment = 1
  let g:sonokai_enable_italic = g:vim_italicize_keywords
  let g:sonokai_cursor = 'blue'
  let g:sonokai_lightline_disable_bold = 1
  let g:sonokai_better_performance = 1
  set background=dark
  colorscheme sonokai
  if g:vim_mode ==# 'full'
    call custom#utils#switch_lightline_color_scheme('sonokai')
  endif
endfunction "}}}
function custom#colorscheme#soft_era() abort "{{{
  " {{{Palette
  let g:gruvbox_material_colors_override = {
        \ 'bg_dim':           ['#f2edec',   '223'],
        \ 'bg0':              ['#f9f5f5',   '229'],
        \ 'bg1':              ['#f4f0f0',   '228'],
        \ 'bg2':              ['#f4f0f0',   '228'],
        \ 'bg3':              ['#f2edec',   '223'],
        \ 'bg4':              ['#efeae9',   '223'],
        \ 'bg5':              ['#ebe6e4',   '250'],
        \ 'bg_statusline1':   ['#f4f0f0',   '223'],
        \ 'bg_statusline2':   ['#f4f0f0',   '223'],
        \ 'bg_statusline3':   ['#ebe6e4',   '250'],
        \ 'bg_diff_green':    ['#eaf3ce',   '194'],
        \ 'bg_visual_green':  ['#eaf3ce',   '194'],
        \ 'bg_diff_red':      ['#fae1d7',   '217'],
        \ 'bg_visual_red':    ['#fae1d7',   '217'],
        \ 'bg_diff_blue':     ['#e0f0f3',   '117'],
        \ 'bg_visual_blue':   ['#e0f0f3',   '117'],
        \ 'bg_visual_yellow': ['#f6ead0',   '226'],
        \ 'bg_current_word':  ['#efeae9',   '228'],
        \ 'fg0':              ['#be9898',   '237'],
        \ 'fg1':              ['#be9898',   '237'],
        \ 'red':              ['#f165bd',   '88'],
        \ 'orange':           ['#f165bd',   '130'],
        \ 'yellow':           ['#ec9157',   '136'],
        \ 'green':            ['#96ad01',   '100'],
        \ 'aqua':             ['#25b7b8',   '165'],
        \ 'blue':             ['#75a9d9',   '24'],
        \ 'purple':           ['#aea6e1',   '96'],
        \ 'bg_red':           ['#f165bd',   '88'],
        \ 'bg_green':         ['#96ad01',   '100'],
        \ 'bg_yellow':        ['#ec9157',   '130'],
        \ 'grey0':            ['#e3cbcb',   '246'],
        \ 'grey1':            ['#dfc5c5',   '245'],
        \ 'grey2':            ['#dabfbf',   '243'],
        \ 'none':             ['NONE',      'NONE']
        \ }
  " }}}
  let g:gruvbox_material_background = 'medium'
  let g:gruvbox_material_visual = 'grey background'
  let g:gruvbox_material_cursor = 'auto'
  let g:gruvbox_material_disable_italic_comment = 1
  let g:gruvbox_material_enable_italic = g:vim_italicize_keywords
  let g:gruvbox_material_lightline_disable_bold = 1
  let g:gruvbox_material_better_performance = 1
  set background=light
  colorscheme gruvbox-material
  if g:vim_mode ==# 'full'
    call custom#utils#switch_lightline_color_scheme('gruvbox_material')
  endif
endfunction "}}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
