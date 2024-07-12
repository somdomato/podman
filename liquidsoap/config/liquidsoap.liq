#!/usr/bin/liquidsoap

def rq() = 
  lines = process.read.lines("curl http://api:3000/ns")
  uri = list.hd(default="",lines)
  request.create(uri)
end

p = playlist("/music")
s = request.dynamic(rq)
r = fallback(track_sensitive=false, [p,s])
m = mksafe(r)

output.icecast(%vorbis,
  host = "icecast", port = 8000,
  password = "hackme", mount = "radio.ogg",
  m)