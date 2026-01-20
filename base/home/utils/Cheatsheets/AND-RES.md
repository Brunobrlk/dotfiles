# Getting strings
val stringFromActivity = getString(R.string.app_name)
val stringFromView = binding.main.context.getString(R.string.app_name)
val stringFromResources = resources.getString(R.string.app_name)
val stringFromContextCompat = ContextCompat.getString(this, R.string.app_name)

# Getting colors
val colorFromActivity = getColor(R.color.red)
val colorFromView = binding.main.context.getColor(R.color.red)
val colorFromResources = resources.getColor(R.color.red, theme)
val colorFromContextCompat = ContextCompat.getColor(this, R.color.red)
val colorFromResourcesCompat = ResourcesCompat.getColor(resources, R.color.red, theme)

# Getting drawables
val drawableFromActivity = getDrawable(R.drawable.ic_launcher_foreground)
val drawableFromView = binding.main.context.getDrawable(R.drawable.ic_launcher_foreground)
val drawableFromResources = resources.getDrawable(R.drawable.ic_launcher_foreground, theme)
val drawableFromAppCompat = AppCompatResources.getDrawable(this, R.drawable.ic_launcher_foreground)
val drawableFromResourcesCompat = ResourcesCompat.getDrawable(resources, R.drawable.ic_launcher_foreground, theme)
val drawableFromContextCompat = ContextCompat.getDrawable(this, R.drawable.ic_launcher_foregroun

# Getting Dimensions
val dimensionInPx = resources.getDimension(R.dimen.margin)
val dimensionInDp = resources.getDimension(R.dimen.margin) / resources.displayMetrics.density
val dimensionFromView= binding.main.context.resources.getDimension(R.dimen.margin)

# Getting Boolean
val isLandscape = resources.getBoolean(R.bool.is_landscape)
val isLandscapeFromView = binding.main.context.resources.getBoolean(R.bool.is_landscape)
val isLandscapeFromResources = resources.getBoolean(R.bool.is_landscape)

# Getting Integer
val integerFromActivity = resources.getInteger(R.integer.max_lines)
val integerFromView = binding.main.context.resources.getInteger(R.integer.max_lines)
val integerFromResources = resources.getInteger(R.integer.max_lines)

# Getting Array resources
val stringArrayFromActivity = resources.getStringArray(R.array.string_array)
val stringArrayFromView = binding.main.context.resources.getStringArray(R.array.string_array)
val stringArrayFromResources = resources.getStringArray(R.array.string_array)

# Getting Raw resources
val rawFromActivity = resources.openRawResource(R.raw.asset_statements)
val rawFromView = binding.main.context.resources.openRawResource(R.raw.asset_statements)
val rawFromResources = resources.openRawResource(R.raw.asset_statements)

# Getting Asset resources
val assetFromActivity = assets.open("asset_statements")
val assetFromView = binding.main.context.assets.open("asset_statements")
val assetFromResources = resources.assets.open("asset_statements")
