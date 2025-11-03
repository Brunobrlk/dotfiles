#parse("HeaderPkg.kt")

#set( $MODEL = $NAME.replace("sAdapter", "") )
#set( $VH = $MODEL + "ViewHolder" )
#set( $MODEL_LOWER = $MODEL.toLowerCase() )
#set( $BINDING = "Item" + $MODEL + "Binding" )

import #parse("RootPkg.kt").databinding.$BINDING
import #parse("RootPkg.kt").domain.models.$MODEL
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView

class $VH(private val binding: $BINDING) : RecyclerView.ViewHolder(binding.root){
    fun bind($MODEL_LOWER: $MODEL){
        binding.apply {
            
        }
    }
    
    companion object {
        fun from(parent: ViewGroup): $VH {
            val inflater = LayoutInflater.from(parent.context)
            val binding = ${BINDING}.inflate(inflater, parent, false)
            return $VH(binding)
        }
    }
}