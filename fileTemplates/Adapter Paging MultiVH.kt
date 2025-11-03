#parse("HeaderPkg.kt")

#set( $MODEL = $FILE_NAME.replace("sAdapter", "") )
#set( $MODEL_PLURAL = $MODEL + "s" )
#set( $MODEL_CONST = "TYPE_" + $MODEL.toUpperCase() )
#set( $MODEL_LOWER = $MODEL.toLowerCase() )
#set( $VH = $MODEL + "ViewHolder" )
#set( $BINDING = "Item" + $MODEL + "Binding" )

#set( $SECOND = $Second_Item_Name )
#if( $SECOND != "")
    #set( $SECOND_CONST = "TYPE_" + $SECOND.toUpperCase() )
    #set( $SECOND_LOWER = $SECOND.toLowerCase() )
    #set( $SECOND_VH = $SECOND + "ViewHolder" )
    #set( $SECOND_BINDING = "Item" + $SECOND + "Binding" )
    #set( $SECOND_ITEM = $SECOND + "Item" )
#else 
    #set( $SECOND = "Header" )
    #set( $SECOND_CONST = "TYPE_" + $SECOND.toUpperCase() )
    #set( $SECOND_LOWER = $SECOND.toLowerCase() )
    #set( $SECOND_VH = $MODEL_PLURAL + $SECOND + "ViewHolder" )
    #set( $SECOND_BINDING = "Item" + $MODEL_PLURAL + $SECOND + "Binding" )
    #set( $SECOND_ITEM = $SECOND )
#end


#set( $LIST_ITEM = $MODEL + "ListItem" )
#set( $MODEL_ITEM = $MODEL + "Item" )

#set( $DF_CALLBACK = $MODEL + "sDiffCallback" )


#set( $CLICK1 = $ClickListener_Interface_Name1 )
#set( $CLICK2 = $ClickListener_Interface_Name2 )
#set( $CLICK3 = $ClickListener_Interface_Name3 )
#if(${CLICK1} != "")#set( $CLICK1_VAR = $ClickListener_Interface_Name1.substring(0,1).toLowerCase() + $CLICK1.substring(1) )#end
#if(${CLICK2} != "")#set( $CLICK2_VAR = $ClickListener_Interface_Name2.substring(0,1).toLowerCase() + $CLICK2.substring(1) )#end
#if(${CLICK3} != "")#set( $CLICK3_VAR = $ClickListener_Interface_Name3.substring(0,1).toLowerCase() + $CLICK3.substring(1) )#end

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.paging.PagingDataAdapter
import androidx.recyclerview.widget.RecyclerView
import #parse("RootPkg.kt").domain.models.$MODEL
import #parse("RootPkg.kt").domain.models.$LIST_ITEM
import #parse("RootPkg.kt").databinding.$BINDING
import #parse("RootPkg.kt").databinding.$SECOND_BINDING

class $FILE_NAME(
    #if(${CLICK1} != "")private val $CLICK1_VAR: ${CLICK1}#end
    #if(${CLICK2} != ""), private val $CLICK2_VAR: ${CLICK2}#end
    #if(${CLICK3} != ""), private val $CLICK3_VAR: ${CLICK3}#end
): PagingDataAdapter<$LIST_ITEM, RecyclerView.ViewHolder>($DF_CALLBACK) {

    companion object {
        private const val $MODEL_CONST = 0
        private const val $SECOND_CONST = 1
    }
    override fun getItemViewType(position: Int): Int = when (peek(position)) {
        is ${LIST_ITEM}.$SECOND_ITEM -> $SECOND_CONST
        is ${LIST_ITEM}.$MODEL_ITEM -> $MODEL_CONST
        null -> $MODEL_CONST
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = when(viewType) {
        $SECOND_CONST -> ${SECOND_VH}.from(parent)
        else -> ${VH}.from(parent)
    }
    
    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        when (val item = getItem(position)) {
            is ${LIST_ITEM}.$MODEL_ITEM -> (holder as $VH).bind(item.$MODEL_LOWER)

            is ${LIST_ITEM}.$SECOND_ITEM -> {}

            null -> {}
        }
    }


    class $VH(private val binding: $BINDING) : RecyclerView.ViewHolder(binding.root){
        fun bind($MODEL_LOWER: $MODEL){
            
        }
        
        companion object {
            fun from(parent: ViewGroup): $VH {
                val inflater = LayoutInflater.from(parent.context)
                val binding = ${BINDING}.inflate(inflater, parent, false)
                return $VH(binding)
            }
        }
    }

    class $SECOND_VH(private val binding: $SECOND_BINDING): RecyclerView.ViewHolder(binding.root){
        companion object {
            fun from(parent: ViewGroup): $SECOND_VH {
                val inflater = LayoutInflater.from(parent.context)
                val binding = ${SECOND_BINDING}.inflate(inflater, parent, false)
                return $SECOND_VH(binding)
            }
        }
    }
}

object $DF_CALLBACK : DiffUtil.ItemCallback<${LIST_ITEM}>() {
    override fun areItemsTheSame(
        oldItem: ${LIST_ITEM}, newItem: ${LIST_ITEM}
    ) = when {
        oldItem is ${LIST_ITEM}.$SECOND_ITEM && newItem is ${LIST_ITEM}.$SECOND_ITEM -> oldItem.KEY1 == newItem.KEY1
        oldItem is ${LIST_ITEM}.$MODEL_ITEM && newItem is ${LIST_ITEM}.$MODEL_ITEM -> oldItem.KEY2 == newItem.KEY2
        else -> false
    }

    override fun areContentsTheSame(
        oldItem: ${LIST_ITEM}, newItem: ${LIST_ITEM}
    ) = oldItem == newItem
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
