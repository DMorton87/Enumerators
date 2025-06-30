#!/bin/bash

host=$(hostname)

echo "Scouting $host environment"
out0=enum_host
echo -e "\nuname\n" > $out0.txt
(uname -r) >> $out0.txt
echo -e "\n" >> $out0.txt

echo -e "\nOS info\n"  >> $out0.txt
(cat /etc/os-release) >> $out0.txt
echo -e "\n" >> $out0.txt

echo -e "\nVersion info\n" >> $out0.txt
(cat /proc/version) >> $out0.txt
echo -e "\n" >> $out0.txt

echo -e "\nCPU type\n" >> $out0.txt
(lscpu) >> $out0.txt
echo -e "\n" >> $out0.txt

echo -e "\nShells\n" >> $out0.txt
(cat /etc/shells) >> $out0.txt
(grep "*sh$" /etc/passwd) >> $out0.txt
echo -e "\n" >> $out0.txt

echo -e "\n$out0.txt ready\n"

echo "Checking block devices..."
out1=enum_block
echo -e "\nlsblk\n" > $out1.txt
(lsblk) >> $out1.txt
echo -e "\n" >> $out1.txt

echo -e "\nfstab\n" >> $out1.txt
(cat /etc/fstab) >> $out1.txt
echo -e "\n" >> $out1.txt

echo -e "df -h" >> $out1.txt
(df -h) >> $out1.txt
echo -e "\n" >> $out1.txt
echo -e "$out1 ready\n"

echo "Checking cronjobs:"
out2=enum_cron_jobs
(ls -la /etc/cron.daily/) > $out2.txt
echo -e "$out2 ready\n"

echo "Checking installed packages:"
out3=enum_packages
(dpkg -l) > $out3.txt
echo -e "$out3 ready\n"

echo "Checking $host groups:"
out4=enum_groups
(cat /etc/group) >> $out4.txt
echo -e "\n" >> $out4.txt
(getent group sudo) >> $out4.txt
echo -e "$out4 ready\n"

echo "Checking /etc/passwd:"
out5=enum_passwd
(cat /etc/passwd) > $out5.txt
echo -e "$out5 ready\n"

echo "Finding SETUID and SETGID bins (this may take a while...):"
out6=enum_specialbins
echo -e "\nSETUID\n" > $out6.txt
(find / -user root -perm -4000 -exec ls -ldb {} \; 2>/dev/null) >> $out6.txt
echo -e "\nSETGID\n" >> $out6.txt
(find / -user root -perm -6000 -exec ls -ldb {} \; 2>/dev/null) >> $out6.txt
echo -e "$out6 ready\n"

echo -e "\nCreating archive file for easy exfil...:\n"

(zip $host.zip enum*)

echo -e "\nCleaning up text files...\n"
(rm -fv enum*.txt)


echo -e "\nAll done! Go get 'em, tiger."

