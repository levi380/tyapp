import os
import subprocess
from pathlib import Path

# ======== 配置信息 ========
RCLONE_REMOTE = "r2"  # rclone 配置的远程端名字
BUCKET_NAME = "sk-app"
REMOTE_DIR = "ios"  # 上传到 R2 的目录
DOWNLOAD_DOMAIN = "https://appdownload.skbet.com"
LOCAL_IOS_DIR = "scripts/ios"  # iOS 文件夹路径
# ==========================


def run_command(cmd):
    """运行 shell 命令并实时输出日志"""
    process = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    for line in process.stdout:
        print(line, end="")
    process.wait()
    return process.returncode


def upload_ios_files():
    local_dir = Path(LOCAL_IOS_DIR)
    if not local_dir.exists():
        print(f"❌ 未找到目录: {local_dir.resolve()}")
        return

    remote_path = f"{RCLONE_REMOTE}:{BUCKET_NAME}/{REMOTE_DIR}/"
    print(f"🚀 正在上传 {local_dir} 下的所有文件 到 {remote_path}...")

    # 上传整个 ios 文件夹下的内容
    cmd = f'rclone copy -P "{local_dir}" "{remote_path}" --s3-no-check-bucket --copy-links'
    if run_command(cmd) != 0:
        print("❌ 上传失败")
        return

    print("\n✅ 上传成功！文件可通过以下地址访问：")
    for file in local_dir.iterdir():
        if file.is_file():
            download_url = f"{DOWNLOAD_DOMAIN}/{REMOTE_DIR}/{file.name}"
            print(f"   - {download_url}")


if __name__ == "__main__":
    upload_ios_files()