# PowerShell QuickStart for Office 365 Graph API 
> 作者: 陈希章 时间：2017年6月28日

## 案例概述

Office 365 Graph API提供了强大和灵活的功能，可以使得开发人员或者IT管理员充分利用Office 365所提供的能力及数据，实现业务或者管理应用的集成。这个QuickStart的目的是用简单的方式，带领IT 管理员使用PowerShell快速创建一个应用程序，并且通过一个封装好的模块，实现Graph API的调用。

## 前提条件

很显然，你还需要有一个可以用来做测试的Office 365租户。以上案例既支持国际版Office 365，也支持国内版Office 365，请确保你拥有管理员账号和密码，并至少创建一个普通用户账号，同时确保该账号拥有Exchagne Online和SharePoint Online的订阅。（建议申请Office 365 E3试用版）。

要运行这个案例，请检查并且准备如下的软件环境
1. Windows 10 或者 Windows Server 2016
2. 下载安装官方提供的Microsoft Online Service Sign-in Assistant for IT Professionals https://go.microsoft.com/fwlink/p/?LinkId=286152 
3. 下载安装官方提供的Azure Active Directory Connection http://connect.microsoft.com/site1164/Downloads/DownloadDetails.aspx?DownloadID=59185 
4. 下载安装官方提供的SharePoint Online Management Shell https://www.microsoft.com/en-us/download/details.aspx?id=35588 
5. 安装一个自定义PowerShell模块  Office365GraphAPI https://www.powershellgallery.com/packages/Office365GraphAPI  请在本地用管理员身份打开PowerShell，并运行命令 Install-Module -Name Office365GraphAPI
6. 安装Azure AD PowerShell 模块， 请在本地用管理员身份打开PowerShell，并运行命令 Install-Module AzureAD


## 使用说明

### 创建应用程序。

应用程序是调用Graph API的先决条件，createapplication.ps1 这个脚本会通过管理员身份连接到Azure创建应用程序，并且分配好相关的权限。请在当前目录打开PowerShell窗口，执行下面的命令

```
$credential = Get-Credential
# 此时会弹出一个对话框，请输入管理员账号和密码

# 如果你申请的是国际版的租户，请执行下面的命令
.\createapplication.ps1 -credential $credential -IsGallatin $false

# 如果你申请的是国内版的租户，请执行下面的命令
.\createapplication.ps1 -credential $credential


# 请注意留意PowerShell窗口的输出结果，并且将appid这一行信息复制下来
# 关闭当前PowerShell窗口

```

### 发送邮件

准备好了应用程序之后，就等于拿到了通过Graph的钥匙。下面我们将模拟普通用户来发送邮件。请在当前目录打开一个新的PowerShell窗口，执行下面的命令

```
$credential = Get-Credential
# 此时会弹出一个对话框，请输入普通用户账号和密码

# 如果你申请的是国际版的租户，请执行下面的命令
.\sendmail.ps1 -credential $credential -IsGallatin $false -appId "你在第一步复制得到的appid"

# 如果你申请的是国内版的租户，请执行下面的命令
.\sendmail.ps1 -credential $credential  -appId "你在第一步复制得到的appid"


# 请检查收件箱，该邮件是发送给自己的
# 请不要关闭当前PowerShell窗口

```

### 接收邮件

请通过下面的脚本来测试邮件接收

```
# 如果你申请的是国际版的租户，请执行下面的命令
.\readmail.ps1 -credential $credential -IsGallatin $false -appId "你在第一步复制得到的appid"

# 如果你申请的是国内版的租户，请执行下面的命令
.\readmail.ps1 -credential $credential  -appId "你在第一步复制得到的appid"

# 请不要关闭当前PowerShell窗口


```

### 上传文件

请通过下面的脚本来测试文件上传，默认情况下我们会将当前目录下面这个Office365GraphAPI.pptx上传到OneDrive 的根目录
> 请注意，在执行这个脚本之前，请用你想用来做测试的用户账号，登录一下自己的OneDrive，确保网站是可以打开的

```
# 如果你申请的是国际版的租户，请执行下面的命令
.\createonedrivefile.ps1 -credential $credential -IsGallatin $false -appId "你在第一步复制得到的appid"

# 如果你申请的是国内版的租户，请执行下面的命令
.\createonedrivefile.ps1 -credential $credential  -appId "你在第一步复制得到的appid"

# 请到自己的OneDrive中查看文件

```