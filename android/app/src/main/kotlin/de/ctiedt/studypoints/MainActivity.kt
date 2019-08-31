package de.ctiedt.studypoints

import android.os.Bundle
import android.view.Display

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
  private val CHANNEL = "screenState"

  override fun onCreate(savedInstanceState: Bundle?) {  

    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
      if (call.method == "getScreenState") {
        when (windowManager.defaultDisplay.state) {
          Display.STATE_ON -> result.success("ON")
          Display.STATE_DOZE -> result.success("DOZE")
          Display.STATE_DOZE_SUSPEND -> result.success("DOZE_SUSPEND")
          Display.STATE_OFF -> result.success("OFF")
          Display.STATE_VR -> result.success("VR")
          Display.STATE_UNKNOWN -> result.success("UNKNOWN")
        }
      }
    }
  }
}
