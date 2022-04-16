param($Out)
$catzhUrl = "https://gitee.com/hyx3179/cat-zh/attach_files/1031755/download/cat-zh.zip"

Invoke-WebRequest -Uri "$catzhUrl" -OutFile "$Out\cat-zh.zip"
Expand-Archive -Path "$Out\cat-zh.zip" -Force -DestinationPath "$Out..\html\"