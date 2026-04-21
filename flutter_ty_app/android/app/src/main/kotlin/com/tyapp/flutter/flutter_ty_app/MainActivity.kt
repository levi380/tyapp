package com.tyapp.flutter.flutter_ty_app

import AndroidChannel
import android.app.AlertDialog
import android.content.DialogInterface
import android.util.Log
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine


class MainActivity: FlutterActivity() {

    //这个跟flutter的通道名称保持一直
    private val channel = "com.tyapp.flutter.flutter_ty_app"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        AndroidChannel(flutterEngine.dartExecutor.binaryMessenger,context)  // 实例化通道
    }



}
