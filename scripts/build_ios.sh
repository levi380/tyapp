#!/bin/bash

# 传入ENV参数
ENV=$1

if [ -z "$ENV" ]; then
  echo "请传入ENV参数，例如：./build_ios.sh dev"
  exit 1
fi

# Step 1: Flutter build iOS（无代码签名），同时传入ENV参数
flutter build ios --release --no-codesign \
  --dart-define=ENV=$ENV \
  --dart-define=BUILD_TIME="$(date -u +%Y-%m-%d\ %H:%M:%S)"

# Step 2: 创建Payload文件夹，把Runner.app放进去
mkdir -p Payload
cp -R build/ios/iphoneos/Runner.app Payload/

# Step 3: 压缩为IPA包
zip -r sk.ipa Payload

echo "IPA包已生成：$(pwd)/sk.ipa"
