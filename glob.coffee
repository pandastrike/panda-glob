{Minimatch} = require "minimatch"
{readdir,stat,chdir,type,memoize} = require "fairmont"
{join} = require "path"

crawl = (path) ->
  fs = {}
  path ?= "."
  for name in readdir( path )
    unless name[0] == "."
      thisPath = join( path, name )
      fs[name] = if stat( thisPath ).isDirectory()
        crawl( thisPath )
      else 
        thisPath
  fs
  
flatten = (fs) ->
  results = []
  for name, value of fs
    switch type( value )
      when "object"
        results = [ results..., flatten( value )... ]
      when "string"
        results.push( value )
  results

lsR = memoize( (path) -> 
  chdir path, -> flatten( crawl() ) )

mini = memoize( (pattern) -> new Minimatch( pattern ) )

module.exports = (path,pattern) ->
  _pattern = mini( pattern )
  _path for _path in lsR( path ) when _pattern.match( _path )