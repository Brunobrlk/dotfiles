package com.example.simplechat

import android.app.Activity
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.firebase.ui.auth.AuthUI
import com.firebase.ui.auth.FirebaseAuthUIActivityResultContract
import com.firebase.ui.auth.data.model.FirebaseAuthUIAuthenticationResult
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseAuth.AuthStateListener

class MainActivity : AppCompatActivity() {
    private lateinit var _auth: FirebaseAuth
    private lateinit var _authListener: AuthStateListener
    private val debug = "Debug"

    private val signInLauncher = registerForActivityResult(FirebaseAuthUIActivityResultContract()) { result: FirebaseAuthUIAuthenticationResult? ->
        if(result?.resultCode == Activity.RESULT_OK) Toast.makeText(this, "Hello World", Toast.LENGTH_LONG).show()
        else this.finish()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initAuthentication()
    }
    override fun onPause() {
        super.onPause()
        _auth.removeAuthStateListener(_authListener)
        Log.i(debug, "Hello World")
    }
    override fun onResume() {
        super.onResume()
        _auth.addAuthStateListener(_authListener)
        Log.i(debug, "Hello World")
    }

    private fun initAuthentication() {
        _auth = FirebaseAuth.getInstance()
        _authListener = AuthStateListener { firebaseAuth ->
            if(firebaseAuth.currentUser!=null){
                mainActivity()
            } else {
                signInActivity()
            }
        }
    }
    private fun mainActivity() {
        setContentView(R.layout.activity_main)
        initListeners()
    }
    private fun initListeners() {
        val logoutButton = findViewById<Button>(R.id.logout_button)
        logoutButton.setOnClickListener {
            Log.i(debug, "Hello World")
            _auth.signOut()
        }
    }
    private fun signInActivity() {
        val providers = arrayListOf(
            AuthUI.IdpConfig.PhoneBuilder().build(),
            AuthUI.IdpConfig.GoogleBuilder().build())

        val signInIntent = AuthUI.getInstance()
            .createSignInIntentBuilder()
            .setIsSmartLockEnabled(false)
            .setTheme(R.style.Base_Theme_SimpleChat)
            .setLogo(R.drawable.brlktech_logo)
            .setAvailableProviders(providers)
            .build()


        AuthUI.getInstance().signOut(this).addOnCompleteListener {
            finish()
        }
        signInLauncher.launch(signInIntent)
    }
}