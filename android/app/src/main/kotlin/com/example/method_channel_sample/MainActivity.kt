package com.example.method_channel_sample

import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val nativeChannel = "com.example.method_channel_sample"


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            nativeChannel
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "showToast" -> {
                    val message = call.argument<String>("message") ?: ""
                    val duration = call.argument<String>("duration") ?: "short"
                    showToast(message, duration)
                    result.success(null)
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }


    private fun showToast(message: String, duration: String) {
        val toastDuration = if (duration == "long") Toast.LENGTH_LONG else Toast.LENGTH_SHORT

        runOnUiThread {
            Toast.makeText(this, "$message Android", toastDuration).show()
        }
    }

}
