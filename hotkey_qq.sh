#!/bin/bash
docker exec -i docker-wine bash -c "xdotool key --window \$(xdotool search --limit 1 --all --pid \$(pgrep '\QQ.exe')) ctrl+alt+z"