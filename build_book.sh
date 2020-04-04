#!/usr/bin/env bash

if [ -z "$1" ]
  then
    echo "No working directory supplied"
    exit 1
fi
workdir=$1
if [[ ! -d $workdir ]]
then
  echo "Working directory $workdir doesn't exist"
  exit 1
fi
if [ -z "$2" ]
  then
    echo "No title supplied"
    exit 1
fi
title=$2
cd $workdir
echo "processing $title in $workdir/"

# sleep 10
rm -r "$workdir/output"
# create output directory if missing
[[ -d "$workdir/output" ]] || mkdir "$workdir/output"

# add newline if missing from files.csv
tail -c1 < "$workdir/files.csv" | read -r _ || echo >> "$workdir/files.csv"


while IFS=, read -r filename destfile block part ignore
do
    file=${title// /_}--${destfile}
    echo "src: $filename dest:$file"
    # continue
    cat "$workdir/riptracks/$filename" >> "$workdir/output/$file"
    if [ $? -eq 0 ]
    then
      echo "Successfully added to file"
    else
      echo "file doesn't exit, creating" >&2
      cat "$workdir/riptracks/$filename" > "$workdir/output/$file"
    fi
    sleep 1
done < "$workdir/files.csv"


tracks=( $(cat "$workdir/files.csv" | awk -F, {'print $2'} | uniq) )

total=${#tracks[@]}
count=0
for track in "${tracks[@]}"
do
  ((count++))
  file=${title// /_}--${track}
  track_title=$(echo "$track" | cut -f 1 -d '.')
  track_title="${title} - ${track_title//_/ }"
  echo "$count / $total $file $track_title"
  eyeD3 --to-v2.4 "$workdir/output/$file" --track $count --track-total $total --disc-num 1 --disc-total 1 --title "$track_title" --add-image "$workdir/cover/cover.jpeg":FRONT_COVER
done

mv "$workdir/output" "$workdir/$title"
