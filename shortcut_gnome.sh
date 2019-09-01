#!/bin/bash
cd $(cd `dirname $0`; pwd)
cd desktop
find ./ -name "*.desktop" -exec bash -c "sed 's@\$PWD@'\"$PWD\"'@' {} > $HOME/.local/share/applications/{}" \;