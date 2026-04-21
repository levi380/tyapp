import android.annotation.SuppressLint
import android.app.AlertDialog
import android.app.Application
import android.content.Context
import android.content.ContextWrapper
import android.content.DialogInterface
import android.content.Intent
import android.content.IntentFilter
import android.content.res.Configuration
import android.os.BatteryManager
import android.os.Build
import android.util.DisplayMetrics
import android.util.Log
import android.view.WindowManager
import android.widget.Toast
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class AndroidChannel(flutterEngine: BinaryMessenger, context: Context): MethodChannel.MethodCallHandler {
    private val androidChannelName = "com.tyapp.flutter.flutter_ty_app"
    private var channel: MethodChannel
    private var mContext: Context

    companion object {
        private const val TAG = "AndroidChannel"
    }

    init {
        Log.d(TAG, "init")
        channel = MethodChannel(flutterEngine, androidChannelName)
        channel.setMethodCallHandler(this)
        mContext = context;
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.d(TAG, "onMethodCall: " + call.method)
        if (call.method == "getBatteryLevel") {
            val batteryLevel = getBatteryLevel()
            if (batteryLevel != -1) {
              //  showDialog();
                result.success(batteryLevel)
            } else {
                result.error("UNAVAILABLE", "Battery level not available.", null)
            }
        } else if (call.method == "getIsIpad"){
             Log.d(TAG, "调用getIsIpad: " + isTabletDevice())
            val isIpad = isTabletDevice()
            result.success(isIpad)
        }else {

            result.notImplemented()
        }
    }

    @SuppressLint("ServiceCast")
    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = mContext.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(mContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) *
                    100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }

    /**
     * 判断是否平板设备
     * @param context
     * @return true:平板,false:手机
     */
    private fun isTabletDevice(): Boolean {
        return mContext.resources.configuration.screenLayout and Configuration.SCREENLAYOUT_SIZE_MASK >= Configuration.SCREENLAYOUT_SIZE_LARGE
    }

    /**
     * 根据屏幕尺寸判断是否平板设备
     * @param context
     * @return true:平板,false:手机
     */
    fun isRealMetricsPad(): Boolean {
        val wm = mContext.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val display = wm.defaultDisplay
        val dm = DisplayMetrics()
        display.getRealMetrics(dm) // 获取真实的显示尺寸

        val x = Math.pow((dm.widthPixels / dm.xdpi).toDouble(), 2.0)
        val y = Math.pow((dm.heightPixels / dm.ydpi).toDouble(), 2.0)
        val screenInches = Math.sqrt(x + y)

        return screenInches >= 7.0 // 大于6尺寸则为Pad
    }



    fun  showDialog(){
        AlertDialog.Builder(mContext).setMessage("你好  flutter")
            .setTitle("flutter 调取原生")
            .setPositiveButton("一级棒", DialogInterface.OnClickListener{
                    dialogInterface,i ->
                Toast.makeText(mContext,"实验很成功", Toast.LENGTH_SHORT).show()
                Log.d("azy","toast show()")
            })
            .setNegativeButton("取消",null)
            .create()
            .show();
    }
}
