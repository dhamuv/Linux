#!/bin/bash
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Owner : Dhamu
# Purpose : Script uses 'sed' to search string and delete that line. Appends newline for the same string.
# Example : Finds Protocol, Ciphers and MAC. Replaces new value (line)
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

CLUSTERS=machines

[ ! -f $CLUSTERS ] && { echo "$CLUSTERS file not found"; exit 99; }
while IFS='\n' read -r privateip || [[ -n "$privateip" ]]
do
        echo "Working on $privateip"
        ssh -nTo "StrictHostKeyChecking=no"  $(whoami)@$privateip "sed -i \"/Protocol*/d\" /etc/ssh/sshd_config; sed -i \"$ a\Protocol 2\" /etc/ssh/sshd_config;
                sed -i \"/Ciphers*/d\" /etc/ssh/sshd_config; sed -i \"$ a\Ciphers aes128-ctr,aes192-ctr,aes256-ctr\" /etc/ssh/sshd_config;
                sed -i \"/MACs*/d\" /etc/ssh/sshd_config; sed -i \"$ a\MACs hmac-sha1,hmac-ripemd160\" /etc/ssh/sshd_config;
                service sshd restart"
done < $CLUSTERS
