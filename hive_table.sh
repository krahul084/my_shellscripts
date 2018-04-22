#!/bin/bash
#Author=Rahul K
#Version=1.0
#Script to create a table from a text file
#Starting the script by declaring the functions
#Declaring the global variables below

read -p "Enter Username for Source Server: " user
read -p "Enter Source IP:   " host_name
read -p "Enter full path for the file:  " source_path
filename=$(basename $source_path)

#The below function is used to define the copy of source file from remote location
copy_file() {
        scp -rp $user@$host_name:$source_path /tmp/ 2>>1 >> /dev/null

        if [ $? -eq 0 ]; then
            echo "***Copy to local destination successful***"
        else
            echo "Error in input parameters, Please provide proper inputs"
            exit 1
        fi
}
#The below function is used to extract information from the source file to construct the hive table
extract_info() {

    path=/tmp/${filename}
    echo $path
    if [ -f $path ]; then
        variables=$(sed -n '1p' $path)
        data_variables=$(sed -n '2p' $path)
        IFS=':' read -r -a data <<< $variables
        IFS=':' read -r -a data_attrib <<< $data_variables
        sed -i '1,2d' $path
        file_length=$(wc -l testdb1.txt| cut -d' ' -f1)
        attribute_length=${#data[@]}
        i=0
        while [ $i -lt ${#data[@]} ]; do
            final[$i]="${data[$i]} ${data_attrib[$i]}"
            let i+=1
        done
        declare -g form1=$(printf "%s," "${final[@]}")
        form2=$(${form1[::-1]})
    else
        echo "Source file doesnt exist"
        exit 2
    fi

}

#The below function is defined to setup the source file in Hadoop ecosystem and use it to deploy a table in hive database
deploy_table() {
    echo "Creating directory and copying the source file to Hadoop! "
    file=$(echo $filename | cut -d'.' -f1)
    hadoop fs -mkdir $HOME/$file >> /dev/null && hadoop fs -put $path $HOME/$file/ 2>>1 >> /dev/null
    if [ $? -eq 0 ]; then
        echo "Using hive to create table using below attribute information"
        echo "($form2)"
        hive -e "create table if not exists $file($form2)  ROW FORMAT DELIMITED FIELDS TERMINATED BY ':' LINES TERMINATED BY '\n' stored as textfile LOCATION '/hive/$file';" 2>>1 >> /dev/null
        if [ $? -eq 0 ]; then
            echo "Created the table! now loading the data from source file****"; sleep 3;
            hive -e "load data inpath '$HOME/$file/$filename' into table $file;" 2>>1 >> /dev/null && echo "Data Imported Successfully"
        else
            echo "Error Creating the table!"
            exit 3
        fi
    else
        echo "copy of source file to Hadoop Filesystem failed, Please troubleshoot!"
        exit 4
    fi

}

#Main Script starts here
copy_file && extract_info && deploy_table

#Script ends here
