#! /bin/bash
FILE="backup.conf"

. $FILE

#Script Werte
i=0
j=0

start=$(date +%s)
while [ $j -lt $h ]
        do
        sshport="sshport"$j""
        host="host"$j""
        user="user"$j""
        dest="dest"$j""
	destdir="destdir"$j""
	rdestdir="rdestdir"$j""
        ((j++))

while [ $i -lt $v ]
do

        dir="dir"$i""
            ((i++))
		rsync --numeric-ids -avz -e "ssh -p ${!sshport}" ${!dir}  ${!user}@${!host}:$destdir

        #       rclone --checksum  --copy-links copy $source:${!back} $dest:${!rdestdir}${!back}

		if [ $? -eq 0 ]; then
		echo "Backup: successfully"
		else
		echo "Backup: failed"
		fi
 		du -hs ${!back}

done
done
end=$(date +%s)

echo "claimed time:" $(($end - $start)) "seconds"

