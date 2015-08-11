# clang_complete-getopts-cocos2dx

vimでcocos2d-xを補完するためのplugin
[tokoromさんのclang_complete-getopts-ios](https://github.com/tokorom/clang_complete-getopts-ios)の設定をいじっただけです

## Required

- glfwがないと怒られるかもしれません

```
$ brew tap homebrew/versions
$ brew install —build-bottle —static glfw3
```

- [clang_complete](https://github.com/Rip-Rip/clang_complete)

## Usage

- .vimrcに下記
```
NeoBundle 'git@github.com:Rip-Rip/clang_complete.git'
NeoBundle 'hanana0501/clang_complete-getopts-cocos2dx'
" 下記は環境によって変わります
let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib"
let g:clang_auto_user_options = 'path, .clang_complete, cocos2dx'
```

## Notice

- まだobjc,objc++は対応できてません
