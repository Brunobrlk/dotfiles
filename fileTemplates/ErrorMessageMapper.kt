#parse("HeaderPkg.kt")

import android.content.Context
import #parse("RootPkg").R
import #parse("RootPkg").domain.helpers.DataError
import dagger.hilt.android.qualifiers.ApplicationContext
import javax.inject.Inject
import javax.inject.Singleton


@Singleton
class ErrorMessageMapper @Inject constructor(
    @param:ApplicationContext private val context: Context
) {
    fun toUiMessage(error: DataError): String {
        return when (error) {
            is DataError.Remote -> mapRemoteError(error)
            is DataError.Local -> mapLocalError(error)
        }
    }

    private fun mapRemoteError(error: DataError.Remote): String = when (error) {
        DataError.Remote.UNAUTHORIZED -> context.getString(R.string.error_unauthorized)
        DataError.Remote.FORBIDDEN -> context.getString(R.string.error_forbidden)
        DataError.Remote.NO_INTERNET -> context.getString(R.string.error_no_internet)
        DataError.Remote.REQUEST_TIMEOUT -> context.getString(R.string.error_request_timeout)
        DataError.Remote.BAD_REQUEST -> context.getString(R.string.error_bad_request)
        DataError.Remote.NOT_FOUND -> context.getString(R.string.error_not_found)
        DataError.Remote.NOT_ACCEPTABLE -> context.getString(R.string.error_not_acceptable)
        DataError.Remote.CONFLICT -> context.getString(R.string.error_conflict)
        DataError.Remote.PAYLOAD_TOO_LARGE -> context.getString(R.string.error_payload_too_large)
        DataError.Remote.UNSUPPORTED_MEDIA_TYPE -> context.getString(R.string.error_unsupported_media_type)
        DataError.Remote.TOO_MANY_REQUESTS -> context.getString(R.string.error_too_many_requests)
        DataError.Remote.INTERNAL_SERVER_ERROR -> context.getString(R.string.error_internal_server)
        DataError.Remote.BAD_GATEWAY -> context.getString(R.string.error_bad_gateway)
        DataError.Remote.SERVICE_UNAVAILABLE -> context.getString(R.string.error_service_unavailable)
        DataError.Remote.GATEWAY_TIMEOUT -> context.getString(R.string.error_gateway_timeout)
        DataError.Remote.SSL_HANDSHAKE -> context.getString(R.string.error_ssl_handshake)
        DataError.Remote.NO_DATA -> context.getString(R.string.error_no_data)
        DataError.Remote.UNKNOWN -> context.getString(R.string.error_unknown)
    }

    private fun mapLocalError(error: DataError.Local): String = when (error) {
        DataError.Local.DISK_FULL -> context.getString(R.string.error_disk_full)
        DataError.Local.DB_CORRUPTED -> context.getString(R.string.error_db_corrupted)
        DataError.Local.CACHE_EXPIRED -> context.getString(R.string.error_cache_expired)
        DataError.Local.UNKNOWN -> context.getString(R.string.error_unknown)
    }
}