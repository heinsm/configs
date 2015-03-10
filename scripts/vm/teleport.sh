#!/bin/bash


###
### Teleporting is experimental...
### this actually works just as good when we stop the appliance on source; and run it directly over samba share from target.
### since vm state doesn't matter, this is working fine.
###
echo "see this script for comments"
exit

vm=$1
target_ip=$2
port=$3

if [[ -z "${vm}" || -z "${target_ip} || -z "${port}" ]]; then
    echo "Usage: [vm_name] [target_ip] [port]"
    exit
fi

echo "########################"
echo "Teleporting to ${target_ip}"

#cmd="VBoxManage modifyvm $vm --teleporter ${teleporter} --teleporterport ${port}"
cmd="VBoxManage controlvm ${vm}  teleport --host ${target_ip} --port ${port}"
echo "Running -- ${cmd}"
$(${cmd})

if [[ $? -gt 0 ]]; then
    echo ""
    echo "Teleporter had errors trying to start"
    exit 1
fi

read -p "Press [Enter] to end teleportation..."

cmd="VBoxManage modifyvm $vm --teleporter off"
echo "Running -- ${cmd}"
$(${cmd})

echo "Teleporter off"
echo "########################"

