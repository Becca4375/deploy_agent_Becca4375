#!/bin/bash
read -p "enter name of directory " directory

mkdir attendance_tracker_$directory

mkdir attendance_tracker_$directory/Helpers
mkdir attendance_tracker_$directory/reports

mv attendance_checker.py attendance_tracker_$directory
mv assets.csv attendance_tracker_$directory/Helpers
mv config.json attendance_tracker_$directory/Helpers
mv reports.log attendance_tracker_$directory/reports

read -p "Do you want to change the attendance threshold?" answer

if [ $answer=yes ]; then
	read -p "enter new  failure value" failure
	read -p "enter new warning value" warning
	
	sed -i "s/50/$failure/g" attendance_tracker_$directory/Helpers/config.json
	sed -i "s/75/$warning/g" attendance_tracker_$directory/Helpers/config.json
else
        echo "No changes made"
fi

trap '

echo "script has been cancelled"
tar "-cf attendance_tracker_$directory_archive attendance_tracker_$directory"
rm -r attendance_tracker_$directory

exit 1
' SIGINT
if python3 --version &> /dev/null; then
    echo "Python3 is installed."
else
    echo "Warning: Python3 is not installed."
fi
