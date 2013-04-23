#! /bin/bash

### Generate the mechanic of a nested-array supported up to 5 levels

## This loop generates a set of functions:
## level_0 level_1 level_2 ... level_k
## each one generates an array nested at certain level
## The one for the level_0 (1st level) should always be space

l_ifs=("\ " "\," "\;" "\*" "\^")
### !!!! ###
# The l_ifs list is important, make sure an array would not contains the
# IFS character at its level
### !!!! ###

for idx in `seq 0 $((${#l_ifs[@]} - 1))`; do
    eval "level_${idx}(){
        echo \$@ | sed 's/ /'${l_ifs[$idx]}'/g' 
    }"
done
