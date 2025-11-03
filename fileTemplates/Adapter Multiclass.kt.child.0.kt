#set( $MODEL = $NAME.replace("sAdapter", "") )
#set( $DF_CALLBACK = $MODEL + "sDiffCallback" )

import #parse("RootPkg.kt").domain.models.$MODEL
import androidx.recyclerview.widget.DiffUtil

object $DF_CALLBACK: DiffUtil.ItemCallback<$MODEL>(){
    override fun areItemsTheSame(oldItem: $MODEL, newItem: $MODEL) = oldItem == newItem
    override fun areContentsTheSame(oldItem: $MODEL, newItem: $MODEL) = oldItem == newItem
}