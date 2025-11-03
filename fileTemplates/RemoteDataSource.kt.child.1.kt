#parse("HeaderPkg.kt")
#set( $MODEL = $NAME.replace("Remote", "").replace("sDataSource","") )
#set( $MODEL_LOWER = $MODEL.toLowerCase() )
#set( $MODEL_PLURAL = $MODEL + "s" )
#set( $MODEL_PLURAL_LOWER = $MODEL_PLURAL.toLowerCase() )
#set( $DTO = $MODEL + "Dto" )
#set( $SERVICE = $MODEL_PLURAL + "Service" )
#set( $SERVICE_VAR = $MODEL_LOWER + "Service" )

import #parse("RootPkg.kt").data.remote.dtos.$DTO
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Query
import retrofit2.http.Path

interface $FILE_NAME {
    @GET("$MODEL_PLURAL_LOWER")
    suspend fun getAll(): Response<List<$DTO>>
    
    @GET("$MODEL_LOWER/{id}")
    suspend fun getById(@Path("id") id: Int): Response<$DTO>
    
    @GET("$MODEL_PLURAL_LOWER")
    suspend fun search(@Query("search") query: String): Response<List<$DTO>>

}
