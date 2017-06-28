# 批量读取邮件，使用Microsoft Graph
# 需要权限 Mail.Read 或 Mail.ReadWrite
# 该脚本必须在Windows 10 或者Windows Server 2016执行

# 
param(
    [PSCredential]$credential,
    [String]$appId="xxxxxxx",
    [bool]$IsGallatin=$true
)

if ($appId -eq "xxxxxxx") {
  Write-Host "Please provider appid then try again"
  return
}

$tenant = $credential.UserName.Split('@')[1]

if ($IsGallatin) {
  $endpoint ="https://microsoftgraph.chinacloudapi.cn/v1.0/"
}
else {
  $endpoint ="https://graph.microsoft.com/v1.0/"
}


$token =Get-Office365Token -AADTenant $tenant -IsGallatin $IsGallatin -ClientId $appId  -Credential $credential
$url = $endpoint +"me/messages"
Invoke-Office365GraphRequest -url $url -Token $token -Method GET
