
# author: Kylin
# Example:
# userId = 20101020000
# passwd = 123456
# service = "xx电信"

$userId = 
$passwd =  ""
$service = ""

# -------------------------
cd $PSScriptRoot
$Date = Get-Date
echo "[$Date]" >> log
if (!($userId -or $passwd)){
    echo "第一次用之前要设置信息哦！";
    exit 1
}
Try{
$testRequest = (Invoke-WebRequest "http://www.google.cn/generate_204")
$refer = ($testRequest.RawContent -split "'")[1]
$BaseUrl = ($refer -split "\?")[0] -replace "/index.jsp"
echo  $BaseURL
if($testRequest.StatusCode -eq 204){
    echo "已经在线辣！";
    echo " Already login" >> log
    exit 0
}
}
Catch{
    echo "Connection Err"
    exit 2
}
# --------------------------

$loginURL = $BaseUrl + "/InterFace.do?method=login"
$refer = ((($refer -split "\?")[1]) -replace "&","%2526" -replace "=","%253D")
$service = [uri]::EscapeUriString($service)



# Header
$userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36"
$ContentType = "application/x-www-form-urlencoded; charset=UTF-8"
# Body
$body = "userId=$userId&password=$passwd&service=$service&queryString=$refer&operatorPwd=&operatorUserId=&validcode=&passwordEncrypt=false"


# Request
Invoke-WebRequest -Method "POST" -userAgent $userAgent -ContentType $ContentType -Body $body -Uri $loginURL -OutFile err.tmp

# Result
$res = (Get-Content "err.tmp") | ConvertFrom-Json
echo $res.result
if($res.result -ne 'success'){
    echo $res.message
    exit 0
}
echo loginURL: $loginURL Service: $service QueryString: $refer Result: $res.result>> log
rm err.tmp,log
