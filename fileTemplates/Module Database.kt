#parse("HeaderPkg.kt")

import android.content.Context
import androidx.room.Room
import #parse("RootPkg.kt").data.local.database.AppDatabase
import #parse("RootPkg.kt").domain.helpers.Constants
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

#set( $DAO1 = $Dao_Name_1 )
#set( $DAO2 = $Dao_Name_2 )
#set( $DAO3 = $Dao_Name_3 )
#set( $DAO4 = $Dao_Name_4 )
#set( $DAO5 = $Dao_Name_5 )

@Module
@InstallIn(SingletonComponent::class)
object DatabaseModule {
    @Provides
    @Singleton
    fun provideDatabase(@ApplicationContext context: Context): AppDatabase =
        Room.databaseBuilder(context, AppDatabase::class.java, Constants.DATABASE_NAME)
            .fallbackToDestructiveMigration(true).build()
            
    #if($DAO1 != "")
    @Provides
    fun provide$DAO1(db: AppDatabase) = db.get$DAO1()
    #end
    
    #if($DAO2 != "")
    @Provides
    fun provide$DAO2(db: AppDatabase) = db.get$DAO2()
    #end
    
    #if($DAO3 != "")
    @Provides
    fun provide$DAO3(db: AppDatabase) = db.get$DAO3()
    #end
    
    #if($DAO5 != "")
    @Provides
    fun provide$DAO3(db: AppDatabase) = db.get$DAO3()
    #end
    
    #if($DAO4 != "")
    @Provides
    fun provide$DAO3(db: AppDatabase) = db.get$DAO3()
    #end
}