# This script will enable github notifications.

# Create the directory to hold the .ssh keys and secure it.
sudo -u ipnotify mkdir /opt/ipnotify/.ssh/
sudo chmod 700 /opt/ipnotify/.ssh/

# Generate new rsa key pair.
echo "Generating the key pair... Make sure to name it id_rsa."
sudo -u ipnotify ssh-keygen

# Tell the user what the key to paste into github is.
echo "Paste the following public key into github ssh keys."
echo "This will allow ipnotify to push to a given repository on github."
sudo cat /opt/ipnotify/.ssh/id_rsa.pub

# Add id_rsa to github authentication...
sudo touch /opt/ipnotify/.ssh/config
sudo chown ipnotify /opt/ipnotify/.ssh/config
sudo chgrp ipnotify /opt/ipnotify/.ssh/config
sudo chmod 600 /opt/ipnotify/.ssh/config
sudo -u ipnotify echo 'Host github.com' > /opt/ipnotify/.ssh/config
sudo -u ipnotify echo '  User git' >> /opt/ipnotify/.ssh/config
sudo -u ipnotify echo '  Hostname github.com' >> /opt/ipnotify/.ssh/config
sudo -u ipnotify echo '  IdentityFile ~/.ssh/id_rsa' >> /opt/ipnotify/.ssh/config

echo "Please copy and add the above key to github before continuing."
echo "This is needed to continue setup."
echo ""
echo "Please enter the url the github repository to update with the ip."
echo "This repository must already exist. Please create one first."
echo "For example: git@github.com:liamtbrand/ip-history.git"
read -p ": " repourlvar

# Clear any old repository.
sudo -u ipnotify rm -rf /opt/ipnotify/ip-history/

# Clone the repository locally.
sudo -u ipnotify git clone $repourlvar /opt/ipnotify/ip-history/

# Enable github notifications
sudo -u ipnotify echo 'github on' >> /etc/opt/ipnotify/notifications

# Restart the service
echo "Restarting the service to apply changes."
systemctl restart ipnotify.service

echo "Done! You are all setup with GitHub."
echo "Visit your github repository to see the ip address update."
