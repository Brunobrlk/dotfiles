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

sealed interface $FILE_NAME {
    val workName: String

    enum class OneTimeWork(override val workName: String) : AppWorks {
        #if($ONE_WORK1 != "")
        $ONE_WORK1_ENUM(${ONE_WORK1}.ONE_TIME_NAME)
        #end
        #if($ONE_WORK2 != "")
        $ONE_WORK2_ENUM(${ONE_WORK2}.ONE_TIME_NAME)
        #end
        #if($ONE_WORK3 != "")
        $ONE_WORK3_ENUM(${ONE_WORK3}.ONE_TIME_NAME)
        #end
    }

    enum class PeriodicWork(override val workName: String) : AppWorks {
        #if($PER_WORK1 != "")
        $PER_WORK1_ENUM(${PER_WORK1}.PERIODIC_NAME)
        #end
        #if($PER_WORK2 != "")
        $PER_WORK2_ENUM(${PER_WORK2}.PERIODIC_NAME)
        #end
        #if($PER_WORK3 != "")
        $PER_WORK3_ENUM(${PER_WORK3}.PERIODIC_NAME)
        #end
    }
}
