#!/bin/bash

echo $(ip addr show "$1" | grep -m 1 inet | awk '{print $2}' | cut -d / -f 1)
