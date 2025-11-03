#parse("HeaderPkg.kt")

import android.content.Context
import androidx.startup.Initializer
import #parse("RootPkg.kt").core.notifications.NotificationUtils

class NotificationsInitializer : Initializer<Unit> {
    override fun create(context: Context) {
        NotificationUtils.ensureChannels(context)
    }

    override fun dependencies() = emptyList<Class<out Initializer<*>>>()
}