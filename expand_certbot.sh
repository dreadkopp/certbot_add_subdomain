#!/bin/bash

certnames=$(certbot certificates | grep "Certificate Name:")
printf "Found the following Certificates:\n\n${certnames}\n\nPlease enter the name of the certificate you want to expand and press ENTER \n"
read certname

#get currently existing domains
existing=$(certbot certificates | grep -A 1 "Name: ${certname}" | grep Domains);

#test if there are any certificates for input
if [ -z "$existing" ]
   then
     echo "No domains found for that certificate"
     exit 1
fi

#remove 'Domains' from string
existing=${existing#*Domains}
#remove ':' from string
existing=${existing#*:}
#trim trailing space
existing=$(echo ${existing} | xargs)
#replace spaces with comma
existing=${existing// /,}
printf "These are the current domains for the certificate ${certname}: \n${existing}\n\n";
echo "Please enter the new domain you want to add to that certificate:"
read newdomain
alldomains="${existing},${newdomain}"

certbot certonly --cert-name ${certname} -d ${alldomains}
