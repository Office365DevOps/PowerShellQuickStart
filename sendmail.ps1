# 发送邮件
# 执行此脚本之前请确保将所有用户的密码重置为pass@Word1

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

#读取这个tenant里面所有的用户信息
$token =Get-Office365Token -AADTenant $tenant -IsGallatin $IsGallatin -ClientId $appId -Credential $credential

if ($IsGallatin) {
  $endpoint ="https://microsoftgraph.chinacloudapi.cn/v1.0/"
}
else {
  $endpoint ="https://graph.microsoft.com/v1.0/"
}

$to = $credential.UserName

$body=@"
{
  "message": {
    "subject": "Greeting from Graph API",
    "body": {
      "contentType": "HTML",
      "content": "This is a sample email via Graph API"
    },
    "toRecipients": [
      {
        "emailAddress": {
          "address": "$to"
        }
      }
    ]
  },
  "saveToSentItems": "true"
}
"@
$url = $endpoint + "me/sendMail"
Invoke-Office365GraphRequest -url $url -Token $token -Method POST -Body $body