# Docker for Debian Squeeze and PHP 5.2.17

本安裝預設裝載 Debian 6 (squeeze)、Apache 2、PHP 5.2.17 (來自 lenny 庫)

# 啟用方式

1. 先變更 sources/apache-config.conf 裡的 servername 參數，改成您要啟動的網站名稱
2. 透過以下指令執行
<code>sudo docker run -d -p 8001:80 -v /host/site/path:/var/www/html gloomcheng/squeeze</code>
