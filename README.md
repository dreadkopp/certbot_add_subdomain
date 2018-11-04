# certbot_add_subdomain
Simple bashscript to expand existing certificates


Usage:

Tested with Letsencrypt certbot 0.22

* download expand_certbot.sh
* set the script as executable (chmod u+x ./expand_certbot.sh)
* run the script interactively (./expand_certbot.sh) 
or with certname and new domain passed as arguments (./expand_certbot.sh   <certname>   <new_domain_to_add>)
