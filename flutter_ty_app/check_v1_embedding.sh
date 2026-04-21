#!/bin/bash

echo "=== 正在扫描项目中可能存在的 V1 embedding 插件 ==="

echo ""
echo "1️⃣ 扫描 .dart_tool 目录..."
grep -r 'registerWith' ./.dart_tool

echo ""
echo "2️⃣ 扫描 build 目录..."
grep -r 'registerWith' ./build

echo ""
echo "3️⃣ 扫描插件目录 .pub-cache (可能稍慢)..."
grep -r 'registerWith' ~/.pub-cache

echo ""
echo "4️⃣ 扫描插件中是否存在 v1 embedding 核心类..."
grep -r 'PluginRegistry' ~/.pub-cache

echo ""
echo "✅ 扫描完成！"

echo ""
echo "👉 如果你在任何位置看到有 registerWith、PluginRegistry 相关代码，说明该插件仍然在使用 v1 embedding。"
echo "👉 重点检查使用的老版本第三方插件。"

echo ""
echo "✨ 建议升级所有 Flutter 插件版本，使用 flutter pub upgrade --major-versions"


