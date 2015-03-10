#!/bin/bash

# working version 1.0.20141114
# 
# script for attaching detaching usb to a VM
# autofinds all usb devices for selection

usbid=""
usbaction=""
vm=""

echo "Apply to which VM..."
PS3=': '
options=("debian-builder" "Appliance" "windows7-64" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "debian-builder" | "Appliance" | "windows7-64")
            vm=${opt}
            break
            ;;
        "Quit")
            exit 1
            ;;
        *) echo invalid option;;
    esac
done

echo "USB action..."
PS3=': '
usbactions=("usbattach" "usbdetach")
select usbaction in "${usbactions[@]}"
do
    break
done

#set field delimiter to use newline as delimiter for the menus
oldIFS=$IFS
IFS=$'\n'
echo "Select Device.."
usbdevices=($(vboxmanage list usbhost | grep 'Product:\|Manufacturer' | tr -s ' ' | sed -e ':a;N;s/\nProduct://g' | sed -e 's/Manufacturer: //g'))

PS3=': '
select usbdevice in "${usbdevices[@]}"
do
    break
done
#restore the field delimiter 
IFS=$oldIFS

#find associated UUID for the selected usb device
usbids=($(vboxmanage list usbhost | grep UUID | tr -s ' ' | cut -d ' ' -f 2))
usbdevice_id=-1
for (( i = 0; i < ${#usbdevices[@]}; i++ )); do
   if [ "${usbdevices[$i]}" = "${usbdevice}" ]; then
       usbdevice_id=$i;
   fi
done

if [[ "$usbdevice_id" != "-1" ]]; then
    usbid=${usbids[$usbdevice_id]}
    cmd="vboxmanage controlvm ${vm} ${usbaction} ${usbid}"
    
    echo "#####################"
    echo "Running - ${cmd}"
    $($cmd)
    echo "#####################"
else
    echo "USB DEVICE NOT FOUND!"
fi
