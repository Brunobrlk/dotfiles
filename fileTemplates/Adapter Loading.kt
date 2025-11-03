#parse("HeaderPkg.kt")

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.paging.LoadState
import androidx.paging.LoadStateAdapter
import androidx.core.view.isVisible
import androidx.recyclerview.widget.RecyclerView
import #parse("RootPkg.kt").databinding.ItemLoadingBinding

class LoadingAdapter(private val onRetryClick: () -> Unit) :
    LoadStateAdapter<LoadingAdapter.LoadingViewHolder>() {
    override fun onBindViewHolder(holder: LoadingViewHolder, loadState: LoadState) {
        holder.bind(loadState, onRetryClick)
    }

    override fun onCreateViewHolder(
        parent: ViewGroup, loadState: LoadState
    ): LoadingViewHolder {
        val binding =
            ItemLoadingBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return LoadingViewHolder(binding)
    }
    
    class LoadingViewHolder(private val binding: ItemLoadingBinding) :
        RecyclerView.ViewHolder(binding.root) {
        fun bind(loadState: LoadState, onRetryClick: () -> Unit) {
            binding.apply {
                if (loadState is LoadState.Error) {
                    itLoadStateErrorText.text = loadState.error.localizedMessage
                    itLoadStateErrorRetryButton.setOnClickListener {
                        onRetryClick()
                    }
                }
    
                itLoadStateProgress.isVisible = loadState is LoadState.Loading
                itLoadStateErrorRetryButton.isVisible = loadState is LoadState.Error
                itLoadStateErrorText.isVisible = loadState is LoadState.Error
            }
        }
    }

}
