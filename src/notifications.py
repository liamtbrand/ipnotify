notifications_file = '/etc/opt/ipnotify/notifications'

def read():
	notifications = { "email":"off", "github":"off" }
	with open(notifications_file,'r') as f:
		for line in f:
			if line != '':
				key, value = line.split(" ")
				notifications[key] = value
	return notifications

def write(notifications):
    with open(notifications_file,'w') as f:
        for key in notifications.keys():
            f.write(key+" "+notifications[key])
