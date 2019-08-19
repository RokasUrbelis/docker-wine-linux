#!/bin/bash
##make APP soft link
for i in $(ls /opt/deepinwine/apps/);do ln -s /opt/deepinwine/apps/$i/run.sh $(echo $i|awk 'BEGIN{FS="-"}{print "/usr/bin/"$2}');done
