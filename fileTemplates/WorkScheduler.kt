#parse("HeaderPkg.kt")
#set( $ONE_WORK1 = $OneTime_Worker1_name )
#set( $ONE_WORK2 = $OneTime_Worker2_name )
#set( $ONE_WORK3 = $OneTime_Worker3_name )
#set( $PER_WORK1 = $Periodic_Worker1_name )
#set( $PER_WORK2 = $Periodic_Worker2_name )
#set( $PER_WORK3 = $Periodic_Worker3_name )
#if($ONE_WORK1 != "")
    #set( $ONE_WORK1_MODEL = $ONE_WORK1.replace("Worker", "") )
    #set( $ONE_WORK1_ENUM = $ONE_WORK1_MODEL.toUpperCase() )
#end
#if($ONE_WORK2 != "")
    #set( $ONE_WORK2_MODEL = $ONE_WORK2.replace("Worker", "") )
    #set( $ONE_WORK2_ENUM = $ONE_WORK2_MODEL.toUpperCase() )
#end
#if($ONE_WORK3 != "")
    #set( $ONE_WORK3_MODEL = $ONE_WORK3.replace("Worker", "") )
    #set( $ONE_WORK3_ENUM = $ONE_WORK3_MODEL.toUpperCase() )
#end
#if($PER_WORK1 != "")
    #set( $PER_WORK1_MODEL = $PER_WORK1.replace("Worker", "") )
    #set( $PER_WORK1_ENUM = $PER_WORK1_MODEL.toUpperCase() )
#end
#if($PER_WORK2 != "")
    #set( $PER_WORK2_MODEL = $PER_WORK2.replace("Worker", "") )
    #set( $PER_WORK2_ENUM = $PER_WORK2_MODEL.toUpperCase() )
#end
#if($PER_WORK3 != "")
    #set( $PER_WORK3_MODEL = $PER_WORK3.replace("Worker", "") )
    #set( $PER_WORK3_ENUM = $PER_WORK3_MODEL.toUpperCase() )
#end


import android.content.Context
import androidx.work.ExistingPeriodicWorkPolicy
import androidx.work.ExistingWorkPolicy
import androidx.work.WorkManager
import java.util.UUID

/*
    Types of work: One-time, Periodic
    OneTime: Immediate(May be Expedited), Long Running, Deferrable
    Periodic: Long Running, Deferrable
*/
@Singleton
class WorkScheduler @Inject constructor(
    @param:ApplicationContext private val context: Context
) {
    private val manager by lazy { WorkManager.getInstance(context) }

    private fun scheduleOneTimeWork(context: Context, appWork: AppWorks.OneTimeWork): UUID {
        val workRequest = when (appWork) {
            #if($ONE_WORK1 != "")
            AppWorks.OneTimeWork.$ONE_WORK1_ENUM -> ${ONE_WORK1}.buildOneTimeWork()
            #end
            #if($ONE_WORK2 != "")
            AppWorks.OneTimeWork.$ONE_WORK2_ENUM -> ${ONE_WORK2}.buildOneTimeWork()
            #end
            #if($ONE_WORK3 != "")
            AppWorks.OneTimeWork.$ONE_WORK3_ENUM -> ${ONE_WORK3}.buildOneTimeWork()
            #end
        }
        manager.enqueueUniqueWork(appWork.workName, ExistingWorkPolicy.REPLACE, workRequest)
        return workRequest.id
    }

    private fun schedulePeriodicWork(context: Context, appWork: AppWorks.PeriodicWork): UUID {
        val workRequest = when (appWork) {
            #if($PER_WORK1 != "")
            AppWorks.PeriodicWork.$PER_WORK1_ENUM -> ${PER_WORK1}.buildPeriodicWork()
            #end
            #if($PER_WORK2 != "")
            AppWorks.PeriodicWork.$PER_WORK2_ENUM -> ${PER_WORK2}.buildPeriodicWork()
            #end
            #if($PER_WORK3 != "")
            AppWorks.PeriodicWork.$PER_WORK3_ENUM -> ${PER_WORK3}.buildPeriodicWork()
            #end
        }
        manager.enqueueUniquePeriodicWork(appWork.workName, ExistingPeriodicWorkPolicy.REPLACE, workRequest)

        return workRequest.id
    }

    fun scheduleWork(context: Context, appWork: AppWorks) = when (appWork) {
        is AppWorks.OneTimeWork -> scheduleOneTimeWork(context, appWork)
        is AppWorks.PeriodicWork -> schedulePeriodicWork(context, appWork)
    }

    fun cancelWork(context: Context, appWork: AppWorks) = manager.cancelUniqueWork(appWork.workName)
    fun cancelAllWork(context: Context) = manager.cancelAllWork()
}