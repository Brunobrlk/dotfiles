#parse("HeaderPkg.kt")
#set( $MODEL = $NAME.replace("Remote", "").replace("sDataSource","") )
#set( $MODEL_LOWER = $MODEL.toLowerCase() )
#set( $MODEL_PLURAL = $MODEL + "s" )
#set( $MODEL_PLURAL_LOWER = $MODEL_PLURAL.toLowerCase() )
#set( $DTO = $MODEL + "Dto" )
#set( $SERVICE = $MODEL_PLURAL + "Service" )
#set( $SERVICE_VAR = $MODEL_LOWER + "Service" )

import #parse("RootPkg.kt").data.remote.dtos.$DTO
import #parse("RootPkg.kt").data.remote.services.$SERVICE
import #parse("RootPkg.kt").domain.helpers.DataError
import #parse("RootPkg.kt").domain.helpers.Result
import #parse("RootPkg.kt").data.remote.utils.safeCall
import javax.inject.Inject

class $FILE_NAME @Inject constructor(private val $SERVICE_VAR: $SERVICE) : $NAME {
    override suspend fun getAll(): Result<List<$DTO>, DataError.Remote> {
        return safeCall { ${SERVICE_VAR}.getAll() }
    }

    override suspend fun getById(${MODEL_LOWER}Id: Int): Result<$DTO, DataError.Remote> {
        return safeCall { ${SERVICE_VAR}.getById(${MODEL_LOWER}Id) }
    }
    
    override suspend fun search(query: String): Result<List<$DTO>, DataError.Remote> {
        return safeCall { ${SERVICE_VAR}.search(query) }
    }
}
