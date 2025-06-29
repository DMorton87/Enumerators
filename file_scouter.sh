#!/bin/bash

host=$(hostname)

echo "Searching for world writeable files...:"
out0=enum_wwfs
(find / -path /proc -prune -o -type f -perm -o+w 2>/dev/null) >> $out0.txt
echo -e "\n$out0.txt ready\n"

echo "Searching for hidden files...:"
out1=enum_hidden_files
(find / -type f -name ".*" -exec ls -l {} \; 2>/dev/null | grep $(whoami)) >> $out1.txt
echo -e "$out1 ready\n"

echo "Searching for config files...:"
out2=enum_config_files
(find / ! -path "*/proc/*" -iname "*config*" -type f 2>/dev/null) > $out2.txt
echo -e "$out2 ready\n"

echo "Searching for writeable directories...:"
out3=enum_directories
(find / -path /proc -prune -o -type d -perm -o+w 2>/dev/null) > $out3.txt
echo -e "$out3 ready\n"

echo -e "\nCreating archive file for easy exfil...:\n"

(zip found_files.zip enum*)

echo -e "\nCleaning up text files...\n"
(rm -fv *.txt)


echo -e "\nAll done! Go get 'em, tiger."

