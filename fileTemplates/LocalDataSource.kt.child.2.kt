#parse("HeaderPkg.kt")

#set( $MODEL = $NAME.replace("Local", "").replace("sDataSource","") )
#set( $ENTITY = $MODEL + "Entity" )
#set( $MODEL_PLURAL = $MODEL + "s" )
#set( $MODEL_PLURAL_LOWER = $MODEL_PLURAL.toLowerCase() )

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.example.nbaapp.data.local.database.entities.$ENTITY

@Dao
interface ${MODEL_PLURAL}Dao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAll($MODEL_PLURAL_LOWER: List<$ENTITY>)

    @Query("SELECT * FROM $MODEL_PLURAL_LOWER")
    suspend fun getAll(): List<$ENTITY>

    @Query("DELETE FROM $MODEL_PLURAL_LOWER")
    suspend fun clearAll()
}
