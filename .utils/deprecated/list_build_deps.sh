#!/bin/bash

source '.utils/functions.sh'
source '.utils/functions/build.sh'

__list_builddeps "${1}" #1> /dev/null

exit