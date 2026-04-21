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
VERSION_CODE=$(jq -r '.appConfig.versionCode' "$CONFIG_PATH")

if [[ -z "$VERSION" || -z "$VERSION_CODE" || -z "$APP_NAME" ]]; then
  echo "❌ 配置缺失，请检查 appConfig 字段"
  exit 1
fi

# 4. 设置构建时间
BUILD_TIME=$(date +"%m%d%H%M")

# 5. 输出构建信息
echo "🛠️ 开始打包"
echo "环境: $ENV"
echo "📦 App 名字: $APP_NAME"
echo "🧩 版本: $VERSION"
echo "🔢 构建号: $VERSION_CODE"
echo "⏱️ 构建时间: $BUILD_TIME"
echo "🚀 构建类型: $BUILD_TYPE"

# 6. 修改 pubspec.yaml 版本号
sed -i '' "s/^version: .*/version: $VERSION+$VERSION_CODE/" pubspec.yaml

# 7. 清除缓存与构建目录
echo "🧹 清除缓存..."
flutter clean
rm -rf build/ output/

# 8. 执行构建
if [[ "$BUILD_TYPE" == "apk" ]]; then
  flutter build apk --release \
  --target-platform android-arm,android-arm64 \
  --dart-define=ENV=$ENV  \
  -Penv=$ENV \
  --dart-define=BUILD_TIME="$(date -u +%Y-%m-%d\ %H:%M:%S)"
  ORIG_PATH="build/app/outputs/flutter-apk/app-release.apk"
elif [[ "$BUILD_TYPE" == "aab" ]]; then
  flutter build apk --release \
    --dart-define=ENV=$ENV  \
    -Penv=$ENV
  ORIG_PATH="build/app/outputs/bundle/release/app-release.aab"
else
  echo "❌ 不支持的构建类型: $BUILD_TYPE"
  exit 1
fi

# 9. 重命名文件
EXT="${BUILD_TYPE}"
if [[ "$ENV" == "prod" ]]; then
  FILENAME="sk_${VERSION}.${EXT}"
else
  FILENAME="sk_${ENV}_${BUILD_TIME}.${EXT}"
fi

TARGET_PATH="$(dirname "$ORIG_PATH")/$FILENAME"

mv "$ORIG_PATH" "$TARGET_PATH"

echo "✅ 打包完成，输出文件:"
echo "$TARGET_PATH"
