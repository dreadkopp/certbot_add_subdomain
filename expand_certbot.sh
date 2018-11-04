#!/bin/bash

certname=$1
newdomain=$2
interactive=0


if [ -z "$newdomain" ]
    then
	interactive=1
fi


#if interactive ask for cert name
if [ $interactive -eq "1" ]
    then
	certnames=$(certbot certificates | grep "Certificate Name:")
	printf "Found the following Certificates:\n\n${certnames}\n\nPlease enter the name of the certificate you want to expand and press ENTER \n"
	read certname
fi

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

#if interactive ask for new domain
if [ $interactive -eq "1" ]
    then
	printf "These are the current domains for the certificate ${certname}: \n${existing}\n\n";
	echo "Please enter the new domain you want to add to that certificate:"
	read newdomain
fi

alldomains="${existing},${newdomain}"

echo $alldomains

#start certbot
certbot certonly --cert-name ${certname} -d ${alldomains}
