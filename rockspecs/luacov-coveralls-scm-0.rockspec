package = "LuaCov-coveralls"
version = "scm-0"
source = {
   url = "git://github.com/keplerproject/luacov",
   tag = "master"
}
description = {
   summary = "LuaCov reporter for coveralls.io service",
   detailed = [[
   ]],
   homepage = "http://github.com/moteus/luacov-coveralls",
   license = "MIT/X11"
}
dependencies = {
   "lua >= 5.1",
   "luajson",
   "luacov", -- "luacov>0.5" ?
}
build = {
   type = "builtin",
   modules = {
      ['luacov.reporter.coveralls'] = "src/luacov/reporter/coveralls.lua",
   },
}
