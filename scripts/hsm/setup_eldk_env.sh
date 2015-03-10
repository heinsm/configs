#!/bin/bash
# working version 1.0.20140808
# 
# script for switching environments (currently only supports ELDK switching)
# needs to be called by sourcing into current session
# ie. "source [this script]" or ". [this script]"

echo "********************************"
echo "Setting up environment (eldk, etc..) ..."
echo "********************************"
echo
echo "Current path is:"
echo "$PATH"
echo
echo "Stripping.."

output=`echo "$PATH" |              \
    awk 'BEGIN                      \
        { FS=":" }
        {
            for (i=1;i<(NF);i++)
            {
                #exclude eldk when rebuilding PATH
                #exclude SFNT-PED2 when rebuilding PATH
                if (($i !~ /eldk/) && ($i !~ /SFNT-PED2/))
                {
                    print $i,":";
                }
            }
            print $NF
        }'                          \
    | tr -d '[:space:]'`

echo "Base path is:"
echo $output
echo
echo
echo "Make a selection..."
PS3=': '
options=("ELDK 5.1-powerpc" "ELDK 5.2-arm4" "SFNT-PED2-toolchain" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "ELDK 5.1-powerpc")
            output=/opt/eldk-5.1/powerpc-4xx/sysroots/i686-eldk-linux/usr/bin:/opt/eldk-5.1/powerpc-4xx/sysroots/i686-eldk-linux/usr/bin/ppc440e-linux:$output
            break
            ;;
        "ELDK 5.2-arm4")
            output=/opt/eldk-5.2/armv4t/sysroots/i686-eldk-linux/usr/bin:/opt/eldk-5.2/armv4t/sysroots/i686-eldk-linux/usr/bin/armv4t-linux-gnueabi:$output
            break
            ;;
        "SFNT-PED2-toolchain")
            output=/opt/SFNT-PED2:/opt/SFNT-PED2/bin:$output
            break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

export PATH=$output

echo
echo
echo "New path is:"
echo "$PATH"
