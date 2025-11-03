#parse("HeaderPkg.kt")

import android.content.Context
import androidx.lifecycle.ProcessLifecycleOwner
import androidx.startup.Initializer
import dagger.hilt.android.EntryPointAccessors
import #parse("RootPkg.kt").di.AppLifecycleEntryPoint

class LifecycleInitializer: Initializer<Unit> {
    override fun create(context: Context) {
        val appContext = context.applicationContext
        val appLifecycleObserver = EntryPointAccessors.fromApplication(
            appContext,
            AppLifecycleEntryPoint::class.java
        ).appLifecycleObserver()
        ProcessLifecycleOwner.get().lifecycle.addObserver(appLifecycleObserver)
    }

    override fun dependencies(): List<Class<out Initializer<*>?>?> = emptyList()
}