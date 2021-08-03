-- Plugin manager

local path = require("path")
local fn = vim.fn
local uv = vim.loop
local cmd = vim.api.nvim_command

local config = {
  git = "git",
  dir = fn.stdpath("data") .. "/site/pack/pm",
  bin = fn.stdpath("data") .. "/bin",
}

-- installed packages
local packages = {}
-- packages to be installed after a specific package
local after_packages = {}

local function download_executable(url, name)
  if path.is_file(config.bin .. "/" .. name) then return end
  uv.spawn("curl", {
    args = { "-fLo", name, url },
    cwd = config.bin
  }, function(code, _)
    if code ~= 0 then
      print("downloading " .. name .. " failed")
    else
      uv.spawn("chmod", {
        args = { "u+x", name },
        cwd = config.bin
      }, function(_, _) end)
    end
  end)
end

-- { git   :: url          # url of the git repository
-- , as    :: string       # name of the package
-- , path  :: path         # path to install the package
-- , after :: list[string] # packages to install before this one
-- }
local function construct_args(args)
  if type(args) == "string" then args = { git = args } end
  if not args.as then
    for repo in args.git:gmatch("http[s]?://[^/]*/[^/]*/([^/]*)%.git") do
      args.as = repo
    end
  end
  if not args.path then args.path = config.dir .. "/start" end
  if args.after then
    if type(args.after) == 'string' then args.after = { args.after } end
  else
    args.after = {}
  end
  return args
end

-- return the installed package if it exists, else return nil
local function get_package(name)
  for _, package in pairs(packages) do
    if package.as == name then return package end
  end
  return nil
end

local function init(args)
  if args then
    if args.git then config.git = args.git end
    if args.dir then config.dir = args.dir end
    if args.bin then config.bin = args.bin end
  end

  local optdir = config.dir .. "/opt"
  local startdir = config.dir .. "/start"
  if not path.is_dir(config.dir) then fn.mkdir(config.dir, 'p') end
  if not path.is_dir(optdir) then fn.mkdir(optdir, 'p') end
  if not path.is_dir(startdir) then fn.mkdir(startdir, 'p') end
  if not path.is_dir(config.bin) then fn.mkdir(config.bin, 'p') end
  vim.env.PATH = config.bin .. ":" .. vim.env.PATH
end

local pm

local function install_hook(args)
  cmd("packadd " .. args.as)
  if args.config then args.config() end
  packages[args.as] = args
  local packages = after_packages[args.as]
  if packages then
    for _, package in pairs(packages) do
      pm(package)
    end
  end
end

function pm(args)
  args = construct_args(args)
  if get_package(args.as) then return end

  for _, name in pairs(args.after) do
    if not get_package(name) then
      if type(after_packages[name]) ~= 'table' then
        after_packages[name] = {}
      end
      table.insert(after_packages[name], args)
      return
    end
  end

  if not path.is_dir(args.path .. "/" .. args.as) then
    local handle = uv.spawn(config.git, {
      args = { "clone", "--depth", "1", args.git, args.as },
      cwd = args.path,
    }, vim.schedule_wrap(function(code, _)
      if code == 0 then
        install_hook(args)
      else
        print("git clone did not return exit code 0")
      end
    end))
  else
    install_hook(args)
  end
end

return {
  init = init,
  pm   = pm,
  download_executable = download_executable,
}
