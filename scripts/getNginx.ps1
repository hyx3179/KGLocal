param($Out)
$nginxUrl = "https://gitee.com/hyx3179/cat-zh/attach_files/1031881/download/nginx-1.21.6.zip"

Invoke-WebRequest -Uri "$nginxUrl" -OutFile "$Out\nginx.zip"
Expand-Archive -Path "$Out\nginx.zip" -Force -DestinationPath "$Out"