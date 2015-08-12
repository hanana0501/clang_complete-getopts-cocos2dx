" clang_complete-getopts-cocos2dx - clang_complete plugin that help cocos2d-x programming

" Options  "{{{1

if !exists('g:clang_complete_getopts_cocos2dx_default_options')
  let g:clang_complete_getopts_cocos2dx_default_options = '-fblocks -std=c++11 stdlib=libc++ -w -I /usr/local/Cellar/glfw3/3.1.1/include/GLFW/'
endif

if !exists('g:clang_complete_getopts_cocos2dx_sdk_directory')
  let g:clang_complete_getopts_cocos2dx_sdk_directory = '/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator8.3.sdk'
endif

if !exists('g:clang_complete_getopts_cocos2dx_ignore_directories')
  let g:clang_complete_getopts_cocos2dx_ignore_directories = ['^\.git', '\.xcodeproj', '^build', '\.lproj']
endif

" Public functions "{{{1

function! getopts#cocos2dx#getopts()
  call s:AddDefaultOptions()
  call s:AddSdkOptions()
  call s:AddPreCompiledHeaders()
  call s:AddCurrentDirectoryToIncludePathsRecursively()
endfunction

" Private functions "{{{1

function! s:AddCurrentDirectoryToIncludePathsRecursively()
  let dirs = s:GetDirectoriesRecursively("**")
  call s:AddIncludePathsToUserOptions(dirs)
endfunction

function! s:AddDefaultOptions()
  let b:clang_user_options .= ' ' . g:clang_complete_getopts_cocos2dx_default_options
endfunction

function! s:AddSdkOptions()
  let b:clang_user_options .= ' -isysroot ' . g:clang_complete_getopts_cocos2dx_sdk_directory
  let b:clang_user_options .= ' -F' . g:clang_complete_getopts_cocos2dx_sdk_directory . '/System/Library/Frameworks'
endfunction

function! s:AddPreCompiledHeaders()
  let files = split(glob("**/*.pch"), "\n")
  for file in files
    let opt = '-include "' . file . '"'
    let b:clang_user_options .= ' ' . opt
  endfor
endfunction

function! s:GetDirectoriesRecursively(dirname)
  let files = split(glob(a:dirname), "\n")
  let dirs = []
  for file in files
    if isdirectory(file) && !s:IsIgnoreDirectory(file)
      call add(dirs, file)
    endif
  endfor
  return dirs
endfunction

function! s:AddIncludePathsToUserOptions(dirs)
  let dirs = a:dirs
  for dir in dirs
    let opt = '-I"' . dir . '"'
    let b:clang_user_options .= ' ' . opt
  endfor
endfunction

function! s:IsIgnoreDirectory(dir)
  let dir = a:dir
  let ignore_dirs = g:clang_complete_getopts_cocos2dx_ignore_directories
  for ignore_dir in ignore_dirs
    if dir =~ ignore_dir
      return 1
    endif
  endfor
  return 0
endfunction
