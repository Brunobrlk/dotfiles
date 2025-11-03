#parse("HeaderPkg.kt")

import android.content.Context
import androidx.work.Constraints
import androidx.work.CoroutineWorker
import androidx.work.OneTimeWorkRequest
import androidx.work.OneTimeWorkRequestBuilder
import androidx.work.PeriodicWorkRequest
import androidx.work.PeriodicWorkRequestBuilder
import androidx.work.WorkRequest
import androidx.work.WorkerParameters
import java.util.concurrent.TimeUnit

class $FILE_NAME(appContext: Context, params: WorkerParameters) : CoroutineWorker(appContext, params) {
    override suspend fun doWork(): Result {
        return Result.success()
    }

    companion object {
        const val WORK_TAG = "$FILE_NAME"
        const val PERIODIC_NAME = "Periodic$FILE_NAME"
        const val ONE_TIME_NAME = "OneTime$FILE_NAME"

        fun buildPeriodicWork(): PeriodicWorkRequest {
            val constraints = Constraints.Builder()
                .setRequiresBatteryNotLow(false)
                .build()

            return PeriodicWorkRequestBuilder<$FILE_NAME>(15, TimeUnit.MINUTES)
                .setConstraints(constraints)
                .addTag(WORK_TAG)
                .build()
        }

        fun buildOneTimeWork(): OneTimeWorkRequest {
            val constraints = Constraints.Builder()
                .setRequiresCharging(false)
                .build()

            return OneTimeWorkRequestBuilder<$FILE_NAME>()
                .setConstraints(constraints)
                .addTag(WORK_TAG)
                .build()
        }
    }

}