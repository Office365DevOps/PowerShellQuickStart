# 创建和注册应用程序 
# 作者：陈希章
# 依赖项，请通过web platform installer 安装azure ad powershell (2017/2/22)
# Install-Module AzureAD


param(
    [pscredential]$credential,
    [bool]$IsGallatin=$true
)
if ($IsGallatin) {
    Connect-AzureAD -AzureEnvironmentName AzureChinaCloud -Credential $credential
}
else {
    Connect-AzureAD -Credential $credential
}


Get-AzureADApplication | Where-Object {$_.DisplayName -eq "nativeapplication"} | Remove-AzureADApplication

$app= New-AzureADApplication -DisplayName "nativeapplication"  -ReplyUrls "https://developer.microsoft.com/en-us/graph/" -PublicClient $true
# 如果创建web application，则还需要有homeurl，identifierUrl等信息
Write-Output "AppId:"$app.AppId
Write-Output "ReplyUrl:"$app.ReplyUrls

#$graphservice = Get-AzureADServicePrincipal -ObjectId 3319d71d-8dfc-42ff-8fa0-0aa64f553350 #Microsoft Graph

$graphrequest = New-Object -TypeName "Microsoft.Open.AzureAD.Model.RequiredResourceAccess"
$graphrequest.ResourceAccess = New-Object -TypeName "System.Collections.Generic.List[Microsoft.Open.AzureAD.Model.ResourceAccess]"
$ids =@("024d486e-b451-40bb-833d-3e66d98c5c73","e383f46e-2787-4529-855e-0e479a3ffac0","e1fe6dd8-ba31-4d61-89e7-88639da4683d","b340eb25-3456-403f-be2f-af7a0d370277")
foreach($id in $ids){
    $obj = New-Object -TypeName "Microsoft.Open.AzureAD.Model.ResourceAccess" -ArgumentList $id,"Scope"
    $graphrequest.ResourceAccess.Add($obj)
}
$graphrequest.ResourceAppId = "00000003-0000-0000-c000-000000000000"


#$sposervice = Get-AzureADServicePrincipal -ObjectId 2ab85e47-1ba1-4948-9a95-f16eef6215aa # office 365 sharepoint online
$sporequest = New-Object -TypeName "Microsoft.Open.AzureAD.Model.RequiredResourceAccess"
$sporequest.ResourceAccess = New-Object -TypeName "System.Collections.Generic.List[Microsoft.Open.AzureAD.Model.ResourceAccess]"
$obj =New-Object -TypeName "Microsoft.Open.AzureAD.Model.ResourceAccess" -ArgumentList 2cfdc887-d7b4-4798-9b33-3d98d6b95dd2,"Scope"
$sporequest.ResourceAccess.add($obj)
$sporequest.ResourceAppId = "00000003-0000-0ff1-ce00-000000000000"



Set-AzureADApplication -ObjectId $app.ObjectId -RequiredResourceAccess ($graphrequest,$sporequest)
#admin consent

#https://login.microsoftonline.com/common/adminconsent?client_id=6731de76-14a6-49ae-97bc-6eba6914391e&state=12345&redirect_uri=http://localhost/myapp/permissions
if ($IsGallatin) {
    Start-Process ("https://login.chinacloudapi.cn/common/adminconsent?client_id="+$app.AppId+"&state=12345&redirect_uri=https://developer.microsoft.com/en-us/graph/")
}
else {
    Start-Process ("https://login.microsoftonline.com/common/adminconsent?client_id="+$app.AppId+"&state=12345&redirect_uri=https://developer.microsoft.com/en-us/graph/")
}



