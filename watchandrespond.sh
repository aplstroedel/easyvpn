#!/usr/bin/bash
options=('.test0' '.test1' '.test2')
location=/home/"$LOGNAME"/scripts/testing/
array=('one' 'two' 'three')

watchandrespond(){
for i in "${array[*]}"
do
while inotifywait -q -e modify "$location/$i/out" >/dev/null
do 
data=($(tail -n 1 "$location/$i/out"))
if [[ "${data[1]}" = ".options" ]]
then
echo "${options[@]}" > "$location/$i/in"
fi
done
done
}
watchandrespond&


