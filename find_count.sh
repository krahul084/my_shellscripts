#!/bin/bash
all_dirs=`ls -mR * | sed -n 's/://p'`
echo "Directory  File_Count"
find_count() {
	for file in $all_dirs; do
	  count=`ls $file|wc -l`
	  echo "$file has $count files"
	done
}

find_count
