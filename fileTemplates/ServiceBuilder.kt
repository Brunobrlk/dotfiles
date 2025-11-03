#parse("HeaderPkg.kt")

import okhttp3.Interceptor
import okhttp3.Interceptor.Chain
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.Response
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

#if(${Add_Cookies_Interceptor_y_or_blank} != "")
object CookieManager {
    var sessionCookie: MutableList<String> = ArrayList()
}

class AddCookiesInterceptor : Interceptor {
    override fun intercept(chain: Chain): Response {
        val builder: Request.Builder = chain.request().newBuilder()

        for (cookie in CookieManager.sessionCookie) {
            builder.addHeader("Cookie", cookie)
        }

        return chain.proceed(builder.build())
    }
}

class ReceivedCookiesInterceptor : Interceptor {
    override fun intercept(chain: Chain): Response {
        val originalResponse: Response = chain.proceed(chain.request())
        if (originalResponse.headers("Set-Cookie").isNotEmpty()) {
            for (header in originalResponse.headers("Set-Cookie")) {
                CookieManager.sessionCookie.add(header)
            }
        }
        return originalResponse
    }
}
#end

#if(${Add_Auth_Interceptor_y_or_blank} != "")
class AuthInterceptor : Interceptor {
    private val token = "dcc6e5423d4626a51b9a53a34f167b0e11784a5320d456310adfe21d3056b35f"
    override fun intercept(chain: Chain): Response {
        val newRequest: Request = chain.request().newBuilder()
            .addHeader("Authorization", "Bearer \$token")
            .build()
        return chain.proceed(newRequest)
    }
}
#end

object ServiceBuilder {
    private const val BASE_URL = "${Base_Url}"

    #if(${Add_Logging_Interceptor_y_or_blank} != "")
    private val loggingInterceptor = HttpLoggingInterceptor().apply {
        level = HttpLoggingInterceptor.Level.BODY
    }
    #end

    private val okHttp = OkHttpClient.Builder().apply {
        #if(${Add_Auth_Interceptor_y_or_blank} != "")
        addInterceptor(AuthInterceptor())
        #end
        #if(${Add_Cookies_Interceptor_y_or_blank} != "")
        addInterceptor(ReceivedCookiesInterceptor())
        addInterceptor(AddCookiesInterceptor())
        #end
        #if(${Add_Logging_Interceptor_y_or_blank} != "")
        addInterceptor(loggingInterceptor)
        #end
    }.build()


    private val retrofit: Retrofit = Retrofit.Builder()
        .baseUrl(BASE_URL)
        .addConverterFactory(GsonConverterFactory.create())
        .client(okHttp)
        .build()

    fun <T> buildService(serviceType: Class<T>): T {
        return retrofit.create(serviceType)
    }
}