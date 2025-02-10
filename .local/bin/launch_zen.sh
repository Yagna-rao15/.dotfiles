#!/bin/bash

if ! pgrep -x "zen-bin" > /dev/null; then
    zen-browser &
fi

# NOTE: If the process id changes in future just run "ps -eo comm | grep zen" To get the name of main zen process.
