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


CALL=$(cat $HOME/.kodi/my/music-videos |  awk 'BEGIN{srand()}{printf "%06d %s\n", rand()*1000000, $0;}' | sort -n | cut -c8- | tail -1)
echo $CALL

eval $CALL


curl --user "$user:$password" --header "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"Player.SetShuffle","params":{1,true} }' "http://$hostname:$port/jsonrpc"

curl --user "$user:$password" --header "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"Player.Open","params":{"item": {"playlistid":1}}}' "http://$hostname:$port/jsonrpc"
curl --user "$user:$password" --header "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"GUI.SetFullscreen","params":{"fullscreen":True} }' "http://$hostname:$port/jsonrpc"
