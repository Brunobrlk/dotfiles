#set($input = "${PACKAGE_NAME}")
#set($firstDot = $input.indexOf("."))
#set($secondDot = $input.indexOf(".", $firstDot + 1))
#set($thirdDot = $input.indexOf(".", $secondDot + 1))
#if($thirdDot != -1)
    #set($output = $input.substring(0, $thirdDot))
#else
    #set($output = $input)  ## Fallback if there are fewer than three dots
#end
$output