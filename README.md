luacov-coveralls
================

[![Licence](http://img.shields.io/badge/Licence-MIT-brightgreen.svg)](LICENSE)

LuaCov reporter for [coveralls.io](https://coveralls.io) service.

Currently support 
  * [Travis CI](https://travis-ci.org)
  * [AppVeyor](https://appveyor.com)

Also `luacov-coveralls` has code which support some other CI but I never test them.
If you can test it please do that and send PR.
  * [codeship](https://codeship.com)
  * [circleci](https://circleci.com)
  * [drone.io](http://drone.io)

##Install

```
luarocks install luacov-coveralls
```

To install current master use this command

```
luarocks install luacov-coveralls --server=http://rocks.moonscript.org/dev
```


##Usage

 * Run tests with enabled [LuaCov](https://github.com/keplerproject/luacov)
 * Run `luacov-coveralls`

###Command line arguments
```
luacov-coveralls [-h] [-v] [-c FILE] [-j FILE] [-e PAT] [-i PAT]
                 [-r DIR] [-t TOKEN] [-o FILE] [--dryrun]

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         print verbose messages
  -c FILE, --config FILE
                        configuration file
  -o FILE, --output FILE
                        output file
  -j FILE, --json FILE  merge report with this json report
  -m, --merge           merge statistics for files with same name
  -r DIR, --root DIR    set the root directory
  -e PAT, --exclude PAT set exclude pattern
  -i PAT, --include PAT set include pattern
  -s NAME, --service-name NAME
                        set `service_name` field explicitly
  -b [+-]VALUE, --build-number [+-]VALUE
                        set/change `service_number` field explicitly
  -t TOKEN, --repo-token TOKEN
                        set the repo_token of this project
  --dryrun              run coveralls without uploading report
```

**Note!** `--build-number` option is experimental.

###Basic usage `.travis.yml`

```
before_install:
  - luarocks install --local luacov-coveralls

script:
  - LUA_PATH="?;?.lua;$HOME/.luarocks/share/lua/5.1/?.lua" lua -lluacov test.lua

after_success:
  - $HOME/.luarocks/bin/luacov-coveralls
```

###Test Lua module written on Lua and C using [cpp-coveralls](https://github.com/eddyxu/cpp-coveralls)
```
before_install:
  - sudo pip install cpp-coveralls
  - sudo luarocks install luacov-coveralls

script:
  - lua -lluacov test.lua

after_success:
  - coveralls --dump c.report.json
  - luacov-coveralls -j c.report.json
```

See [lua-travis-example](https://github.com/moteus/lua-travis-example)
