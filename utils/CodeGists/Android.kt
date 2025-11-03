private fun showWarning(message: String) {
    val snackbarMsg = getString(R.string.combined_msg_offline_mode, message)
    val retryAction = getString(R.string.action_retry)
    Snackbar
        .make(binding.root, snackbarMsg, Snackbar.LENGTH_INDEFINITE)
        .setAction(retryAction) { playersAdapter.retry() }
        .show()
}
