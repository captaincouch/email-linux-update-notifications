#!/bin/bash

# software-update-notifications.sh
# Written by CaptCouch
# Created Feb. 5 2022
# Last Updated Feb. 26 2022
# Email the list of available package updates from apt to bookstack.flytaius.gay admins.
# Written for bash and cron on Ubuntu 20.04 LTS.
# Will likely work for other distros provided that deps are satisifed.
# Dependencies: bash, apt, cron, tee, sendmail

# Get available package updates, then write to a file.
apt update | tee /root/apt.log
apt list --upgradeable | tee -a /root/apt.log 

# Create a temporary file from template that will be used to send the email.
cat /root/email.template | tee /root/cron_emailupdates.tmp

# Write the contents of apt.log to the temp file.
cat /root/apt.log | tee -a /root/cron_emailupdates.tmp

# Write a '.' for sendmail to know to send the email.
echo "." >> /root/cron_emailupdates.tmp

# Send the email to specified addresses.
/usr/sbin/sendmail -v captcouch@captcouch.xyz,caitlyn.k.murton@gmail.com < /root/cron_emailupdates.tmp

# Remove the temporary file now that the email has been sent.
rm /root/cron_emailupdates.tmp
