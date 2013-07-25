assert = require "assert"
glob = require "./glob"

assert glob("node_modules","**/package.json").length == 4
console.log "Pass"

# console.log glob("node_modules","**/package.json")