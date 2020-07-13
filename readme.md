# 要求
1. vim/nvim
- vim >= 8.1 且 enable +python feature
- nvim >= 0.3.0
2. python >= 3.6.1
3. nodejs >= 10.12

## 施工说明

#### 1. ccls(lsp backend)
参考https://github.com/MaskRay/ccls/wiki/Build

#### 2. 安装vim插件管理器(这里用的vim-plug，方便且速度快)
1. nvim: `cp third/plug.vim ~/.local/share/nvim/site/autoload/`
2. vim: `cp third/plug.vim ~/.vim/autoload/`

#### 3. 拷贝vim配置文件
nvim:
  1. `cp init.vim ~/.config/nvim/`
  2. `cp coc-settings.json ~/.config/nvim/`

vim:
  1. `cp init.vim ~/.vimrc`
  2. `cp coc-settings.json `

#### 4. 安装插件
`:PlugInstall`

#### 5. 安装插件依赖
`pip3 install --user pynvim` // 文件管理器defx需要这个Python包

#### 6. 安装插件coc.vim的插件(目前我只用了coc-lists)
> coc.vim作为vim的插件，也拥有自己的插件系统，所以coc的插件也就是插件的插件

`:CocInstall coc-lists`

## 关于快捷键
leader key是空格
coc预览窗口上翻和下翻：`C-j` 和 `C-k`
#### 各种跳转
跳转到定义：`gd`
回跳：`C-o`
全局查找符号：`<leader>s`
全局查找文件：`<leader>g`
显示当前文件的outline：`<leader>o`
全局替换符号：`<leader>rn`
显示已打开的文件列表：`<leader>b`
#### defx
打开/关闭文件树：`<leader>ff`
打开文件以及展开/合并文件夹: `o`

详见init.vim

## 补充说明
ccls会在项目根目录查找`compile_commands.json`(通过`cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1`生成)，所以推荐做法是将build目录的`compile_commands.json`软链接到项目根目录。

`ln -s build/compile_commands.json .`

