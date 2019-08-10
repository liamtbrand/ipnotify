mailinglist_file = '/etc/opt/ipnotify/mailinglist'

def read():
	''' Reads the entire mailing list from the mailing list file.
	:returns: The mailing list as a list of emails.
	'''
	with open(mailinglist_file,'r') as f:
		mailinglist = []
		for line in f:
			if line != '':
				mailinglist.append(line)
		return mailinglist

def write(mailinglist):
	''' Writes the entire mailing list to the mailing list file.
	:param mailinglist: A list of emails.
	'''
	with open(mailinglist_file,'w') as f:
		for email in mailinglist:
			f.write(email)

def add_email(email):
	''' Add an email to the mailing list.
	:param email: The email to add to the mailing list.
	'''
	mailinglist = read()
	mailinglist.append(email)
	write(mailinglist)

def remove_email(email):
	''' Remove an email from the mailing list.
	:param email: The email to remove from the mailing list.
	'''
	mailinglist = read()
	mailinglist = [entry for entry in mailinglist if entry != email]
	write(mailinglist)
