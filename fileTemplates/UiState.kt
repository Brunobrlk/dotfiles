#parse("HeaderPkg.kt")
#set( $MODEL = $FILE_NAME.replace("sUiState", "") )
#set( $MODEL_PLURAL_LOWER = $MODEL.toLowerCase() + "s" )


import #parse("RootPkg.kt").domain.models.$MODEL

sealed class $FILE_NAME {
    object Loading : $FILE_NAME()
    data class Success(val $MODEL_PLURAL_LOWER: List<$MODEL>) : $FILE_NAME()
    data class Warning(val data: List<$MODEL>, val message: String) : $FILE_NAME()
    data class Error(val message: String) : $FILE_NAME()
}