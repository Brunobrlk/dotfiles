#parse("HeaderPkg.kt")
#set( $MODEL = $NAME.replace("Remote", "").replace("sDataSource","") )
#set( $MODEL_LOWER = $MODEL.toLowerCase() )
#set( $MODEL_PLURAL = $MODEL + "s" )
#set( $MODEL_PLURAL_LOWER = $MODEL_PLURAL.toLowerCase() )
#set( $DTO = $MODEL + "Dto" )

import #parse("RootPkg.kt").data.remote.dtos.$DTO
import #parse("RootPkg.kt").domain.helpers.DataError
import #parse("RootPkg.kt").domain.helpers.Result

interface $NAME {
    suspend fun getAll(): Result<List<$DTO>, DataError.Remote>
    suspend fun getById(${MODEL_LOWER}Id: Int): Result<$DTO, DataError.Remote>
    suspend fun search(query: String): Result<List<$DTO>, DataError.Remote>
}