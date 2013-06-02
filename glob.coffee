{Minimatch} = require "minimatch"
{readdir,stat, type,memoize} = require "fairmont"
{join} = require "path"

crawl = (path) ->
  fs = {}
  for name in readdir( path )
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

lsR = memoize( (path) -> flatten( crawl( path ) ) )

mini = memoize( (pattern) -> new Minimatch( pattern ) )

module.exports = (path,pattern) ->
  _pattern = mini( pattern )
  _path for _path in lsR( path ) when _pattern.match( _path )