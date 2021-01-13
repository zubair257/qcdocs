#!/bin/bash
CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
    touch /$CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"
    /bin/bash
    # YOUR_JUST_ONCE_LOGIC_HERE

else
    echo "-- Not first container startup --"
    /bin/bash
fi
