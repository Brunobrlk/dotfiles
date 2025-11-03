#parse("HeaderPkg.kt")

#set( $MODEL = $NAME.replace("Local", "").replace("sDataSource","") )
#set( $ENTITY = $MODEL + "Entity" )
#set( $MODEL_PLURAL = $MODEL + "s" )
#set( $MODEL_PLURAL_LOWER = $MODEL_PLURAL.toLowerCase() )

import #parse("RootPkg.kt").data.local.database.entities.$ENTITY

interface $NAME {
    suspend fun insertAll($MODEL_PLURAL_LOWER: List<$ENTITY>)
    suspend fun getAll(): List<$ENTITY>
    suspend fun clearAll()
}
