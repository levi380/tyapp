# tyApp

# 打包方式
### 方式一：直接通过flutter build apk 拼接环境
- 
```
flutter build apk --dart-define=ENV=dev -Penv=dev
```
输出apk在 build/app/outputs/apk/xxx.apk

### 方式二：通过脚本打包
- 1、安装脚本依赖jq（第一次使用需要）
```
brew install jq 
```
- 2、给脚本文件加权限（第一次使用需要）
```
chmod +x build_apk.sh
chmod +x build_ios.sh
```
- 3、执行打包脚本
```
./scripts/build_apk.sh prod  
[prod参数根据打包需要配置，dev、fat、uat、prod]
```
- 4、打包文件输出在 build/app/outputs/flutter-apk/xxx.apk

# 一键更换安卓、ios桌面图标
- 1、安装脚本依赖jq（第一次使用需要）
```
brew install yq
```
- 2、给脚本文件加权限（第一次使用需要）
```
chmod +x launcher_icon.sh
```
- 3、准备好需要更换的图标
```
把需要更换的图片文件放入在 assets/launcher目录里
```
- 4、修改对应环境的json配置
```
env目录里，找到对应环境json文件，修改iconPath数据为需要更换图片文件
```
- 4、执行打包脚本（在项目的根目录）
```
./scripts/launcher_icon.sh dev  
[prod参数根据打包需要配置，dev、fat、uat、prod]
