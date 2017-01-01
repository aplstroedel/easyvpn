#!/usr/bin/bash

########################################
# still need some mods to make it work #
########################################


options=('.test0' '.test1' '.test2')
location=/home/"$LOGNAME"/scripts/testing
array=('one' 'two' 'three') # directories in directory 'testing'

watchandrespond(){
for i in "${array[*]}"
do
while inotifywait -q -e modify "$location"/*/out >/dev/null
do 
data=($(for target in "$location"/*/out; do tail -n 1 "$target" ; done))
if [[ "${data[2]}" = ".options" ]] && [[ "{$data[1]}" = "*$target*" ]]
then
echo "${options[@]}" > "$location"/"$i"/in
fi
done
done
}
watchandrespond&
