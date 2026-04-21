import subprocess
import os

PKG = "com.tyapp.flutter.flutter_ty_app"
DEST = "./perf_data.json"

print("📥 拉取 perf_data.json ...")

cmd = f"adb exec-out run-as {PKG} cat files/perf_data.json"
result = subprocess.run(cmd, shell=True, capture_output=True)

if result.returncode == 0 and result.stdout:
    with open(DEST, "wb") as f:
        f.write(result.stdout)
    print(f"✅ 已保存到: {os.path.abspath(DEST)}")
else:
    print("❌ 拉取失败:", result.stderr.decode("utf-8"))
