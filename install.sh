# Install script for installing the service.
# This software depends on python3.

# Create home directory
sudo mkdir /opt/ipnotify/

# Add a user and group for the ipnotify user
echo "[IPNotify]: Creating user and group."
sudo adduser --system --home /opt/ipnotify/ --group ipnotify
sudo chown ipnotify /opt/ipnotify/
sudo chgrp ipnotify /opt/ipnotify/

# Copy the ipnotify app into /opt/ipnotify
echo "[IPNotify]: Copying files to /opt/ipnotify."
# Copy sources into ipnotify
# Here we always override because it acts as an update.
sudo -u ipnotify cp -r src/* /opt/ipnotify/
# Copy the README.md into ipnotify
sudo -u ipnotify cp README.md /opt/ipnotify/

# Create configuration files
echo "[IPNotify]: Creating configuration files..."
sudo mkdir /etc/opt/ipnotify/
sudo chown ipnotify /etc/opt/ipnotify/
sudo chgrp ipnotify /etc/opt/ipnotify/
# Copy the configuratoin files but don't overwrite.
# This will leave any existing config files where they are.
# Delete the configuration files first in order to update them.
sudo -u ipnotify cp -rn config/* /etc/opt/ipnotify/

# Create ip address file
sudo mkdir /var/opt/ipnotify/
sudo chown ipnotify /var/opt/ipnotify/
sudo chgrp ipnotify /var/opt/ipnotify/
sudo -u ipnotify touch /var/opt/ipnotify/ip_address

# Install the service into /etc/systemd/system
sudo cp service/ipnotify.service /etc/systemd/system/ipnotify.service

# Reload the system services
sudo systemctl daemon-reload

# Enable the service
sudo systemctl enable ipnotify.service

# Start the service
sudo systemctl start ipnotify.service

# Notify user to enable updates.
echo "Currently no notifications are sent out."
echo "Run 'sudo /opt/ipnotify/enable-github-notifications.sh' to enable notifications via github."
