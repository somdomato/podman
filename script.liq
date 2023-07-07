#!/usr/bin/liquidsoap

log.stdout.set(true)

default = single("/media/music/sdm/default.mp3")
list = playlist("/media/music/sertanejo")
radio = fallback([ list, default ])

output.icecast(%mp3, host="localhost",port=8000,password="hackme", mount="radio", radio)
