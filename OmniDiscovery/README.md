# OmniDiscovery
[![License](https://img.shields.io/badge/license-MIT-red.svg)](https://github.com/cybersmeashish/Passive-recon-tool-cybersmeashish/blob/master/LICENSE.md)  [![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)]()  [![Version](https://img.shields.io/badge/Release-1.2.1-red.svg?maxAge=259200)]()  [![Build](https://img.shields.io/badge/Supported_OS-Linux-yellow.svg)]()  [![Build](https://img.shields.io/badge/Supported_WSL-Windows-blue.svg)]() [![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/cybersmeashish/Passive-recon-tool-cybersmeashish/issues)

### Advanced Subdomain Enumeration & Analysis Framework

```
 ___                   _____  _                                          
|   \ _ __  _ _ ___ ___ |    \(_)___ __ _____ _____ _ _ _  _           
|   || '  \| ' \| | ||  |  | (_-</ _/ _ \ V / -_) '_| || |          
|___/|_|_|_|_||_|_|_||____/|_/__/\__\___/\_/\___|_|  \_, |          
                                                          |__/ v1.2.1#dev
```

***OmniDiscovery*** is a comprehensive subdomain enumeration tool designed to collect subdomains and analyze domains through advanced automated reconnaissance techniques. This powerful framework is ideal for OSINT (Open-source intelligence) activities, penetration testing, and bug bounty hunting.

## Features !
##### OmniDiscovery provides these 20+ powerful features:
-  Easy, light, fast and powerful. Bash script (controller) is available by default in almost all Linux distributions. By using bash script multiprocessing feature, all processors will be utilized optimally.
-  Subdomain enumeration process can be achieved by using **active** method or **passive** method
    - **Active Method**
        - *OmniDiscovery* utilizes Gobuster tools because of its high-speed performance in carrying out DNS Subdomain Bruteforce attacks (wildcard support). The wordlist that is used comes from combined SecList (Discover/DNS) lists which contains around 3 million entries

    - **Passive Method**
        - By evaluating and **selecting** the **good** third-party sites/resources, the enumeration process can be **optimized**. More results will be obtained with less time required. *OmniDiscovery* can collect data from these well-curated 22 third-party sites:

				https://censys.io
				https://developer.shodan.io
				https://dns.bufferover.run
				https://index.commoncrawl.org 
				https://riddler.io 
				https://api.certspotter.com
				https://api.hackertarget.com 
				https://api.threatminer.org
				https://community.riskiq.com
				https://crt.sh
				https://dnsdumpster.com
				https://docs.binaryedge.io
				https://securitytrails.com
				https://graph.facebook.com
				https://otx.alienvault.com
				https://rapiddns.io
				https://spyse.com
				https://urlscan.io
				https://www.dnsdb.info
				https://www.virustotal.com
				https://threatcrowd.org
				https://web.archive.org
- Test the list of collected subdomains and probe for working http or https servers. This feature uses a third-party tool, [httprobe](https://github.com/tomnomnom/httprobe "httprobe").
- Subdomain availability test based on Ping Sweep and/or by getting HTTP status code.
- The ability to detect virtualhost (several subdomains which resolve to single IP Address). OmniDiscovery will resolve the collected subdomains to IP addresses, then classify them if several subdomains resolve to single IP address. This feature will be very useful for the next penetration testing/bug bounty process. For instance, in port scanning, single IP address won't be scanned repeatedly
- Performed port scanning from collected subdomains/virtualhosts IP Addresses
- Testing Subdomain TakeOver attack (CNAME Resolver, DNSLookup, Detect NXDomain, Check Vuln)
- Taking Screenshots of subdomains default using gowitness or you can choice another screenshot tools, like (-ss webscreeenshot)
- Identify technologies on websites (category,application,version)
- Detection urls, ports, title, content-length, status-code, response-body probbing.
- Smart auto fallback from https to http as default.
- Data Collecting/Scraping open port from 3rd party (Default::Shodan), For right now just using Shodan [Future::Censys,Zoomeye]. More efficient and effective to collecting port from list ip on target [[ Subdomain > IP Resolver > Crawling > ASN & Open Port ]]
- Collecting Juicy URL & Extract URL Parameter ( Resource Default::WebArchive, CommonCrawl, UrlScanIO) 
- Collect interesting path (api|.git|admin|etc), document (doc|pdf), javascript (js|node) and parameter
- Define path for outputfile (specify an output file when completed) 
- Check an IP is Owned by Cloudflare 
- Generate & make wordlist based on collecting url resources (wayback,urlscan,commoncrawl. To make that, we Extract All the paramater and path from our domain recon
- Generate Network Graph Visualization Subdomain & Virtualhosts
- Report output in HTML & CSV format
- Sending notifications to a slack channel

## How OmniDiscovery Works 
How OmniDiscovery works or recon flow, when you run the best arguments to collect subdomains and analyze by doing automatic recon.
```
root@maland: ./omnidiscovery -d bugcrowd.com -dP -eP -rS -cF -pS -tO -gW --httpx --dnsprobe  -aI webanalyze -sS
```

### Recon Workflow
This Recon Workflow OmniDiscovery v1.2.1#dev 

![Recon Workflow](./images/omnidiscovery-workflow.png)

### Detail information
Detail information File Reconnaissance & Juicy Data
```
------------------------------------------------------------------------------------------------------

- subdomain.txt             -- Subdomain list             < $DOMAIN (Target)
- httprobe_subdomain.txt    -- Validate Subdomain	  < subdomain.txt
- webanalyzes.txt           -- Identify technology scan   < httprobe_subdomain.txt
- httpx_status_title.txt    -- title+statuscode+lenght    < httprobe_subdomain.txt
- dnsprobe_subdomain.txt    -- Subdomain resolv		  < subdomain.txt
- Subdomain_Resolver.txt    -- Subdomain resolv (alt)     < subdomain.txt
- cf-ipresolv.txt           -- Cloudflare scan        	  < ip_resolver.txt 
- Live_hosts_pingsweep.txt  -- Live Host check		  < ip_resolver.txt	 
- ip_resolver.txt           -- IP resolv list          	  < Subdomain_Resolver::dnsprobe
- ip_dbasn.txt		    -- ASN Number Check		  < ip_resolver.txt
- vHost_subdomain.txt       -- Virtual Host (Group by ip) < Subdomain_Resolver.txt
- nmap_top_ports.txt        -- Active port scanning       < cf-ipresolv.txt
- ip_dbport.txt		    -- Passive port scanning	  < cf-ipresolv.txt

------------------------------------------------------------------------------------------------------
- Passive_Collect_URL_Full.txt 		-- Full All Url Crawl (WebArchive, CommonCrawl, UrlScanIO)
------------------------------------------------------------------------------------------------------

- ./screenshots/report-0.html   	-- Screenshoting report    	< httprobe_subdomain.txt
- ./screenshots/gowitness/gowitness.sqlite3   		-- Database screenshot    	< httprobe_subdomain.txt

------------------------------------------------------------------------------------------------------

- ./interest/interesturi-allpath.out	-- Interest path(/api,/git,etc) < Passive_Collect_URL_Full.txt
- ./interest/interesturi-doc.out	-- Interest doc (doc,pdf,xls)   < Passive_Collect_URL_Full.txt
- ./interest/interesturi-otherfile.out	-- Other files (.json,.env,etc) < Passive_Collect_URL_Full.txt
- ./interest/interesturi-js.out		-- All Javascript files(*.js)  	< Passive_Collect_URL_Full.txt
- ./interest/interesturi-nodemodule.out	-- Files from /node_modules/    < Passive_Collect_URL_Full.txt
- ./interest/interesturi-param-full.out	-- Full parameter list 		< Passive_Collect_URL_Full.txt
- ./interest/interesturi-paramsuniq.out -- Full Uniq parameter list 	< Passive_Collect_URL_Full.txt

-  Notes : You can validate juicy/interest urls/param using urlprobe or httpx to avoid false positives
------------------------------------------------------------------------------------------------------

- ./takeover/CNAME-resolv.txt		-- CNAME Resolver 		< subdomain.txt
- ./takeover/TakeOver-Lookup.txt	-- DNSLookup 			< CNAME-resolv.txt
- ./takeover/TakeOver-nxdomain.txt	-- Other 3d service platform	< TakeOver-Lookup.txt
- ./takeover/TakeOver.txt		-- Checking Vulnerabilty	< CNAME-resolv.txt

------------------------------------------------------------------------------------------------------

- ./wordlist/wordlist-parameter.lst     -- Generate params wordlist     < Passive_Collect_URL_Full.txt
- ./wordlist/wordlist-pathurl.lst       -- Generate List paths wordlis  < Passive_Collect_URL_Full.txt

-  Notes : This Wordlist based on domain & subdomain information (path,file,query strings & parameter)
------------------------------------------------------------------------------------------------------
```

## Installation
*OmniDiscovery* is currently extended with the following tools. Instructions on how to install & use the application are linked below.

### To Download OmniDiscovery From Github
```bash
# Clone this repository
git clone --recursive https://github.com/cybersmeashish/Passive-recon-tool-cybersmeashish.git
```

### Dependencies
```
$ python3 -m pip install -r requirements.txt
```
*OmniDiscovery* requires [jq](https://stedolan.github.io/jq/download/) and [GNU grep](https://www.gnu.org/software/grep/) to run and parse. Information on how to download and install jq can be accessed [here](https://stedolan.github.io/jq/download/)

```bash
# Linux
apt-get update
apt-get install jq nmap phantomjs npm chromium parallel
npm i -g wappalyzer wscat

# Mac
brew cask install phantomjs 
brew install jq nmap npm parallel grep
npm i -g wappalyzer wscat

# Note
All you would need is an installation of the latest Google Chrome or Chromium 
Set the PATH in rc file for GNU grep changes
```

### Post Installation
API Key is needed before querying on third-party sites, such as ```Shodan, Censys, SecurityTrails, Virustotal,``` and ```BinaryEdge```.
- The API key setting can be done in omnidiscovery.api file.
```bash
# Shodan
# URL :  http://developer.shodan.io
# Example :
#      - SHODAN_API="VGhpc1M0bXBsZWwKVGhmcGxlbAo"

SHODAN_API=""

# Censys
# URL : https://search.censys.io/register

CENSYS_API=""
CENSYS_SECRET=""

# Virustotal
# URL : https://www.virustotal.com/gui/
VIRUSTOTAL=""

# Binaryedge
# URL : https://app.binaryedge.io/login
BINARYEDGE=""

# SecurityTrails
# URL : https://securitytrails.com/
SECURITY_TRAILS=""
```

## Usage

```text
 ___                   _____  _                                          
|   \ _ __  _ _ ___ ___ |    \(_)___ __ _____ _____ _ _ _  _           
|   || '  \| ' \| | ||  |  | (_-</ _/ _ \ V / -_) '_| || |          
|___/|_|_|_|_||_|_|_||____/|_/__/\__\___/\_/\___|_|  \_, |          
                                                          |__/ v1.2.1#dev by @screetsec 
OmniDiscovery - Fast Subdomain Enumeration and Analyzer      
         https://github.com/cybersmeashish/Passive-recon-tool-cybersmeashish

Usage: omnidiscovery.sh [-h [--help]] [-s[--source]][-d[--domain=]] 

Example: omnidiscovery.sh -d example.com   
         omnidiscovery.sh -s Shodan,VirusTotal -d example.com

Best Argument:
  omnidiscovery -d domain.com -dP -eP -rS -cF -pS -tO -gW --httpx --dnsprobe  -aI webanalyze --slack -sS

Optional Arguments:
  -a,  --all             Running all Enumeration, no nmap & gobuster 
  -b,  --bruteforce      Bruteforce Subdomain Using Gobuster (Wordlist: ALL Top SecList DNS) 
  -d,  --domain          domain of the website to scan
  -h,  --help            show this help message
  -o,  --outfile         specify an output file when completed 
  -s,  --source          Use source for Enumerate Subdomain
  -aI, --apps-identifier Identify technologies on website (ex: -aI webanalyze)
  -dP, --db-port         Collecting port from 3rd Party default=shodan
  -eP, --extract-params  Collecting URL Parameter from Engine
  -tO, --takeover        Subdomain TakeOver Vulnerabilty Scanner
  -wS, --websocket       WebSocket Connection Check
  -cF, --cloudfare       Check an IP is Owned by Cloudflare
  -pS, --ping-sweep      Check live host using methode Ping Sweep
  -rS, --resolver        Convert domain lists to resolved IP lists without duplicates
  -sC, --status-code     Get status codes, response from domain list
  -nT, --nmap-top        Port scanning with top-ports using nmap from domain list
  -sS, --screenshot      Screenshots a list of website (default: gowitness)
  -nP, --no-passive      Do not perform passive subdomain enumeration 
  -gW, --gwordlist       Generate wordlist based on collecting url resources (Passive) 
       --httpx           Perform httpx multiple probers using retryablehttp 
       --dnsprobe        Perform multiple dns queries (dnsprobe) 
       --no-probe        Do not perform httprobe 
       --html            Make report output into HTML 
       --graph           Network Graph Visualization
```

To use all 22 Sources and Probe for working http or https servers (Validations):
```
$ omnidiscovery -d hackerone.com
```
To use one or more source:
```
$ omnidiscovery -s shodan,dnsdumpster,webarchive -d hackerone.com
```
To use all Sources Without Validations:
```
$ omnidiscovery -d hackerone.com --no-probe
```
To use one or more plugins:
```
$ omnidiscovery -pS -sC -sS -d hackerone.com
```
To use all plugins: testing host status, http/https status code, subdomain takeover and screenshots. 

Nmap,Gobuster,wappalyzer and wscat Not Included.
```
$ omnidiscovery -d hackerone.com --all 
```

To create report in HTML Format
```
$ omnidiscovery -d hackerone.com --html --all
```

To generate network graph visualization subdomain & virtualhosts
```
$ omnidiscovery -d hackerone.com -rS --graph
```

To use best arguments to collect subdomains, analyze by doing automatic recon and sending notifications to slack
```
./omnidiscovery -d ngesec.id -dP -eP -rS -cF -pS -tO -gW --httpx --dnsprobe --graph  -aI webanalyze --slack -sS
```

## Credits & Thanks
- [Tom Hudson](https://github.com/tomnomnom/) - Tomonomnom
- [OJ Reeves](https://github.com/OJ/) - Gobuster
- [ProjectDiscovery](https://github.com/projectdiscovery) - Security Through Intelligent Automation
- [Thomas D Maaaaz](https://github.com/maaaaz) - Webscreenshot
- [Dwi Siswanto](https://github.com/dwisiswant0) - cf-checker
- [Robin Verton](https://github.com/rverton/webanalyze) - webanalyze
- [christophetd](https://github.com/christophetd/censys-subdomain-finder) - Censys
- [Daniel Miessler](https://github.com/danielmiessler/) - SecList
- [EdOverflow](https://github.com/EdOverflow/) - can-i-take-over-xyz
- [Edo maland ~ @screetsec](https://github.com/screetsec) - Original Sudomy Creator
- [NgeSEC](https://ngesec.id/) - Community
- [Zerobyte](http://zerobyte.id/) - Community
- [Gauli(dot)Net](https://gauli.net/) - Lab Hacking Indonesia
- [Bugcrowd](https://www.bugcrowd.com/) & [Hackerone](https://www.hackerone.com/)

## License
MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Disclaimer
This tool is for educational and authorized testing purposes only. Users are responsible for complying with applicable laws and regulations. The developers assume no liability for misuse or damage caused by this program.