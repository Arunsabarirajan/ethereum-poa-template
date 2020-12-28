#!/bin/bash

DISK="/dev/sdc"
MOUNTPOINT="/home/azureuser/eth-node"
echo "Working on ${DISK}"

sfdisk -l ${DISK} | grep "No partitions found" "${OUTPUT}" >/dev/null 2>&1
if [ ${?} -ne 0 ];
then
    echo "${DISK} is not partitioned, partitioning"
    echo "n
p
1


w"| fdisk "${DISK}" > /dev/null 2>&1
fi
PARTITION=$(fdisk -l ${DISK}|grep -A 1 Device|tail -n 1|awk '{print $1}')
OUTPUT=$(file -L -s ${PARTITION})
grep filesystem <<< "${OUTPUT}" > /dev/null 2>&1
if [ ${?} -ne 0 ];
then
    echo "Creating filesystem on ${PARTITION}."
    /sbin/mkfs.ext2 -j -t ext4 ${PARTITION}
fi

echo "Next mount point appears to be ${MOUNTPOINT}"
[ -d "${MOUNTPOINT}" ] || mkdir "${MOUNTPOINT}"
read UUID FS_TYPE < <(blkid -u filesystem ${PARTITION}|awk -F "[= ]" '{print $3" "$5}'|tr -d "\"")
grep "${UUID}" /etc/fstab >/dev/null 2>&1
if [ ${?} -eq 0 ];
then
    echo "Not adding ${UUID} to fstab again (it's already there!)"
else
    cp /etc/fstab /root/
    LINE="UUID=\"${UUID}\"\t${MOUNTPOINT}\text4\tnoatime,nodiratime,nodev,noexec,nosuid\t1 2"
    echo -e "${LINE}" >> /etc/fstab
fi
echo "Mounting disk ${PARTITION} on ${MOUNTPOINT}"
mount "${MOUNTPOINT}"
