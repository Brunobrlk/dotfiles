#parse("HeaderPkg.kt")

import android.app.Activity
import android.content.pm.PackageManager
import android.widget.Toast
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.google.android.material.dialog.MaterialAlertDialogBuilder

object PermissionUtils {
    data class RationaleDialog(val title: String, val message: String)

    fun getPermissionRequest(activity: AppCompatActivity, permission: String, callback: (isGranted: Boolean) -> Unit): Pair<ActivityResultLauncher<String>, String> {
        val launcher = activity.registerForActivityResult(ActivityResultContracts.RequestPermission()){ isGranted ->
            callback.invoke(isGranted)
        }
        return launcher to permission
    }

    fun handlePermission(activity: Activity, resolver: Pair<ActivityResultLauncher<String>, String>, rationaleDialog: RationaleDialog) {
        val permission = resolver.second
        val launcher = resolver.first

        when {
            ContextCompat.checkSelfPermission(activity, permission) == PackageManager.PERMISSION_GRANTED -> permissionGrantedAlert(activity)

            ActivityCompat.shouldShowRequestPermissionRationale(activity, permission) -> {
                MaterialAlertDialogBuilder(activity)
                    .setTitle(rationaleDialog.title)
                    .setMessage(rationaleDialog.message)
                    .setPositiveButton("Yes"){ _, _ -> launcher.launch(permission) }
                    .setNegativeButton("No"){ _, _ -> permissionRequiredAlert(activity, permission) }
                    .show()
            }
            else -> launcher.launch(permission)
        }
    }

    private fun formatPermissionName(permission: String) = permission.replace("android.permission.", "")
    private fun permissionRequiredAlert(activity: Activity, permission: String) = Toast.makeText(activity, "${DS}{formatPermissionName(permission)} permission is required. Accept it to use this feature.", Toast.LENGTH_SHORT).show()
    private fun permissionGrantedAlert(activity: Activity) = Toast.makeText(activity, "Permission already granted", Toast.LENGTH_SHORT).show()
}