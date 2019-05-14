package com.leo.personal.today.handler

import android.os.Build
import android.provider.Settings
import com.leo.personal.today.util.GlobalContext
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.*

/**
 * @author leo
 * Created on 2019-05-11 11:56
 */
class AppMethodCallHandler : MethodChannel.MethodCallHandler {

    companion object {

        const val CHANNEL = "com.leo.personal.today/app"

    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {

        when (call.method) {

            "getDeviceInfo" -> {


                result.success(
                        mapOf(
                                "status" to 1,
                                "data" to mapOf(
                                        "deviceId" to UUID.randomUUID().toString().trim(),
                                        "osVersion" to Build.VERSION.SDK_INT.toString(),
                                        "androidId" to buildDeviceUUID()
                                )
                        )
                )

            }
        }

    }

    private fun buildDeviceUUID(): String {
        var androidId = ""
        try {
            androidId = Settings.Secure.getString(
                    GlobalContext.appContext.contentResolver,
                    Settings.Secure.ANDROID_ID
            )
        } catch (ignore: Throwable) {
        }

        if (androidId.isEmpty() || androidId.equals("9774d56d682e549c")) {
            val random = Random()
            androidId = random.nextInt().toString(16) +
                    random.nextInt().toString(16) +
                    random.nextInt().toString(16)
        }

        return UUID(androidId.hashCode().toLong(), getBuildInfo().hashCode().toLong()).toString()
    }

    private fun getBuildInfo(): String {
        val buildSB = StringBuffer()
        buildSB.append(Build.BRAND).append("/")
        buildSB.append(Build.PRODUCT).append("/")
        buildSB.append(Build.DEVICE).append("/")
        buildSB.append(Build.ID).append("/")
        buildSB.append(Build.VERSION.INCREMENTAL)
        return buildSB.toString()
    }

}