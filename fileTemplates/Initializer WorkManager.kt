#parse("HeaderPkg.kt")

import android.content.Context
import androidx.startup.Initializer
import androidx.work.Configuration
import androidx.work.WorkManager

class WorkManagerInitializer : Initializer<Configuration> {
    override fun create(context: Context): Configuration {
        val config = Configuration.Builder()
            .setMinimumLoggingLevel(android.util.Log.INFO)
            .build()
        WorkManager.initialize(context, config)
        return config
    }

    override fun dependencies(): List<Class<out Initializer<*>>> = emptyList()
}