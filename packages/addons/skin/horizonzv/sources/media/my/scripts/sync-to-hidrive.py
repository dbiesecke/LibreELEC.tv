#!/usr/bin/env python
import subprocess

ssh = subprocess.Popen(["/storage/bin/rclone","sync","/storage/kodi/userdata/library/","hidrive:public/KODI/lib"],
                        stdin =subprocess.PIPE,
                        stdout=subprocess.PIPE,
                        stderr=subprocess.PIPE,
                        universal_newlines=True,
                        bufsize=0)
 
# Send ssh commands to stdin
ssh.stdin.close()

# Fetch output
for line in ssh.stdout:
    print(line.strip())
