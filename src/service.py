import subprocess
import time
from urllib.request import urlopen
import smtplib
from socket import timeout
from urllib.error import HTTPError
from urllib.error import URLError
import json
import mailinglist
import ip_address
import smtp_config

sleep_time_in_seconds = 600

def main():
	print("[Info]: IP Notify is starting...")

	last_ip_file = '/var/opt/ipnotify/last_ip'

	old_ip = ip_address.read()
	current_ip = old_ip

	print("[Info]: Ready.")

	while True:
		try:
			current_ip = ip_address.fetch()
			if(old_ip != current_ip):
				print("[Info]: The IP Address changed from \'"+ str(old_ip) +"\' to \'"+ str(current_ip) +"\'.")
				print("[Info]: Sending out mail to mailing list...")
				old_ip = current_ip
				send_update(current_ip)
				ip_address.write(current_ip)
		except (HTTPError, URLError) as error:
			print('[Warning]: Data not retrieved because ',error,' - URL: ', url)
		except timeout:
			print('[Warning]: Socket timed out - URL: ', url)

		time.sleep(sleep_time_in_seconds)

def send_update(ip):

	config = smtp_config.read()
	addr, port = config['smtp-server'].split(":")
	from_email = config['from-email']
	username = config['username']
	password = config['password']

	msg = "\nThe server\'s address has changed to " + ip + "\n"

	try:
		server = smtplib.SMTP(addr, int(port))

		server.ehlo()
		server.starttls()
		server.ehlo()
		server.login(username,password)

		emails = mailinglist.read()
		for email in emails:
			print("[Debug]: Sending mail to "+email)
			server.sendmail(from_email, email, str(msg))

		server.quit()

		print("[Info]: Mail sent.")

	except (Exception) as error:
		print("[Warning]: Unable to send mail to mailing list.")
		print("[Error]: ",error)

if __name__ == "__main__":
	main()
