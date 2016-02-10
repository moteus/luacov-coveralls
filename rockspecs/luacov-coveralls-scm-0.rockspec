package = "LuaCov-coveralls"
version = "scm-0"
source = {
   url = "git://github.com/moteus/luacov-coveralls",
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
   -- "luajson",
   -- "lua-cjson",
   "dkjson",
   "luacov > 0.5",
   "luafilesystem",
   "lua-path",
}
build = {
   type = "builtin",
   copy_directories = {},
   modules = {
      ['luacov.reporter.coveralls'      ] = "src/luacov/reporter/coveralls.lua",
      ['luacov.coveralls.CiInfo'        ] = "src/luacov/coveralls/CiInfo.lua",
      ['luacov.coveralls.CiRepo'        ] = "src/luacov/coveralls/CiRepo.lua",
      ['luacov.coveralls.utils'         ] = "src/luacov/coveralls/utils.lua",
      ['luacov.coveralls.repo.appveyor' ] = "src/luacov/coveralls/repo/appveyor.lua",
      ['luacov.coveralls.repo.git'      ] = "src/luacov/coveralls/repo/git.lua",
   },
   install = {
      bin = {
         ["luacov-coveralls"] = "src/bin/luacov-coveralls",
      }
   },
}
