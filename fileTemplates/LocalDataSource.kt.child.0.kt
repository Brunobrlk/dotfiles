#parse("HeaderPkg.kt")

#set( $MODEL = $NAME.replace("Local", "").replace("sDataSource","") )
#set( $MODEL_PLURAL = $MODEL + "s" )
#set( $MODEL_PLURAL_LOWER = $MODEL_PLURAL.toLowerCase() )
#set( $ENTITY = $MODEL + "Entity" )
#set( $DAO = $MODEL_PLURAL + "Dao" )
#set( $DAO_CAMEL = $MODEL_PLURAL.toLowerCase() + "Dao" )

import #parse("RootPkg.kt").data.local.database.entities.$ENTITY
import com.example.nbaapp.data.local.database.daos.$DAO
import javax.inject.Inject

class Room${MODEL_PLURAL}DataSource @Inject constructor(private val $DAO_CAMEL: $DAO): $NAME {
    override suspend fun insertAll($MODEL_PLURAL_LOWER: List<$ENTITY>) = ${DAO_CAMEL}.insertAll($MODEL_PLURAL_LOWER)
    
    override suspend fun getAll(): List<$ENTITY> = ${DAO_CAMEL}.getAll()

    override suspend fun clearAll() = ${DAO_CAMEL}.clearAll()
}
