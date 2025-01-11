#!/bin/bash

if ! pgrep -x "zen" > /dev/null; then
    zen-browser &
fi
