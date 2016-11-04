import subprocess
import time
from urllib.request import urlopen
import smtplib
from socket import timeout
from urllib.error import HTTPError
from urllib.error import URLError

def main():
	print("[Info]: IP address updater is starting...")

	f = open('last_ip', 'r')
	old_ip = f.read()
	f.close()
	current_ip = old_ip

	print("[Info]: Ready.")

	while True:
		url = "http://ip.42.pl/raw-master-server-ip"
		try:
			result = urlopen(url).read()
		except (HTTPError, URLError) as error:
			print('[Warning]: Data not retrieved because ',error,' - URL: ', url)
		except timeout:
			print('[Warning]: Socket timed out - URL: ', url)
		else:
			current_ip = str(result)[2:-1]
			if(old_ip != current_ip):
				print("[Info]: The IP Address changed from \'"+ str(old_ip) +"\' to \'"+ str(current_ip) +"\'.")
				print("[Info]: Sending out mail to mailing list...")
				old_ip = current_ip
				send_update(current_ip)

		time.sleep(600)

def send_update(ip):
	fromaddr = 'xythernz@gmail.com'
	admin_addr  = 'liamtahi@gmail.com'
	master_msg = "The master-server\'s IP address has changed to " + ip

	minecraft_port = 28772
	msg = "\nThe minecraft server\'s address has changed to " + ip + ":" + str(minecraft_port) + "\n"

	username = 'xythernz'
	password = 'yRP-sHd-tPu-5W7'
	
	try:
		server = smtplib.SMTP('smtp.gmail.com', 587)

		server.ehlo()
		server.starttls()
		server.ehlo()
		server.login(username,password)

		print("[Debug]: Sending master-server\'s IP address to "+admin_addr)
		server.sendmail(fromaddr, admin_addr, master_msg)

		f = open('mailinglist', 'r')
		for line in f:
			if(line[0] != ";"):
				print("[Debug]: Sending mail to "+line[:-1])
				server.sendmail(fromaddr, line, str(msg))
		f.close()

		server.quit()

		f = open('last_ip', 'w')
		f.write(ip)
		f.close()
		
		print("[Info]: Mail sent.")

	except (Exception) as error:
		print("[Warning]: Unable to send mail to mailing list.")
		print("[Error]: ",error)

main()
