#parse("HeaderPkg.kt")

import #parse("RootPkg.kt").core.lifecycle.AppLifecycleObserver
import dagger.hilt.EntryPoint
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent

@EntryPoint
@InstallIn(SingletonComponent::class)
interface AppLifecycleEntryPoint {
    fun appLifecycleObserver(): AppLifecycleObserver
}