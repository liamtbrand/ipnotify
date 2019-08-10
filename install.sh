# Install script for installing the service.
# This software depends on python3.

# Add a user and group for the ipnotify user
echo "[IPNotify]: Creating user and group."
sudo adduser --system --no-create-home --group ipnotify

# Copy the ipnotify app into /opt/ipnotify
echo "[IPNotify]: Copying files to /opt/ipnotify."
sudo mkdir /opt/ipnotify/
sudo chown ipnotify /opt/ipnotify/
sudo chgrp ipnotify /opt/ipnotify/
sudo -u ipnotify cp -r src/* /opt/ipnotify/
sudo -u ipnotify cp README.md /opt/ipnotify/

# Create configuration files
echo "[IPNotify]: Creating configuration files..."
sudo mkdir /etc/opt/ipnotify/
sudo chown ipnotify /etc/opt/ipnotify/
sudo chgrp ipnotify /etc/opt/ipnotify/
sudo -u ipnotify cp -r config/* /etc/opt/ipnotify/

# Create ip address file
sudo mkdir /var/opt/ipnotify/
sudo chown ipnotify /var/opt/ipnotify/
sudo chgrp ipnotify /var/opt/ipnotify/
sudo -u ipnotify touch /var/opt/ipnotify/ip_address

# Install the service into /etc/systemd/system
sudo cp service/ipnotify.service /etc/systemd/system/ipnotify.service

# Reload the system services
sudo systemctl daemon-reload

# Start the service
sudo systemctl start ipnotify.service
