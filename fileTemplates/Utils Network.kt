#parse("HeaderPkg.kt")

import #parse("RootPkg.kt").domain.helpers.DataError

import kotlinx.coroutines.ensureActive
import retrofit2.Response
import java.io.IOException
import java.net.*
import javax.net.ssl.SSLException
import kotlin.coroutines.cancellation.CancellationException
import #parse("RootPkg.kt").domain.helpers.Result
import kotlin.coroutines.coroutineContext

suspend inline fun <reified T> safeCall(
    execute: () -> Response<T>
): Result<T, DataError.Remote> {
    val response = try {
        execute()
    } catch (e: CancellationException) {
        throw e // respect coroutine cancellation
    } catch (e: UnknownHostException) {
        e.printStackTrace()
        return Result.Error(DataError.Remote.NO_INTERNET)
    } catch (e: ConnectException) {
        e.printStackTrace()
        return Result.Error(DataError.Remote.NO_INTERNET)
    } catch (e: SocketTimeoutException) {
        e.printStackTrace()
        return Result.Error(DataError.Remote.REQUEST_TIMEOUT)
    } catch (e: SSLException) {
        e.printStackTrace()
        return Result.Error(DataError.Remote.SSL_HANDSHAKE)
    } catch (e: ProtocolException) {
        e.printStackTrace()
        return Result.Error(DataError.Remote.BAD_REQUEST)
    } catch (e: IOException) {
        e.printStackTrace()
        return Result.Error(DataError.Remote.NO_INTERNET)
    } catch (e: Exception) {
        e.printStackTrace()
        coroutineContext.ensureActive()
        return Result.Error(DataError.Remote.UNKNOWN)
    }

    return responseToResult(response)
}

fun <T> responseToResult(response: Response<T>): Result<T, DataError.Remote> {
    return if (response.isSuccessful) {
        response.body()?.let {
            Result.Success(it)
        } ?: Result.Error(DataError.Remote.NO_DATA)
    } else {
        val error = getRemoteError(response.code())
        Result.Error(error)
    }
}

private fun getRemoteError(code: Int): DataError.Remote = when (code) {
    400 -> DataError.Remote.BAD_REQUEST
    401 -> DataError.Remote.UNAUTHORIZED
    403 -> DataError.Remote.FORBIDDEN
    404 -> DataError.Remote.NOT_FOUND
    406 -> DataError.Remote.NOT_ACCEPTABLE
    408 -> DataError.Remote.REQUEST_TIMEOUT
    409 -> DataError.Remote.CONFLICT
    413 -> DataError.Remote.PAYLOAD_TOO_LARGE
    415 -> DataError.Remote.UNSUPPORTED_MEDIA_TYPE
    429 -> DataError.Remote.TOO_MANY_REQUESTS
    500 -> DataError.Remote.INTERNAL_SERVER_ERROR
    502 -> DataError.Remote.BAD_GATEWAY
    503 -> DataError.Remote.SERVICE_UNAVAILABLE
    504 -> DataError.Remote.GATEWAY_TIMEOUT
    else -> DataError.Remote.UNKNOWN
}
