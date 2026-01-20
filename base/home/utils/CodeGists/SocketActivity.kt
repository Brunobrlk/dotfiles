package com.example.websocketexample

import android.os.AsyncTask
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import org.java_websocket.client.WebSocketClient
import org.java_websocket.handshake.ServerHandshake
import java.net.Inet4Address
import java.net.NetworkInterface
import java.net.URI

class MainActivity : AppCompatActivity() {
    private lateinit var _textViewResultSocket: TextView
    private lateinit var _buttonStartConnection: Button

    private lateinit var _webSocketClient: WebSocketClient
    private val PORT = 5053
    private val WEB_SOCKET_URL = "ws://192.168.1.6:$PORT"
    private val TAG = "DEBUG"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        _textViewResultSocket = findViewById(R.id.textview_result_socket)
        _buttonStartConnection = findViewById(R.id.button_start_connection)
        _buttonStartConnection.setOnClickListener {
            test()
        }
    }

    fun test(){
        Log.i("DEBUG", "Está conectado: ${_webSocketClient.isOpen}")
    }

    private fun findViews(){

    }

    override fun onResume() {
        super.onResume()
        initWebSocket()
    }

    override fun onPause() {
        super.onPause()
        _webSocketClient.close()
    }

    private fun initWebSocket() {
        val coinBaseUri = URI(WEB_SOCKET_URL)
        createWebSocketClient(coinBaseUri)
        _webSocketClient.connect()
    }

    private fun createWebSocketClient(coinBaseUri: URI){
        _webSocketClient = object : WebSocketClient(coinBaseUri) {
            override fun onOpen(handshakedata: ServerHandshake?) {
                Log.d(TAG, "onOpen was called")
                subscribe()
            }

            override fun onMessage(message: String?) {
                Log.d(TAG, "onMessage: $message")
                runOnUiThread {
                    _textViewResultSocket.text = message
                }
            }

            override fun onClose(code: Int, reason: String?, remote: Boolean) {
                Log.d(TAG, "onClose was called")
                unsubscribe()
            }

            override fun onError(ex: Exception?) {
                Log.e(TAG, "onError: ${ex?.message}")
            }

        }
    }

    private fun subscribe(){
        val message = "{\n" +
                "    \"header\": \"20\",\n" +
                "    \"message\": { \"name\": \"Bruno testando\", \"address\": \"Sao pedro hehe\" }\n" +
                "}"
        val test = "A"
        _webSocketClient.send(test)
    }

    private fun unsubscribe(){
        val message = "{\n" +
                "    \"header\": \"10\",\n" +
                "    \"message\": { \"name\": \"Bruno testando\", \"address\": \"Sao pedro hehe\" }\n" +
                "}"
    }

    private fun sendMessage(message: String){
        if(_webSocketClient.isOpen){
            _webSocketClient.send(message)
        }
    }

    fun getIpv4HostAddress(): String {
        NetworkInterface.getNetworkInterfaces()?.toList()?.map { networkInterface ->
            networkInterface.inetAddresses?.toList()?.find {
                !it.isLoopbackAddress && it is Inet4Address
            }?.let { return it.hostAddress }
        }
        return ""
    }
}