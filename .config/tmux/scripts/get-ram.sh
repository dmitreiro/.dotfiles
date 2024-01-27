#!/bin/bash

usage="$(free -h | awk 'NR==2 {print $3}')"
total="$(free -h | awk 'NR==2 {print $2}')"
formated="${usage}/${total}"
echo "RAM ${formated//i/B}"
