package com.leo.personal.today

import android.os.Bundle
import com.leo.personal.today.handler.AppMethodCallHandler
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        registerMethodCallHandler()
    }


    private fun registerMethodCallHandler() {
        MethodChannel(flutterView, AppMethodCallHandler.CHANNEL).setMethodCallHandler(AppMethodCallHandler())
    }

}
