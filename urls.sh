#!/bin/bash

## Subdomain Enumeration
	echo "Checking with Assetfinder!";
	assetfinder  -subs-only ncdc.gov.ng | tee -a /home/ibrahim/0Recon/goggletop.txt; 
	echo "Checking with Subfinder!";
	subfinder -d ncdc.gov.ng -silent >> /home/ibrahim/0Recon/goggletop2.txt;
	echo "Checking with Findomain!";
	findomain -t ncdc.gov.ng | tee -a /home/ibrahim/0Recon/goggletop3.txt ;
	echo "Checking with Amass!";
	amass enum -passive -d ncdc.gov.ng -o /home/ibrahim/0Recon/goggletop4.txt;
## Subdomain Concatenation
	cat /home/ibrahim/0Recon/*.txt | sort -u >> recon.txt;
## Subdomain Enumeration Cleanup
	rm -rf /home/ibrahim/0Recon/*.txt;
## Subdomain Live Finding
         echo "Checking with Httprobe!";
	 cat recon.txt | httprobe | tee -a recontko.txt;
## Subdomain Live Finding
         echo "Checking with Paramspider!";
	cat /home/ibrahim/recontko.txt | xargs -I % python3 paramspider.py -l high -o ./OUT/% -d %;
	cat /home/ibrahim/OUT/* | sort -u >>  /home/ibrahim/recontkoparam.txt;
	rm -rf /home/ibrahim/0Recon/*.txt;