#parse("HeaderPkg.kt")
#set( $MODEL = $FILE_NAME.replace("sRemoteMediator", "") )
#set( $MODEL_PLURAL = $MODEL + "s" )
#set( $MODEL_LOWER = $MODEL.toLowerCase() )
#set( $MODEL_LOWER_PLURAL = $MODEL_LOWER + "s" )
#set( $REMOTE = "remote" + $MODEL + "s" )
#set( $LOCAL = $REMOTE.replace("remote", "local") )

import androidx.paging.ExperimentalPagingApi
import androidx.paging.LoadType
import androidx.paging.PagingState
import androidx.paging.RemoteMediator
import #parse("RootPkg.kt").data.local.Local${MODEL_PLURAL}DataSource
import #parse("RootPkg.kt").data.local.database.entities.${MODEL}Entity
import #parse("RootPkg.kt").data.mappers.asEntityList
import #parse("RootPkg.kt").data.remote.Remote${MODEL_PLURAL}DataSource
import #parse("RootPkg.kt").domain.helpers.getOrElse
import javax.inject.Inject

@OptIn(ExperimentalPagingApi::class)
class ${MODEL_PLURAL}RemoteMediator @Inject constructor(
    private val $REMOTE: Remote${MODEL_PLURAL}DataSource,
    private val $LOCAL: Local${MODEL_PLURAL}DataSource,
) : RemoteMediator<Int, ${MODEL}Entity>() {
    override suspend fun load(
        loadType: LoadType, state: PagingState<Int, ${MODEL}Entity>
    ): MediatorResult {
        val cursor = when (loadType) {
            LoadType.REFRESH -> 0
            LoadType.PREPEND -> return MediatorResult.Success(endOfPaginationReached = true)
            LoadType.APPEND -> {
                val remoteKey = ${LOCAL}.getRemoteKey().getOrElse {
                    return MediatorResult.Error(Exception(it.name))
                }
                remoteKey.nextCursor ?: return MediatorResult.Success(endOfPaginationReached = true)
            }
        }
        val result = ${REMOTE}.get${MODEL_PLURAL}(cursor, state.config.pageSize).getOrElse {
            return MediatorResult.Error(Exception(it.name))
        }
        val ${MODEL_LOWER_PLURAL} = result.asEntityList()
        val meta = result.meta

        if (loadType == LoadType.REFRESH) {
            ${LOCAL}.clearAll()
            ${LOCAL}.clearRemoteKey()
        }

        ${LOCAL}.insertAll(${MODEL_LOWER_PLURAL})
        val previousCursor = meta.previousCursor
        val nextCursor = meta.nextCursor
        ${LOCAL}.insertRemoteKey(previousCursor, nextCursor)

        return MediatorResult.Success(endOfPaginationReached = nextCursor == null)
    }
}