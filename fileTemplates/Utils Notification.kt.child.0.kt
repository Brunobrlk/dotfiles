#parse("HeaderPkg.kt")

import android.app.NotificationManager.IMPORTANCE_DEFAULT

enum class AppChannels(val id: String, val title: String, val description: String, val importance: Int) {
    DEFAULT("ID_DEFAULT", "Default Channel", "Default Channel", IMPORTANCE_DEFAULT),
}
