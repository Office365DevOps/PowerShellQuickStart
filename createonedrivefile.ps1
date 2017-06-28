#在onedrive 根目录下面写一个文件
param(
    [pscredential]$credential,
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

# define a function to repeat use

function DoRequest ($token) {

$files = Get-ChildItem -Path . -Include *.pptx 

if($files){
  $rnd = Get-Random -Minimum 0 -Maximum $files.Count
  $file = $(Get-Date -Format yyyyMMddhhmmss)+"-"+$files[$rnd].Name

$body =@"
{
  "name":"$file",
  "file":{}
}
"@
# create a file
$url = $endpoint + "me/drive/root/children"
Invoke-Office365GraphRequest -url $url -Token $token -Method POST -Body $body


# udpate the file
$filepath = $endpoint +"me/drive/root:/" + $file +":/content"
Invoke-Office365GraphRequest -url $filepath -Token $token -Method PUT -file $files[$rnd].FullName -contentType "application/vnd.openxmlformats-officedocument.presentationml.presentation"


}
}


$token =Get-Office365Token -AADTenant $tenant -IsGallatin $IsGallatin -ClientId $appId -Credential $credential

DoRequest -token $token

