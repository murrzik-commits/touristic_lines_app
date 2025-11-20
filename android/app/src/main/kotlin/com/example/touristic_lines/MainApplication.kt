package com.example.touristic_lines

import android.app.Application
import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
  override fun onCreate() {
    super.onCreate()

    MapKitFactory.setApiKey("0e0c77d5-c60a-424c-a09c-065f903af733")

    MapKitFactory.initialize(this)
  }
}
