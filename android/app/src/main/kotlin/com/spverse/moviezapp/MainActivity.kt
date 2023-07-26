package com.spverse.moviezapp

import android.accounts.AccountManager
import android.os.Bundle
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    private val channel = "get_email_address"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
            if (call.method == "getEmailId") {
                val emailId = getEmailId()
                result.success(emailId)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    private fun getEmailId(): String? {
        val accountManager = AccountManager.get(applicationContext)
        val accounts = accountManager.getAccountsByType("com.google")

        return if (accounts.isNotEmpty()) {
            accounts[0].name
        } else {
            null
        }
    }
}
