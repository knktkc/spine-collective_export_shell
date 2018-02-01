#!/bin/sh
set -e

# MacのSpineのパス
SPINE_EXE="/Applications/Spine/Spine.app/Contents/MacOS/Spine"
echo "Spine exe: $SPINE_EXE"

echo ""
files="./20_アニメーション/*"
fileary=()
directory=()
spines=()
for filepath in $files; do
  if [ -d $filepath ] ; then
    directory+=("$filepath")
  fi
done

for i in ${directory[@]}; do
  echo "Cleaning..."
  rm -rf ${i}/export_light/*

  # echo "Packaging..."
  # "$SPINE_EXE" -i ${i}/images -o ${i}/export_light -p atlas-1.0.json

  for directory_path in "${i}/*"; do
    for spine_path in ${directory_path}; do
      if [[ $spine_path =~ .+\.spine ]] ; then
        echo "Exporting..."
        echo "spine : ${spine_path}"
        "$SPINE_EXE" -i ${spine_path} -o ${i}/export_light -e json.json
      fi
    done
  done
done
