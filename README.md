# email-linux-update-notifications
A basic script for Linux package update email notifications using cron.

This script was written on and for a system running Ubuntu 20.04, but will likely work with other distros, provided that the short list of dependencies is satisfied.

The only thing that needs to be edited (aside from the `email.template` file) is the `recipient@domain.tld` to the email address of choice.

This was written primarily to be a quick tool used for a small project, but kept here for general reference purposes.

The script, presented without comments:

```
#!/bin/bash

apt update | tee /root/apt.log
apt list --upgradeable | tee -a /root/apt.log 

cat /root/email.template | tee /root/cron_emailupdates.tmp

cat /root/apt.log | tee -a /root/cron_emailupdates.tmp

echo "." >> /root/cron_emailupdates.tmp

/usr/sbin/sendmail -v recipient@domain.tld < /root/cron_emailupdates.tmp

rm /root/cron_emailupdates.tmp
```
