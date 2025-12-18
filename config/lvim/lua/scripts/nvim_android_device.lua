local M = {}

local function is_android_or_flutter_project()
  local flutter = vim.fs.find("pubspec.yaml", { upward = true })[1]
  if flutter then return true end

  local gradle = vim.fs.find(
    { "build.gradle", "build.gradle.kts" },
    { upward = true }
  )[1]

  return gradle ~= nil
end

function M.get_attached_device()
  if not is_android_or_flutter_project() then
    return ""
  end

  local handle = io.popen("adb devices -l")
  if not handle then return "" end

  local result = handle:read("*a")
  handle:close()

  for line in result:gmatch("[^\r\n]+") do
    local model = line:match("model:([%w%s_%-]+) device")
    if model then
      return "📱 " .. model:gsub("_", " ")
    end
  end

  return "No device connected"
end

function M.android_model()
  return M.get_attached_device()
end

return M

