# Install script for installing the service.
# This software depends on python3.

# Add a user and group for the ipnotify user
echo "[IPNotify]: Creating user and group."
sudo adduser --system --group ipnotify

# Copy the ipnotify app into /opt/ipnotify
echo "[IPNotify]: Copying files to /opt/ipnotify."
su ipnotify -c 'mkdir /opt/ipnotify/'
su ipnotify -c 'cp -r src/ /opt/ipnotify/'
su ipnotify -c 'cp README.md /opt/ipnotify/'

# Create configuration files
echo "[IPNotify]: Creating configuration files..."
su ipnotify -c 'mkdir /etc/opt/ipnotify/'
su ipnotify -c 'cp config/smtp.conf /etc/opt/ipnotify/smtp.conf'
su ipnotify -c 'cp config/mailinglist /etc/opt/ipnotify/mailinglist'

# Create ip address file
su ipnotify -c 'mkdir /var/opt/ipnotify/'
su ipnotify -c 'touch /var/opt/ipnotify/ip_address'

# Install the service into /etc/systemd/system
sudo cp service/ipnotify.service /etc/systemd/system/ipnotify.service

# Reload the system services
sudo systemctl daemon-reload

# Start the service
sudo systemctl start ipnotify.service
