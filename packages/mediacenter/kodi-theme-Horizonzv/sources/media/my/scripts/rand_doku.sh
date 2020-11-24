#!/bin/bash
#
# Kodi JSON examples.
#		https://kodi.wiki/view/List_of_built-in_functions
#
cr=$'\n\n'
hostname="127.0.0.1"
port=8080
user="kodi"
password="kodi"


##clear playlist
curl --user "$user:$password" --header "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"Playlist.Clear","params":{"playlistid":1},"id":1}' "http://$hostname:$port/jsonrpc"

# add dokus 
curl --user "$user:$password" 'http://libre.local:8080/jsonrpc?Playlist.Insert'  -H 'X-Requested-With: XMLHttpRequest' -H 'Content-Type: application/json'  --compressed --insecure \
     --data-binary '[{"jsonrpc":"2.0","method":"Playlist.Insert","params":[1,0,{"directory":"'$1'"}],"id":1}]'


curl --user "$user:$password" --header "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"Player.SetShuffle","params":{1,true} }' "http://$hostname:$port/jsonrpc"

curl --user "$user:$password" --header "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"Player.Open","params":{"item": {"playlistid":1}}}' "http://$hostname:$port/jsonrpc"
#curl --user "$user:$password" --header "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"GUI.SetFullscreen","params":{"fullscreen":True} }' "http://$hostname:$port/jsonrpc"
