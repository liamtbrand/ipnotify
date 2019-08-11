# IP Change Email Notifier

This program simply notifies the list of recipients of the change in ip of the machine running the software.

# Install

1. Clone the repository onto your computer `git clone git@github.com:liamtbrand/ipnotify.git ipnotify`.
2. Open the repository: `cd ipnotify`.
3. Execute the install script: `./install.sh`.
  - If this doesn't work, try `chmod +x install.sh` first.
4. Done! That was easy. Now the service will start by itself each time your computer starts. Now see configure.

# Configure
- Edit the mailing list: `vim /etc/opt/ipnotify/mailinglist`
- Edit the SMTP details: `vim /etc/opt/ipnotify/smtp.conf`

The changes are effective immediately as the service reads them for each access.

NOTE: Now the mailing list is disabled. Instead we use the ip-history git repository.
TODO: Write so that system sets ip address in ip-history repository and commits this by itself.
Currently the script to do this is in liamtbrand/ip-history repository.

# TODO:

Install needs to not override the configuration files.
This means that install will do an update of the ipnotify app.
