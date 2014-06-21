luacov-coveralls
================

[![Licence](http://img.shields.io/badge/Licence-MIT-brightgreen.svg)](LICENSE)

LuaCov reporter for [coveralls.io](https://coveralls.io) service.

This module tested only on Travis-CI.

##Install

```
luarocks install luacov-coveralls
```

Note. For now I do not release so use this command to install

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
  -r DIR, --root DIR    set the root directory
  -e PAT, --exclude PAT set exclude pattern
  -i PAT, --include PAT set include pattern
  -t TOKEN, --repo-token TOKEN
                        set the repo_token of this project
  --dryrun              run coveralls without uploading report
```
###Basic usage `.travis.yml`

```
before_install:
  - sudo luarocks install luacov-coveralls

script:
  - lua -lluacov test.lua

after_success:
  - luacov-coveralls
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
