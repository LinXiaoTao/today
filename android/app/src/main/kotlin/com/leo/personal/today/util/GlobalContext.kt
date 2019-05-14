package com.leo.personal.today.util

import android.content.Context

/**
 * @author leo
 * Created on 2019-05-11 12:19
 */
object GlobalContext {

    lateinit var appContext: Context

    fun initContext(context: Context) {
        appContext = context
    }



}