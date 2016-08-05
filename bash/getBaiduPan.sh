#!/bin/bash
#访问一次百度，取得一个名为BAIDUID的 cookie。
#我们在此，以及以下所有 curl 命令中，都会使用-b和-c选项告诉 curl 从当前目录下的「cookies」文件读取 cookie 数据，把接收到的 cookie 写到同一个文件里去。
BDUSER="lc_treed"
PASS="lctreed@123"
curl -b cookies -c cookies http://www.baidu.com/ -sS -o /dev/null

#获取 token：
TOKEN=$(curl -b cookies -c cookies -sS "https://passport.baidu.com/v2/api/?getapi&tpl=mn&apiver=v3&class=login&tt=$(date +%s860)&logintype=dialogLogin" | tr "'" '"' | jshon -e data -e token -u)
curl -b cookies -c cookies "https://passport.baidu.com/v2/api/?logincheck&token=$TOKEN&tpl=mn&apiver=v3&tt=$(date +%s)&username=$BDUSER&isphone=false"

#加载验证码并显示
codestring="njGbb06e2d867aade9002b914e2de0169135035a6063a010090"
curl "https://passport.baidu.com/cgi-bin/genimage?$codestring" | imgcat
read -p "输入验证码：" vcode

#使用用户信息登陆：
#curl -b cookies -c cookies --compressed -sS 'https://passport.baidu.com/v2/api/?login' -H 'Content-Type: application/x-www-form-urlencoded' --data "staticpage=http%3A%2F%2Fpan.baidu.com%2Fres%2Fstatic%2Fthirdparty%2Fpass_v3_jump.html&charset=utf-8&token=$TOKEN&tpl=mn&apiver=v3&tt=$(date +%s083)&codestring=$codestring&safeflg=0&u=http%3A%2F%2Fpan.baidu.com%2F&isPhone=false&quick_user=0&logintype=basicLogin&username=$BDUSER&password=$PASS&verifycode=$vcode&mem_pass=on&ppui_logintime=57495&callback=parent.bd__pcbs__ax1ysj" | grep -F 'err_no=0' > /dev/null
curl -b cookies -c cookies --compressed -sS 'https://passport.baidu.com/v2/api/?login' -H 'Content-Type: application/x-www-form-urlencoded' --data "staticpage=http%3A%2F%2Fpan.baidu.com%2Fres%2Fstatic%2Fthirdparty%2Fpass_v3_jump.html&charset=utf-8&token=$TOKEN&tpl=mn&apiver=v3&tt=$(date +%s083)&codestring=$codestring&safeflg=0&u=http%3A%2F%2Fpan.baidu.com%2F&isPhone=false&quick_user=0&logintype=basicLogin&username=$BDUSER&password=$PASS&verifycode=$vcode&mem_pass=on&ppui_logintime=57495&callback=parent.bd__pcbs__ax1ysj" | grep -F 'err_no=0' > /dev/null
curl -b cookies -c cookies -v --referer 'https://pan.baidu.com/' --user-agent 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2817.0 Safari/537.36' 'https://pan.baidu.com/api/quota' -H 'Content-Type: text/html' 


