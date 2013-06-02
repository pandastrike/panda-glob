assert = require "assert"
glob = require "./glob"

assert glob(".","**/package.json").length == 5
console.log "Pass"