# panda-glob

A globbing wrapper around minimatch optimized for multiple calls against large directories.

## Installation

    npm install panda-glob
    
## Usage

    glob = require "glob"
    paths = glob("node_modules", "**/*.coffee")
    
There is presently no async mode.

For more, see the [docs for the minimatch library][0], which does the real work.

[0]:https://github.com/isaacs/minimatch

## Caching

The filesystem hierarchy is cached, as are instances of the minimatch pattern itself. So you can call this repeatedly without incurring additional filesystem overhead. This means that, if there are changes over time, you will start to get erroneous results. There is presently no way to clear the cache.