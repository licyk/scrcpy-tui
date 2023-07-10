# scrcpy-tui
一个基于dialog显示的图形化scrcpy脚本，支持全平台  
需要aria2,dialog,scrcpy,adb  
**使用前需要进行环境配置**
# 环境配置  

windows系统安装配置环境的方法：  

1、进入[msys2官网](https://www.msys2.org/)  
在官网“Installation”找到”1、Download the installer:“，点击右边的按钮进行下载并安装  
记下刚刚安装的路径，比如C:\msys64
按下“win+R”快捷键，打开运行对话框，输入指令：  

    sysdm.cpl

打开【系统属性】窗口后，依次点击选项卡【高级】、【环境变量】按钮  
在“系统变量”部分点双击“Path”，点击新建，输入以下路径  

    C:\msys64\mingw64\bin

    C:\msys64\usr\bin

安装好后在windows的开始菜单里找到MSYS2 MINGW64，打开  

2、在msys终端输入  

    sed -i "s#https\?://mirror.msys2.org/#https://mirrors.tuna.tsinghua.edu.cn/msys2/#g" /etc/pacman.d/mirrorlist*

然后输入  

    pacman -Syu dialog

输入y，回车，等待安装完成  
此时完成msys2，和dialog的安装  

3、前往[aira2官网下载](http://aria2.github.io/)，点击“Download version ”进入下载页面，找到“aria2-xx版本-win-64bit-build1.zip ”点击下载，解压得到aria2c.exe  
在系统的某个位置创建一个文件夹，得到一个路径，比如D:\Program Files\aria2，记下来，将aria2c.exe放入文件夹  
按下“win+R”快捷键，打开运行对话框，输入指令：  

    sysdm.cpl  

打开【系统属性】窗口后，依次点击选项卡【高级】、【环境变量】按钮  
在“系统变量”部分点双击“Path”，点击新建，把刚刚记下来的路径粘贴上去，然后一直点确定直至完成  
此时aira2安装完成  

4、前往[scrcpy官网](https://github.com/Genymobile/scrcpy/releases/)下载scrcpy-win64，并解压  
此时把解压的文件放在合适的位置，位置可以自己选，只要能找到就行，比如  
C:\scrcpy  
(文件夹内包括adb.exe和scrcpy.exe)  
记下刚才的位置，在桌面此电脑图标上点击鼠标右键，然后选择“属性”选项  
打开系统窗口后，点击“高级系统设置”选项  
在打开的窗口中，点击“高级”选项卡下“环境变量”  
在“系统变量”部分点双击“Path”，点击新建，输入记下的位置，然后一直点确定直至完成  

Linux，macos可通过指令安装aria2,dialog,scrcpy,adb
# 使用方法  
打开msys2终端，在终端输入一下内容下载scrcpy-tui  

    aria2c https://raw.githubusercontent.com/licyk/scrcpy-tui/main/scrcpy-tui.sh
    chmod u+x scrcpy-tui.sh

运行scrcpy-tui  

    ./scrcpy-tui.sh


如果要打开终端时直接就打开msys2,可以按照以下方法配置：  
1、打开Windows终端设置  
2、点击“添加新配置文件”  
3、在“名称”中填入“MinGW64”  
4、在“命令行”填入“C:\msys64\msys2_shell.cmd -defterm -no-start -use-full-path -here -mingw64”  
（“C:\msys64”为安装目录，根据具体安装的目录修改）  
5、在“启动目录”勾选“使用父进程目录”  
6、在“图标”填入“C:\msys64\mingw64.ico”  
（“C:\msys64”为安装目录，根据具体安装的目录修改）  
7、先保存配置，然后打开"启动"-->"默认配置文件"，选择刚刚配置好的"MInGW64"  
8、保存，关闭终端，再重新打开终端时就默认启动msys2了  
注：windrows10要先在在microsoft store下载windows终端