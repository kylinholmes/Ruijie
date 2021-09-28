# ruijie
powershell自动连接校园网，比python总要方便点吧

## 设置
在auto_connect里设置好以下三项：
```
userId
password
service
```
## 开机自启
- win+r, shell:startup

![image](https://user-images.githubusercontent.com/45586871/135025367-2369d1a8-6fab-4467-bfdc-1ac80c3b034e.png)

- 把auto_connect的快捷方式放进去，设置好ps1的默认打开方式为 `powershell`

![image](https://user-images.githubusercontent.com/45586871/135025732-59a4f4c5-ce0a-45e0-8f1b-308fb9c12f4d.png)

## 错误信息
遇到所有错误会写到`err.log`里面，所有的操作会写在`log`里，成功连网后，就会删除这两个文件
