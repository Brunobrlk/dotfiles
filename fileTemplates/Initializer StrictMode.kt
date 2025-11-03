#parse("HeaderPkg.kt")

import android.content.Context
import androidx.startup.Initializer
import android.os.StrictMode
import #parse("RootPkg.kt").BuildConfig

class StrictModeInitializer : Initializer<Unit> {
    override fun create(context: Context) {
        if (BuildConfig.DEBUG) {
            StrictMode.setThreadPolicy(
                StrictMode.ThreadPolicy.Builder()
                    .detectAll()
                    .penaltyLog()
                    .build()
            )
            StrictMode.setVmPolicy(
                StrictMode.VmPolicy.Builder()
                    .detectLeakedClosableObjects()
                    .penaltyLog()
                    .build()
            )
        }
    }

    override fun dependencies() = emptyList<Class<out Initializer<*>>>()
}

