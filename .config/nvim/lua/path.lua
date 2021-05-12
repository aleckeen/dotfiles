local uv = vim.loop

-- check if a file or a directory exists
local function exists(path, ft)
  local stat = uv.fs_stat(path, nil)
  if stat then
    if ft then return stat.type == ft else return true end
  else
    return false
  end
end

return {
  exists  = exists,
  is_dir  = function(path) return exists(path, "directory") end,
  is_file = function(path) return exists(path, "file") end,
}
