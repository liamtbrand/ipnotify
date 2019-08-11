# Update and push changes to master on git repository ip-history
# Should be executed as user ipnotify.
# Assumes a directory ip-history that contains the repository to update.
# To setup: clone into ip-history a repository with a remote on github.
# You'll need to add keys to .ssh/ as well.

# Change into the ip-history directory
mkdir ip-history # create if doesnt exist
cd ip-history

# Set our credentials as the ipnotify bot.
git config user.email "ipnotify@localhost"
git config user.name "ipnotify"

# Make sure we fetch any changes first so we don't encounter issues.
git pull

# Copy the ip_address file so that we can update it in the repository.
# We want to store it as plaintext so the browser will display it too.
cp /var/opt/ipnotify/ip_address ip_address.txt

# Add the file and commit it.
git add ip_address.txt
git commit -m "Update ip address"
git push
