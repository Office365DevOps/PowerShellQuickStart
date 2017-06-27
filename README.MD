# PowerShell QuickStart for Office 365 Graph API 
> 作者: 陈希章 时间：2017年6月28日

## 案例概述

Office 365 Graph API提供了强大和灵活的功能，可以使得开发人员或者IT管理员充分利用Office 365所提供的能力及数据，实现业务或者管理应用的集成。这个QuickStart的目的是用简单的方式，带领IT 管理员使用PowerShell快速创建一个应用程序，并且通过一个封装好的模块，实现Graph API的调用。

## 前提条件

要运行这个案例，请检查并且准备如下的软件环境
1. Windows 10 或者 Windows Server 2016
2. 下载安装官方提供的Microsoft Online Service Sign-in Assistant for IT Professionals https://go.microsoft.com/fwlink/p/?LinkId=286152 
3. 下载安装官方提供的Azure Active Directory Connection http://connect.microsoft.com/site1164/Downloads/DownloadDetails.aspx?DownloadID=59185 
4. 下载安装官方提供的SharePoint Online Management Shell https://www.microsoft.com/en-us/download/details.aspx?id=35588 
5. 安装一个自定义PowerShell模块  Office365GraphAPI https://www.powershellgallery.com/packages/Office365GraphAPI/1.0.4  请在本地用管理员身份打开PowerShell，并运行命令 Install-Module -Name Office365GraphAPI


很显然，你还需要有一个可以用来做测试的Office 365租户。以上案例既支持国际版Office 365，也支持国内版Office 365，请确保你拥有管理员账号和密码，并至少创建一个普通用户账号。


## 使用说明
