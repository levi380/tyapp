import os
import subprocess
from pathlib import Path

# ======== 配置信息 ========
RCLONE_REMOTE = "tencent-hk-sk-static"  # rclone 配置的远程端名字
BUCKET_NAME = "sk-pcfile-1367458492"
REMOTE_DIR = "app"  # 上传到 R2 的目录
DOWNLOAD_DOMAIN = "https://appdownload.skbet.com"
LOCAL_APK_DIR = "build/app/outputs/apk/release"  # APK 目录
# ==========================


def run_command(cmd):
    """运行 shell 命令并实时输出日志"""
    process = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    for line in process.stdout:
        print(line, end="")
    process.wait()
    return process.returncode


def find_latest_apk(directory):
    """在目录中找到最新的 APK 文件"""
    apk_files = list(Path(directory).glob("*.apk"))
    if not apk_files:
        return None
    return max(apk_files, key=lambda f: f.stat().st_mtime)  # 按修改时间排序


def upload_apk():
    apk_path = find_latest_apk(LOCAL_APK_DIR)
    if not apk_path:
        print(f"❌ 未找到 APK 文件，请确认目录是否正确: {Path(LOCAL_APK_DIR).resolve()}")
        return

    remote_path = f"{RCLONE_REMOTE}:{BUCKET_NAME}/{REMOTE_DIR}/"
    print(f"🚀 正在上传 {apk_path.name} 到 {remote_path}...")

    cmd = f'rclone copy -P "{apk_path}" "{remote_path}" --s3-no-check-bucket'
    if run_command(cmd) != 0:
        print(f"❌ 上传失败: {apk_path.name}")
        return

    download_url = f"{DOWNLOAD_DOMAIN}/{REMOTE_DIR}/{apk_path.name}"
    print(f"\n✅ 上传成功！下载地址：{download_url}")


if __name__ == "__main__":
    upload_apk()