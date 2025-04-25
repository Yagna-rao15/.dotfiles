#!/bin/bash

# Load VirtualBox kernel modules
sudo modprobe vboxdrv
sudo modprobe vboxnetadp
sudo modprobe vboxnetflt

# Check if modules loaded successfully
if lsmod | grep -q vboxdrv; then
  echo "vboxdrv module loaded successfully."
else
  echo "Failed to load vboxdrv module."
fi

if lsmod | grep -q vboxnetadp; then
  echo "vboxnetadp module loaded successfully."
else
  echo "Failed to load vboxnetadp module."
fi

if lsmod | grep -q vboxnetflt; then
  echo "vboxnetflt module loaded successfully."
else
  echo "Failed to load vboxnetflt module."
fi

exit 0
