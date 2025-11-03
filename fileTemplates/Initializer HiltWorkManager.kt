#parse("HeaderPkg.kt")

import android.content.Context
import androidx.startup.Initializer
import androidx.work.Configuration
import androidx.work.WorkManager
import #parse("RootPkg.kt").di.WorkManagerEntryPoint
import dagger.hilt.android.EntryPointAccessors

class HiltWorkManagerInitializer : Initializer<Unit> {
    override fun create(context: Context): Unit {
        if (!WorkManager.isInitialized()) {
            val appContext = context.applicationContext
            val workerFactory = EntryPointAccessors.fromApplication(
                appContext,
                WorkManagerEntryPoint::class.java
            ).hiltWorkerFactory()

            val config = Configuration.Builder()
                .setWorkerFactory(workerFactory)
                .build()
            WorkManager.initialize(appContext, config)
        }
    }

    override fun dependencies(): List<Class<out Initializer<*>>> = emptyList()
}