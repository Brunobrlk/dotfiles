#parse("HeaderPkg.kt")
#set( $SERVICE1 = $Service_Name_1 )
#set( $SERVICE2 = $Service_Name_2 )
#set( $SERVICE3 = $Service_Name_3 )
#set( $SERVICE4 = $Service_Name_4 )
#set( $SERVICE5 = $Service_Name_5 )
#set( $AUTH = $Add_Auth_Interceptor_y_for_yes )
#set( $LOG = $Add_Logging_Interceptor_y_for_yes )

#if($SERVICE1 != "")import #parse("RootPkg.kt").data.remote.services.$SERVICE1
#end
#if($SERVICE2 != "")import #parse("RootPkg.kt").data.remote.services.$SERVICE2
#end
#if($SERVICE3 != "")import #parse("RootPkg.kt").data.remote.services.$SERVICE3
#end
#if($SERVICE4 != "")import #parse("RootPkg.kt").data.remote.services.$SERVICE4
#end
#if($SERVICE5 != "")import #parse("RootPkg.kt").data.remote.services.$SERVICE5
#end
#if($AUTH != "")import #parse("RootPkg.kt").data.remote.AuthInterceptor
#end
#if($LOG != "")import okhttp3.logging.HttpLoggingInterceptor
#end
import #parse("RootPkg.kt").domain.helpers.Constants
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object NetworkModule {
    #if($AUTH != "") 
    @Singleton
    @Provides
    fun provideAuthInterceptor(): AuthInterceptor = AuthInterceptor()
    #end

    #if($LOG != "") 
    @Singleton
    @Provides
    fun provideLoggingInterceptor(): HttpLoggingInterceptor =
        HttpLoggingInterceptor().setLevel(HttpLoggingInterceptor.Level.BODY)
    #end

    @Singleton
    @Provides
    fun provideOkHttpClient(
        #if($LOG != "")loggingInterceptor: HttpLoggingInterceptor,#end
        #if($AUTH != "")authInterceptor: AuthInterceptor #end
    ): OkHttpClient = OkHttpClient.Builder()
        #if($AUTH != "").addInterceptor(authInterceptor)#end
        #if($LOG != "").addInterceptor(loggingInterceptor)#end
        .build()

    @Singleton
    @Provides
    fun provideRetrofit(okHttpClient: OkHttpClient): Retrofit =
        Retrofit.Builder().baseUrl(Constants.API_BASE_URL)
            .addConverterFactory(GsonConverterFactory.create()).client(okHttpClient).build()

    #if($SERVICE1 != "") 
    @Provides
    fun provide$SERVICE1(retrofit: Retrofit): $SERVICE1 =
        retrofit.create($SERVICE1::class.java)
    #end
    
    #if($SERVICE2 != "") 
    @Provides
    fun provide$SERVICE2(retrofit: Retrofit): $SERVICE2 =
        retrofit.create($SERVICE2::class.java)
    #end
    
    #if($SERVICE3 != "") 
    @Provides
    fun provide$SERVICE3(retrofit: Retrofit): $SERVICE3 =
        retrofit.create($SERVICE3::class.java)
    #end
    
    #if($SERVICE4 != "") 
    @Provides
    fun provide$SERVICE4(retrofit: Retrofit): $SERVICE4 =
        retrofit.create($SERVICE4::class.java)
    #end
    
    #if($SERVICE5 != "") 
    @Provides
    fun provide$SERVICE5(retrofit: Retrofit): $SERVICE5 =
        retrofit.create($SERVICE5::class.java)
    #end
}