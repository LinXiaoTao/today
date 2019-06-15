package com.leo.personal.today

import com.leo.personal.today.util.GlobalContext
import io.flutter.app.FlutterApplication

/**
 * @author weimian
 * Created on 2019-05-11 12:20
 */
class App : FlutterApplication() {

    override fun onCreate() {
        super.onCreate()
        GlobalContext.initContext(this)
    }
}