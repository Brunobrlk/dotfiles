#parse("HeaderPkg.kt")

import androidx.room.Entity
import androidx.room.PrimaryKey

#set( $MODEL = $NAME.replace("Local", "").replace("sDataSource","") )
#set( $ENTITY = $MODEL + "Entity" )
#set( $MODEL_PLURAL = $MODEL + "s" )
#set( $MODEL_PLURAL_LOWER = $MODEL_PLURAL.toLowerCase() )

@Entity(tableName = "$MODEL_PLURAL_LOWER")
data class $ENTITY(
    @PrimaryKey(autoGenerate = true) val id: Int,
)