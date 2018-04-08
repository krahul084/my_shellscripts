#This is a dated file copy script

date=$(date +'%m-%d-%y')
a=$1
b=$(basename $a)
cp -rp $1 $date.$b
echo the file created is $date.$b

