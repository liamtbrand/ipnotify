smtp_config_file = '/etc/opt/ipnotify/smtp.conf'

def read():
	''' Read in the smtp configuration.
	:returns: Dictionary containing the mapping stored in the config file.
	'''
	with open(smtp_config_file,'r') as f:
		config = {}
		for line in smtp_config_file:
			key, value = line.split()
			config[key] = value
		return config

def write(config):
	''' Write the smtp configuration.
	:param config: The configuration mapping to store in the config file.
	'''
	with open(smtp_config_file,'w') as f:
		for key in config.keys():
			f.write(key+" "+config[key])
