param($Out)
$nummoncalcUrl = "https://petercheney.gitee.io/nummoncalc/NummonCalc.js"
$scientistsUrl = "https://petercheney.gitee.io/scientists/kitten-scientists.user.js"
$scientistsInfUrl = "https://petercheney.gitee.io/cheney/kitten-scientists.user.js"
# $scientistshyxUrl = https://github.com/hyx3179/cat-zh-load-old/raw/master-hyx/scientists/kitten-scientists.user.js

Invoke-WebRequest -Uri "$nummoncalcUrl" -OutFile "$Out..\html\NummonCalc\NummonCalc.js"
Invoke-WebRequest -Uri "$scientistsUrl" -OutFile "$Out..\html\scientists\kitten-scientists.user.js"
Invoke-WebRequest -Uri "$scientistsInfUrl" -OutFile "$Out..\html\scientists-inf\kitten-scientists.user.js"
# Invoke-WebRequest -Uri "$scientistshyxUrl" -OutFile "$Out..\html\scientists-hyx3179\kitten-scientists.user.js"