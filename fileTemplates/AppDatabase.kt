#parse("HeaderPkg.kt")

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
#if(${Entity_Class_Name1}!="")
import #parse("RootPkg.kt").localdata.database.entities.$Entity_Class_Name1
#end
#if(${Entity_Class_Name2}!="")
import #parse("RootPkg.kt").localdata.database.entities.$Entity_Class_Name2
#end
#if(${Entity_Class_Name3}!="")
import #parse("RootPkg.kt").localdata.database.entities.$Entity_Class_Name3
#end
#if(${Entity_Class_Name4}!="")
import #parse("RootPkg.kt").localdata.database..entities.$Entity_Class_Name4
#end
#if(${Dao_Class_Name1}!="")
import #parse("RootPkg.kt").localdata.database.daos.$Dao_Class_Name1
#end
#if(${Dao_Class_Name2}!="")
import #parse("RootPkg.kt").localdata.database.daos.$Dao_Class_Name2
#end
#if(${Dao_Class_Name3}!="")
import #parse("RootPkg.kt").localdata.database.daos.$Dao_Class_Name3
#end
#if(${Dao_Class_Name4}!="")
import #parse("RootPkg.kt").localdata.database.daos.$Dao_Class_Name4
#end

@Database(
    entities = [#if(${Entity_Class_Name1}!="")$Entity_Class_Name1::class#end#if(${Entity_Class_Name2}!=""), $Entity_Class_Name2::class#end#if(${Entity_Class_Name3}!=""), $Entity_Class_Name3::class#end#if(${Entity_Class_Name4}!=""), $Entity_Class_Name4::class#end],
    version = 1,
    exportSchema = false
)

abstract class AppDatabase : RoomDatabase() {
#if(${Dao_Class_Name1}!="")    abstract fun get$Dao_Class_Name1(): $Dao_Class_Name1#end
#if(${Dao_Class_Name2}!="")    abstract fun get$Dao_Class_Name2(): $Dao_Class_Name2#end
#if(${Dao_Class_Name3}!="")    abstract fun get$Dao_Class_Name3(): $Dao_Class_Name3#end
#if(${Dao_Class_Name4}!="")    abstract fun get$Dao_Class_Name4(): $Dao_Class_Name4#end

    companion object {
        @Volatile
        private var INSTANCE: AppDatabase? = null

        fun getDatabase(context: Context): AppDatabase {
            return INSTANCE ?: synchronized(this) {
                val instance = Room.databaseBuilder(
                    context.applicationContext,
                    AppDatabase::class.java,
                    "database"
                ).build()
                INSTANCE = instance
                instance
            }
        }
    }
}