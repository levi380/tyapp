package com.filbet.project.filbet

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import com.github.luben.zstd.Zstd
import android.util.Log

class MainActivity : FlutterActivity() {
    private val CHANNEL = "zstd_codec"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "decompress" -> {
                    val data = call.arguments as ByteArray
                    CoroutineScope(Dispatchers.IO).launch {
                        try {
                            Log.e("ZSTD", "receive data size = ${data.size}")
                            val size = Zstd.decompressedSize(data)
                            Log.e("ZSTD", "decompressedSize size = ${size}")
                            val dst = ByteArray(size.toInt())
                            val source = Zstd.decompress(dst, data)
                            Log.e("ZSTD", "written = $source")
                            withContext(Dispatchers.Main) {
                                result.success(dst)
                            }
                        } catch (e: Exception) {
                            Log.e("ZSTD", "Exception = ${e.message}")
                            withContext(Dispatchers.Main) {
                                result.error(
                                    "ZSTD_ERROR", e.message, null
                                )
                            }
                        }
                    }
                }

                else -> result.notImplemented()
            }
        }
    }
}
