package com.example.opentransportsp

import androidx.activity.result.contract.ActivityResultContracts
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.provider.Settings
import androidx.activity.result.ActivityResultCaller
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.fragment.app.Fragment

class PermissionManagerV2(
    caller: ActivityResultCaller,
    private val context: Context
) {
    private var onGranted: (() -> Unit)? = null
    private var onDenied: (() -> Unit)? = null
    private var onPermanentlyDenied: (() -> Unit)? = null
    private var onRationale: (() -> Unit)? = null

    private val requestSinglePermission =
        caller.registerForActivityResult(ActivityResultContracts.RequestPermission()) { granted ->
            handleSingleResult(requestedPermission, granted)
        }

    private val requestMultiplePermissions =
        caller.registerForActivityResult(ActivityResultContracts.RequestMultiplePermissions()) { result ->
            handleMultipleResult(result)
        }

    private var requestedPermission: String? = null

    fun request(
        permission: String,
        onGranted: () -> Unit,
        onDenied: (() -> Unit)? = null,
        onPermanentlyDenied: (() -> Unit)? = null,
        onRationale: (() -> Unit)? = null
    ) {
        this.onGranted = onGranted
        this.onDenied = onDenied
        this.onPermanentlyDenied = onPermanentlyDenied
        this.onRationale = onRationale

        requestedPermission = permission

        when {
            hasPermission(permission) -> onGranted()
            shouldShowRationale(permission) -> onRationale?.invoke() ?: run { requestSinglePermission.launch(permission) }
            else -> requestSinglePermission.launch(permission)
        }
    }

    fun request(
        permissions: Array<String>,
        onGranted: () -> Unit,
        onDenied: (() -> Unit)? = null,
        onPermanentlyDenied: (() -> Unit)? = null,
        onRationale: (() -> Unit)? = null
    ) {
        this.onGranted = onGranted
        this.onDenied = onDenied
        this.onPermanentlyDenied = onPermanentlyDenied
        this.onRationale = onRationale

        if (permissions.all { hasPermission(it) }) {
            onGranted()
            return
        }

        requestMultiplePermissions.launch(permissions)
    }

    fun openSettings() {
        val intent = Intent(
            Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
            Uri.fromParts("package", context.packageName, null)
        )
        context.startActivity(intent)
    }

    private fun handleSingleResult(permission: String?, granted: Boolean) {
        if (permission == null) return

        when {
            granted -> onGranted?.invoke()
            !shouldShowRationale(permission) -> onPermanentlyDenied?.invoke()
            else -> onDenied?.invoke()
        }
    }

    private fun handleMultipleResult(result: Map<String, Boolean>) {
        val denied = result.filterValues { !it }.keys

        when {
            denied.isEmpty() -> onGranted?.invoke()
            denied.any { !shouldShowRationale(it) } -> onPermanentlyDenied?.invoke()
            else -> onRationale?.invoke() ?: onDenied?.invoke()
        }
    }

    private fun hasPermission(permission: String): Boolean =
        ContextCompat.checkSelfPermission(context, permission) == android.content.pm.PackageManager.PERMISSION_GRANTED

    private fun shouldShowRationale(permission: String): Boolean {
        return when (context) {
            is Fragment -> context.shouldShowRequestPermissionRationale(permission)
            is Activity -> ActivityCompat.shouldShowRequestPermissionRationale(context, permission)
            else -> false
        }
    }
}
