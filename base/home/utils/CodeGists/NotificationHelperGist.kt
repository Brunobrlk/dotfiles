package com.example.androidapis

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat

class NotificationHelper {
    companion object {
        private val DEFAULT_NOTIFICATION_CHANNEL_ID = "General Purpose Channel"
        private val DEFAULT_NOTIFICATION_ID = 1001

        private lateinit var _notificationManager: NotificationManagerCompat

        fun createNotification(context: Context, msg:String ="Default Value"){
            val builder = NotificationCompat.Builder(context, DEFAULT_NOTIFICATION_CHANNEL_ID)
                .setSmallIcon(R.drawable.ic_launcher_foreground)
                .setContentTitle("Hello World")
                .setContentText(msg)
                .setPriority(NotificationCompat.PRIORITY_LOW)

            _notificationManager = NotificationManagerCompat.from(context)

            if(Build.VERSION.SDK_INT > Build.VERSION_CODES.O){
                createNotificationChannel()
            }

            _notificationManager.notify(DEFAULT_NOTIFICATION_ID, builder.build())
        }

        @RequiresApi(Build.VERSION_CODES.O)
        private fun createNotificationChannel() {
            val notificationChannel = NotificationChannel(DEFAULT_NOTIFICATION_CHANNEL_ID, "General", NotificationManager.IMPORTANCE_LOW)
            _notificationManager.createNotificationChannel(notificationChannel)
        }
    }
}
