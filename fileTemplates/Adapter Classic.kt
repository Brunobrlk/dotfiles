#parse("HeaderPkg.kt")

#set( $MODEL = $FILE_NAME.replace("sAdapter", "") )
#set( $VH = $MODEL + "ViewHolder" )
#set( $DF_CALLBACK = $MODEL + "sDiffCallback" )
#set( $ITEM_LAYOUT = "R.layout.item_" + $MODEL.toLowerCase() )

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import #parse("RootPkg.kt").R
import #parse("RootPkg.kt").domain.models.$MODEL

#set( $CLICK1 = $ClickListener_Interface_Name1 )
#set( $CLICK2 = $ClickListener_Interface_Name2 )
#set( $CLICK3 = $ClickListener_Interface_Name3 )
#if(${CLICK1} != "")#set( $CLICK1_VAR = $ClickListener_Interface_Name1.substring(0,1).toLowerCase() + $CLICK1.substring(1) )#end
#if(${CLICK2} != "")#set( $CLICK2_VAR = $ClickListener_Interface_Name2.substring(0,1).toLowerCase() + $CLICK2.substring(1) )#end
#if(${CLICK3} != "")#set( $CLICK3_VAR = $ClickListener_Interface_Name3.substring(0,1).toLowerCase() + $CLICK3.substring(1) )#end

class $FILE_NAME(
    #if(${CLICK1} != "")private val $CLICK1_VAR: ${CLICK1}#end
    #if(${CLICK2} != ""), private val $CLICK2_VAR: ${CLICK2}#end
    #if(${CLICK3} != ""), private val $CLICK3_VAR: ${CLICK3}#end
): ListAdapter<$MODEL, RecyclerView.ViewHolder>($DF_CALLBACK) {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = ${VH}.from(parent)

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        when (holder) {
            is $VH -> {
                val item = getItem(position)
                holder.bind(item)
            }
        }
    }
    
    class $VH(itemView: View) : RecyclerView.ViewHolder(itemView){
        fun bind(item: $MODEL){
            
        }
        
        companion object {
            fun from(parent: ViewGroup): $VH {
                val view = LayoutInflater.from(parent.context).inflate($ITEM_LAYOUT, parent, false)
                return $VH(view)
            }
        }
    }
}

object $DF_CALLBACK: DiffUtil.ItemCallback<$MODEL>(){
    override fun areItemsTheSame(oldItem: $MODEL, newItem: $MODEL) = oldItem == newItem
    override fun areContentsTheSame(oldItem: $MODEL, newItem: $MODEL) = oldItem == newItem
}

#if(${CLICK1} != "")
interface $ClickListener_Interface_Name1 {
    fun on$ClickListener_Interface_Name1.replace("Listener", "")()
}
#end

#if(${CLICK2} != "")
interface $ClickListener_Interface_Name2 {
    fun on$ClickListener_Interface_Name2.replace("Listener", "")()
}
#end

#if(${CLICK3} != "")
interface $ClickListener_Interface_Name3 {
    fun on$ClickListener_Interface_Name3.replace("Listener", "")()
}
#end