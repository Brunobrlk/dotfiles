#parse("HeaderPkg.kt")

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import androidx.core.app.NotificationCompat
import #parse("RootPkg.kt").R

/*
=====================================================
🧱 File Template: NotificationUtils.kt
-----------------------------------------------------
📘 Purpose:
   Provides a unified way to create, configure, and
   show notifications across the app using consistent
   channels and styles.

🧭 Location:
   core/notifications/NotificationUtils.kt
   core/notifications/AppChannels.kt

🧩 Basic Usage:
   NotificationUtils.getBuilder(context, AppChannels.DEFAULT)
       .setContentTitle("Hello Title")
       .setContentText("Hello Content")
       .show(context, 0)

⚙️ Important:
   - Always call NotificationUtils.ensureChannels(context)
     in NotificationsInitializer (or in Application.onCreate)
     before showing any notification.
   - Channels must remain stable; do not change IDs.

🚀 Todos / Improvements:
   - [ ] Add TemplateBuilder for custom notification styles
   - [ ] Add RawBuilder and AppTemplate (with default styles)
   - [ ] Add support for grouped notifications
   - [ ] Add extension for deep link PendingIntent handling

🧠 Notes:
   - If NotificationCompat.Builder changes behavior in future
     Android versions, update channel registration logic.
=====================================================
*/

object NotificationUtils {
    fun getBuilder(context: Context, channel: AppChannels): NotificationCompat.Builder {
        val channelId = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) channel.id else ""
        return NotificationCompat.Builder(context, channelId)
            .setAutoCancel(true)
            .setSmallIcon(R.drawable.ic_launcher_foreground)
    }
    
    fun NotificationCompat.Builder.show(context: Context, id: Int) {
        val notificationManager = getNotificationManager(context)
        notificationManager.notify(id, build())
    }
    
    fun ensureChannels(context: Context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val notificationManager = getNotificationManager(context)
            AppChannels.entries.forEach {
                val channel = NotificationChannel(it.id, it.title, it.importance).apply {
                    description = it.description
                    setShowBadge(false)
                }
                notificationManager.createNotificationChannel(channel)
            }
        }
    }
    
    private fun getNotificationManager(context: Context) = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
}