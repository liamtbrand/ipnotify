from urllib.request import urlopen

ip_address_file = '/var/opt/ipnotify/ip_address'

def read():
	''' Reads the ip address from file.
	:returns: The ip address in the file.
	'''
	with open(ip_address_file,'r') as f:
		return f.read()

def write(ip_address):
	''' Writes the ip address to file.
	:param ip_address: The ip address to write.
	'''
	with open(ip_address_file,'w') as f:
		f.write(ip_address)

fetch_url = 'http://ip.42.pl/raw-master-server-ip'

def fetch():
	''' Fetches the current ip address from the web.
	'''
	return str(urlopen(fetch_url).read())[2:-1]
