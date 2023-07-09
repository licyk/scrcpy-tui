#!/bin/bash

#初始化函数
echo "初始化中..."

function mainmenu()
{
	mainmenu_=$(
		dialog --clear --title "Scrcpy-TUI" --menu "请选择要进行的操作" 20 60 10 \
			"1" "连接新设备" \
			"2" "查看已连接设备" \
			"3" "启动投屏" \
			"4" "更新脚本" \
			"5" "关于" \
			"6" "退出" \
			3>&1 1>&2 2>&3	)

	if [ $? = 0 ];then #选择了确认
		if [ $mainmenu_ = 1 ];then
			new_connect
		fi

		if [ $mainmenu_ = 2 ];then
			list_connected
		fi

		if [ $mainmenu_ = 3 ];then
			start_scrcpy
		fi

		if [ $mainmenu_ = 4 ];then
			update_script
		fi

		if [ $mainmenu_ = 5 ];then
			about_script
		fi

		if [ $mainmenu_ = 6 ];then
			exit
		fi

	else
		exit
	fi

}

#连接新设备界面
function new_connect()
{
	new_connect_=$(dialog --clear --title "设备连接" --inputbox "请输入要连接的设备的ip和端口\n格式(冒号必须为英文的冒号)：\n192.168.1.123:5555" 20 60 3>&1 1>&2 2>&3)
	if [ $? = 0 ];then
		adb connect $new_connect_
	fi
	mainmenu
}

#已连接设备列表界面
function list_connected()
{
	list_devices=$(adb devices | awk 'NR > 1' )

	list_connected_=$(dialog --clear --title "设备列表" \
					--menu "请选择要操作的设备" 20 60 10 \
					"返回" "<--" \
					$list_devices \
					3>&1 1>&2 2>&3)
	
	if [ $? = 0 ];then
		if [ $list_connected_ = "返回" ];then
			mainmenu
		else
			list_connected_option=$(dialog --clear --title "设备列表" --menu "请选择对设备进行的操作" 20 60 10 \
						"1" "启用设备远程调试" \
						"2" "断开设备连接" \
						3>&1 1>&2 2>&3)
			if [ $list_connected_option = 1 ];then
				adb -s $list_connected_ tcpip 5555
			fi

			if [ $list_connected_option = 2 ];then
				adb disconnect $list_connected_
			fi
		fi
	fi
	mainmenu
}

#选择设备界面
function start_scrcpy()
{
	#这个是显示参数
	scrcpy_option_1="60"
	scrcpy_option_2="30"
	scrcpy_option_3="禁用"
	scrcpy_option_4="禁用"
	scrcpy_option_5="禁用"
	scrcpy_option_6="禁用"
	scrcpy_option_7="禁用"
	scrcpy_option_8="禁用"
	scrcpy_option_9="禁用"
	scrcpy_option_10="禁用"
	scrcpy_option_11="输出"
	scrcpy_option_12="禁用"
	scrcpy_option_13="禁用"
	scrcpy_option_14="禁用"
	scrcpy_option_15="禁用"
	scrcpy_option_16="禁用"
	scrcpy_option_17="禁用"

	#为start_option_panel函数声明变量
	declare -g start_scrcpy_option_1="--max-fps $scrcpy_option_1"
	declare -g start_scrcpy_option_2="--video-bit-rate $scrcpy_option_2"m""
	declare -g scrcpy_option_1_="$scrcpy_option_1"
	declare -g scrcpy_option_2_="$scrcpy_option_2"
	declare -g scrcpy_option_3_="$scrcpy_option_3"
	declare -g scrcpy_option_4_="$scrcpy_option_4"
	declare -g scrcpy_option_5_="$scrcpy_option_5"
	declare -g scrcpy_option_6_="$scrcpy_option_6"
	declare -g scrcpy_option_7_="$scrcpy_option_7"
	declare -g scrcpy_option_8_="$scrcpy_option_8"
	declare -g scrcpy_option_9_="$scrcpy_option_9"
	declare -g scrcpy_option_10_="$scrcpy_option_10"
	declare -g scrcpy_option_11_="$scrcpy_option_11"
	declare -g scrcpy_option_12_="$scrcpy_option_12"
	declare -g scrcpy_option_13_="$scrcpy_option_13"
	declare -g scrcpy_option_14_="$scrcpy_option_14"
	declare -g scrcpy_option_15_="$scrcpy_option_15"
	declare -g scrcpy_option_16_="$scrcpy_option_16"
	declare -g scrcpy_option_17_="$scrcpy_option_17"

	list_devices=$(adb devices | awk 'NR > 1' ) #读取设备连接码

	#列出设备连接码
	start_scrcpy_=$(dialog --clear --title "连接选项" \
			--menu "清选择要连接的设备" 20 60 10 \
			"返回" "<--" \
			$list_devices \
			3>&1 1>&2 2>&3)


	if [ $? = 0 ];then #选择了一个设备
		declare -g start_scrcpy__="$start_scrcpy_" #传递设备连接码给tart_option_panel函数
		if [ $start_scrcpy_ = "返回" ];then
			mainmenu
		else
			start_option_panel
		fi
	else
		mainmenu
	fi
}

#连接参数设置
function start_option_panel()
{

	start_option_panel_=$(dialog --clear --title "连接选项" \
				--menu "请设置启动选项\n选择的设备是："$start_scrcpy__"" 20 60 10 \
				"0" "开始连接" \
				"1" "最大帧率:"$scrcpy_option_1_"FPS" \
				"2" "画面码率:"$scrcpy_option_2_"M" \
				"3" "置顶窗口:"$scrcpy_option_3_"" \
				"4" "运行时禁用屏保:"$scrcpy_option_4_"" \
				"5" "Ctrl+v粘贴:"$scrcpy_option_5_"" \
				"6" "禁用设备控制:"$scrcpy_option_6_"" \
				"7" "不显示设备:"$scrcpy_option_7_"" \
				"8" "拖动传输文件:"$scrcpy_option_8_"" \
				"9" "显示触摸反馈:"$scrcpy_option_9_"" \
				"10" "启用屏幕录制:"$scrcpy_option_10_"" \
				"11" "选择音频源:"$scrcpy_option_11_"" \
				"12" "关闭时断开adb连接:"$scrcpy_option_12_"" \
				"13" "模拟物理键盘:"$scrcpy_option_13_"" \
				"14" "模拟物理鼠标:"$scrcpy_option_14_"" \
				"15" "禁用音频转发:"$scrcpy_option_15_"" \
				"16" "OTG模式:"$scrcpy_option_16_"" \
				"17" "RAW输入模式:"$scrcpy_option_17_"" \
				3>&1 1>&2 2>&3)
	
	if [ $? = 0 ];then
		if [ $start_option_panel_ = 0 ];then #退出启动参数设置界面，启动scrcpy
			rec_name=$(date "+%Y-%m-%d-%H-%M-%S") #生成录制视频名称
			nohup scrcpy --serial $start_scrcpy__ $start_scrcpy_option_1 $start_scrcpy_option_2 $start_scrcpy_option_3 $start_scrcpy_option_4 $start_scrcpy_option_5 $start_scrcpy_option_6 $start_scrcpy_option_7 $start_scrcpy_option_8 $start_scrcpy_option_9 $start_scrcpy_option_10 $start_scrcpy_option_11 $start_scrcpy_option_12 $start_scrcpy_option_13 $start_scrcpy_option_14 $start_scrcpy_option_15 $start_scrcpy_option_16 $start_scrcpy_option_17 &
			#显示进度条
			{	for((x=1;x<=10;x++))
			do
			let X=10*x
				echo $X
				sleep 0.15
			done
			} | dialog --gauge "正在启动scrcpy中..." 20 60
			#完成后回到主界面
			mainmenu
		else #未选择启动

		#判断选择修改的参数
			if [ $start_option_panel_ = 1 ];then
				scrcpy_option_1_=$(dialog --clear --title "设备连接" --inputbox "请输入要设置的帧率，默认为60帧" 60 20 60 3>&1 1>&2 2>&3)
				start_scrcpy_option_1="--max-fps $scrcpy_option_1_"
			fi

			if [ $start_option_panel_ = 2 ];then
				scrcpy_option_2_=$(dialog --clear --title "设备连接" --inputbox "请输入要设置的画面码率，默认为30M" 60 20 30 3>&1 1>&2 2>&3)
				start_scrcpy_option_2="--video-bit-rate $scrcpy_option_2_"m""
			fi

			if [ $start_option_panel_ = 3 ];then
				if [ $scrcpy_option_3_ = "禁用" ];then
					scrcpy_option_3_="启用"
					start_scrcpy_option_3="--always-on-top"
				else
					scrcpy_option_3_="禁用"
					start_scrcpy_option_3=""
				fi
			fi

			if [ $start_option_panel_ = 4 ];then
				if [ $scrcpy_option_4_ = "禁用" ];then
					scrcpy_option_4_="启用"
					start_scrcpy_option_4="--disable-screensaver"
				else
					scrcpy_option_4_="禁用"
					start_scrcpy_option_4=""
				fi
			fi

			if [ $start_option_panel_ = 5 ];then
				if [ $scrcpy_option_5_ = "禁用" ];then
					scrcpy_option_5_="启用"
					start_scrcpy_option_5="--legacy-paste"
				else
					scrcpy_option_5_="禁用"
					start_scrcpy_option_5=""
				fi
			fi

			if [ $start_option_panel_ = 6 ];then
				if [ $scrcpy_option_6_ = "禁用" ];then
					scrcpy_option_6_="启用"
					start_scrcpy_option_6="--no-control"
				else
					scrcpy_option_6_="禁用"
					start_scrcpy_option_6=""
				fi
			fi

			if [ $start_option_panel_ = 7 ];then
				if [ $scrcpy_option_7_ = "禁用" ];then
					scrcpy_option_7_="启用"
					start_scrcpy_option_7="--no-display"
				else
					scrcpy_option_7_="禁用"
					start_scrcpy_option_7=""
				fi
			fi

			if [ $start_option_panel_ = 8 ];then
				if [ $scrcpy_option_8_ = "禁用" ];then
					scrcpy_option_8_="启用"
					start_scrcpy_option_8="--push-target /sdcard/"
				else
					scrcpy_option_8_="禁用"
					start_scrcpy_option_8=""
				fi
			fi

			if [ $start_option_panel_ = 9 ];then
				if [ $scrcpy_option_9_ = "禁用" ];then
					scrcpy_option_9_="启用"
					start_scrcpy_option_9="--show-touches"
				else
					scrcpy_option_9_="禁用"
					start_scrcpy_option_9=""
				fi
			fi
			
			if [ $start_option_panel_ = 10 ];then
				if [ $scrcpy_option_10_ = "禁用" ];then
					scrcpy_option_10_="启用"
					start_scrcpy_option_10="--record "$rec_name".mp4"
				else
					scrcpy_option_10_="禁用"
					start_scrcpy_option_10=""
				fi
			fi
			
			if [ $start_option_panel_ = 11 ];then
				if [ $scrcpy_option_11_ = "输出" ];then
					scrcpy_option_11_="麦克风"
					start_scrcpy_option_11="--audio-source=mic"
				else
					scrcpy_option_11_="输出"
					start_scrcpy_option_11=""
				fi
			fi

			if [ $start_option_panel_ = 12 ];then
				if [ $scrcpy_option_12_ = "禁用" ];then
					scrcpy_option_12_="启用"
					start_scrcpy_option_12="--kill-adb-on-close"
				else
					scrcpy_option_12_="禁用"
					start_scrcpy_option_12=""
				fi
			fi

			if [ $start_option_panel_ = 13 ];then
				if [ $scrcpy_option_13_ = "禁用" ];then
					scrcpy_option_13_="启用"
					start_scrcpy_option_13="--hid-keyboard"
				else
					scrcpy_option_13_="禁用"
					start_scrcpy_option_13=""
				fi
			fi

			if [ $start_option_panel_ = 14 ];then
				if [ $scrcpy_option_14_ = "禁用" ];then
					scrcpy_option_14_="启用"
					start_scrcpy_option_14="--hid-mouse"
				else
					scrcpy_option_14_="禁用"
					start_scrcpy_option_14=""
				fi
			fi

			if [ $start_option_panel_ = 15 ];then
				if [ $scrcpy_option_15_ = "禁用" ];then
					scrcpy_option_15_="启用"
					start_scrcpy_option_15="--no-audio"
				else
					scrcpy_option_15_="禁用"
					start_scrcpy_option_15=""
				fi
			fi

			if [ $start_option_panel_ = 16 ];then
				if [ $scrcpy_option_16_ = "禁用" ];then
					scrcpy_option_16_="启用"
					start_scrcpy_option_16="--otg"
				else
					scrcpy_option_16_="禁用"
					start_scrcpy_option_16=""
				fi
			fi

			if [ $start_option_panel_ = 17 ];then
				if [ $scrcpy_option_17_ = "禁用" ];then
					scrcpy_option_17_="启用"
					start_scrcpy_option_17="--raw-key-events"
				else
					scrcpy_option_17_="禁用"
					start_scrcpy_option_17=""
				fi
			fi

			#设置完参数后再回到设置界面
			start_option_panel
		fi
	else
		mainmenu
	fi
}

#scrcpy_tui更新选项
function update_script()
{
	if (dialog --clear --title "更新选项" --yes-label "是" --no-label "否" --yesno "更新时是否选择代理" 20 60) then
		aria2c https://ghproxy.com/https://raw.githubusercontent.com/licyk/scrcpy-tui/main/scrcpy-tui.sh -d ./scrcpy-tui-update-tmp/         
		if [ "$?"="0" ];then
			cp -fv ./scrcpy-tui-update-tmp/scrcpy-tui.sh ./
			rm -rfv ./scrcpy-tui-update-tmp
			chmod u+x scrcpy-tui.sh
			if (dialog --clear --title "更新选项" --msgbox "更新成功" 20 60);then
			source ./scrcpy-tui.sh
			fi
		else
			dialog --clear --title "更新选项" --msgbox "更新失败，请重试" 20 60
		fi
	else
		aria2c https://raw.githubusercontent.com/licyk/scrcpy-tui/main/scrcpy-tui.sh -d ./scrcpy-tui-update-tmp/
		if [ "$?"="0" ];then
			cp -fv ./scrcpy-tui-update-tmp/scrcpy-tui.sh ./
			rm -rfv ./scrcpy-tui-update-tmp
			chmod u+x scrcpy-tui.sh
			if (dialog --clear --title "更新选项" --msgbox "更新成功" 20 60);then
			source ./scrcpy-tui.sh
			fi
		else
			dialog --clear --title "更新选项" --msgbox "更新失败，请重试" 20 60
		fi
	fi
	mainmenu
}

#scrcpy-tui信息界面
function about_script()
{
	dialog --clear --title "关于Scrcpy-TUI" --msgbox "Scrcpy-TUI是一个基于终端显示的scrcpy工具，简化scrcpy命令的使用\n
●使用方法：\n
前期准备：\n
1、首先需要开启Android设备的开发者选项和允许USB调试。不同手机型号打开开发者选项的方式也不同，大致有两种方式可以打开开发者选项。\n
1）打开手机找到【设置】-->找到【系统】一栏（有些手机是更多设置）-->选择打开【开发者选项】和启用【USB调试】，推荐启用【“仅充电”模式下允许ADB调试】\n
2）如果找不到开发者选项在哪，可以按照下面的方法找到开发者选项并打开：\n
打开手机找到【设置】-->点击【更多设置】-->点击进入【关于手机】-->找到【版本号】连续点击7次即可开启开发者模式\n
2、手机用usb线连接电脑\n
●使用有线连接：\n
1、在Scrcpy—-TUI选择"查看一连接设备"，确认设备是否连接\n
2、回到主界面，选择"启动投屏"，然后在"设备列表"选择要连接的设备\n
3、在"连接选项"选择需要启用的功能，然后选择"开始连接"连接手机\n
\n
●使用无线连接：\n
注：确保手机和电脑处在同一个局域网中\n
1、在Scrcpy—-TUI选择"查看一连接设备"，选择需要连接的设备，然后选择"启用设备远程调试"，此时手机会打开5555远程调试端口，此时可以断开手机与电脑的usb连接线\n
2、打开手机的设置，在"系统"-->"关于手机"-->"状态信息"查看手机的ip\n
3、回到主界面，选择"连接新设备"，输入手机的ip地址和端口进行连接\n
4、回到主界面，选择"启动投屏"，然后在"设备列表"选择要连接的设备\n
5、在"连接选项"选择需要启用的功能，然后选择"开始连接"连接手机\n
\n
注:\n
手机在重启或重新打开usb调试后需要重新启用手机网络调试\n
手机的ip地址在重启或开关WIFI后会变化，需要重新连接\n
在脚本所在目录会产生nohup.out日志文件\n
\n
\n
●连接选项说明：\n
\n
置顶窗口：\n
将 scrcpy 窗口总是保持在顶层\n
\n
运行时禁用屏保：\n
scrcpy 运行时禁用屏保\n
\n
Ctrl+v粘贴：\n
通过 Ctrl+v 注入计算机剪贴板文本(类似于 MOD+Shift+v)\n
这是一个解决方案,用于处理某些设备无法以预期方式通过程序集设置设备剪贴板\n
\n
禁用设备控制：\n
禁用设备控制(以只读方式镜像设备)\n
\n
不显示设备：\n
不显示设备(只有在启用屏幕录制时)\n
\n
拖动传输文件：\n
设置通过拖放文件到设备的目标目录。它直接传递给 \"adb push\"。默认是 "/sdcard/"\n
\n
显示触摸反馈：\n
启动时启用“显示触摸”,退出时还原初始值。\n
它仅显示物理触摸(而不是 scrcpy 的点击)\n
\n
启用屏幕录制：\n
将屏幕录制到文件,录制文件保存在脚本所在目录\n
\n
最大帧率：\n
限制屏幕捕获的帧率(从 Android 10 开始正式支持,但早期版本也可能工作)\n
\n
画面码率：\n
使用给定的位率编码视频,以比特/秒表示\n
选择音频源;\n
   选择音频源(输出或麦克风)。\n
   默认为输出。\n
\n
关闭时断开adb连接;\n
   当scrcpy结束时关闭adb。\n
\n
模拟物理键盘:\n
   通过HID over AOAv2模拟物理键盘。\n
   它为IME用户提供了更好的体验,并允许生成非ASCII字符,与默认的注入方法相反。\n
   它可能只能通过USB工作。\n
   键盘布局必须在设备上通过“设置” - “系统” - “语言和输入” - “物理键盘”进行配置(一次性配置)。这个设置页面可以直接启动:adb shell am start -a android.settings.HARD_KEYBOARD_SETTINGS。\n
   然而,该选项仅在启用HID键盘时才可用(或连接了物理键盘)。\n
   另请参阅模拟物理鼠标。\n
\n
模拟物理鼠标:\n
   通过使用HID over AOAv2模拟一个物理鼠标。\n
   在这种模式下,计算机鼠标被捕获以直接控制设备(相对鼠标模式)。\n
   LAlt、LSuper或RSuper切换捕获模式,以将鼠标控制权还给计算机。\n
   它可能只能通过USB工作。\n
   另请参阅模拟物理键盘。\n
\n
禁用音频转发:\n
   字面意思。\n
\n
OTG模式:\n
   在OTG模式下运行:模拟物理键盘和鼠标,就像计算机键盘和鼠标直接通过OTG线缆插在设备上一样。\n
   在这种模式下,不需要adb(USB调试),并禁用镜像。\n
   LAlt、LSuper或RSuper切换鼠标捕获模式,以将鼠标控制权还给计算机。\n
   如果设置了模拟物理键盘或模拟物理鼠标中的任何一个,则只启用键盘或鼠标,否则启用两者。\n
   它可能只能通过USB工作。\n
   请参阅模拟物理键盘和模拟物理鼠标。\n
\n
RAW输入模式:\n
   为所有输入键注入键事件,并忽略文本事件。\n
\n
\n
●快捷键：\n
\n
    Alt+f \n
        切换全屏模式\n
    Alt+方向键左键\n
        将显示向左旋转\n
    Alt+方向键右键\n
        将显示向右旋转\n
    Alt+g\n
        将窗口调整为 1:1(像素完美)\n
    Alt+w\n
    在黑边上双击 \n
        调整窗口大小以删除黑边\n
    Alt+h\n
    中键点击\n
        点击主屏幕按钮\n
    Alt+b\n
    Alt+Backspace\n
    右键点击(当屏幕开启时) \n
        点击后退按钮\n
    Alt+s\n
        点击任务切换按钮\n
    Alt+m\n
        点击菜单按钮\n
    Alt+方向键上键\n
        点击音量增加按钮\n
    Alt+方向键下键\n
        点击音量减少按钮\n
    Alt+p\n
        点击电源按钮(打开/关闭屏幕)\n
    右键点击(当屏幕关闭时)\n
        打开电源\n
    Alt+o\n
        关闭设备屏幕(保持镜像)\n
    Alt+Shift+o\n
        打开设备屏幕\n
    Alt+r\n
        旋转设备屏幕\n
    Alt+n\n
        展开通知面板\n
    Alt+Shift+n\n
        收起通知面板\n
    Alt+c\n
        复制到剪贴板(仅Android 7+可用)\n
    Alt+x\n
        剪切到剪贴板(仅Android 7+可用)\n
    Alt+v\n
        复制计算机剪贴板到设备,然后粘贴(仅Android 7+可用)\n
    Alt+Shift+v\n
        将计算机剪贴板内容作为一系列按键事件注入\n
    Alt+i\n
        启用/禁用 FPS 计数器(在日志中打印每秒帧数)\n
    Ctrl+点击并移动\n
        从屏幕中心进行缩放\n
    拖放 APK 文件到Scrcpy窗口\n
        从电脑安装 APK " 20 60
	mainmenu
}

#启动界面
function version_info()
{
	dialog --clear --title "版本信息" --msgbox "Scrcpy-TUI:"$version_info_"\n
dialog:$(dialog --version | awk 'NR==1'| awk -F  ' ' ' {print  " " $2} ') \n
aria2:$(aria2c --version | awk 'NR==1'| awk -F  ' ' ' {print  " " $3} ') \n
scrcpy:$(scrcpy --version | awk 'NR==1' | awk -F  ' ' ' {print  " " $2} ') \n
adb:$(adb version | awk 'NR==1'| awk -F  ' ' ' {print  " " $5} ') \n
提示: \n
使用方向键、Tab键、Enter进行选择，Space键勾选或取消选项 \n
第一次使用Scrcpy-TUI时先在主界面选择“关于”查看使用说明
	" 20 60
	mainmenu
}

###############################################################################

version_info_="0.0.3"
test_num=0

if which dialog > /dev/null ;then
	test_num=$(( $test_num + 1 ))
else
	echo "未安装dialog,请安装后重试"
fi

if which aria2c > /dev/null ;then
	test_num=$(( $test_num + 1 ))
else
	echo "未安装aria2,请安装后重试"
fi

if which scrcpy > /dev/null;then
	test_num=$(( $test_num + 1 ))
else
	echo "未安装scrcpy,请安装后重试"
fi

if which adb >/dev/null;then
	test_num=$(( $test_num + 1 ))
else
	echo "未安装adb,请安装后重试"
fi


if [ $test_num -ge 4 ];then
	echo "初始化Scrcpy-TUI完成"
	echo "启动Scrcpy-TUI中"
	version_info
else
	echo "未满足依赖要求，正在退出"
	exit
fi