package uz.ishbor.app.com

import android.app.Application
import com.yandex.mapkit.MapKitFactory

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setApiKey("d5d11899-3666-4363-98c8-ffc2f4c11a1f")
    }
}
