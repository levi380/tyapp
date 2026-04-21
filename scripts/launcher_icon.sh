#!/bin/bash

set -e

# 1. 参数读取
ENV=${1:-dev}
BUILD_TYPE=${2:-apk}
CONFIG_PATH="env/$ENV.json"

# 2. 检查配置文件是否存在
if [ ! -f "$CONFIG_PATH" ]; then
  echo "❌ 找不到环境配置文件: $CONFIG_PATH"
  exit 1
fi

# 3. 读取配置
APP_NAME=$(jq -r '.appConfig.appName' "$CONFIG_PATH")
VERSION=$(jq -r '.appConfig.version' "$CONFIG_PATH")
ICON_PATH=$(jq -r '.appConfig.iconPath' "$CONFIG_PATH")


if [[ -z "$ICON_PATH" ]]; then
  echo "❌ 配置缺失，请检查 appConfig 字段"
  exit 1
fi

# 4. 输出构建信息
echo "🛠️ 更换图标"
echo "环境: $ENV"
echo "📦 App 名字: $APP_NAME"
echo "🧩 版本: $VERSION"
echo "🖼️ 图标路径: $ICON_PATH"

# 5.替换图标配置（flutter_launcher_icons）
if [[ -n "$ICON_PATH" && -f "$ICON_PATH" ]]; then
  echo "🔄 更新 App 图标..."
  yq eval ".flutter_icons.image_path = \"$ICON_PATH\"" -i pubspec.yaml
  flutter pub run flutter_launcher_icons
else
  echo "❌ 未找到图标文件: $ICON_PATH"
fi

echo "✅ 更换成功"
