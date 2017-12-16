
# https://www.cyberciti.biz/faq/linux-execute-cron-job-after-system-reboot/

# Start crond automatically at boot time
# Ubuntu/Debian
# update-rc.d cron defaults

# crontab -e



# Run space2ctrl

echo "~/my-scripts/Space2Ctrl/s2cctl start"
echo "~/my-scripts/Space2Ctrl/s2cctl stop"
~/my-scripts/Space2Ctrl/s2cctl start
