#!/bin/bash

#check the .conf files in downloaded directory
function copyconf {
if [ ! -f /etc/root-ca.conf ]; then
copyconf1
fi
}

function copyconf1 {
 if [ ! -f email.conf ]; then
        echo ""
        echo "Please put all the four .conf files in this directory for first time execution of script"
        echo "----------------------------------------------------------------------------------------"
        echo "                                  !!!!TRY AGAIN!!!!!                                    "
        exit 99

        else
        cp -n *.conf /etc/
fi
}
{
echo " "
echo "

             ██████╗░░░░░░░██████╗░██╗░░██╗██╗
             ██╔══██╗░░░░░░██╔══██╗██║░██╔╝██║
             ██████╦╝█████╗██████╔╝█████═╝░██║
             ██╔══██╗╚════╝██╔═══╝░██╔═██╗░██║
             ██████╦╝░░░░░░██║░░░░░██║░╚██╗██║
             ╚═════╝░░░░░░░╚═╝░░░░░╚═╝░░╚═╝╚═╝ v 1.0 "

echo "
                   𝘽 𝙖 𝙨 𝙞 𝙘 𝙋 𝙆 𝙄"

echo "             +~+~+~+~+~+~+~+~+~+~+~+~+~ "
echo " "
echo "         <--mohamedazarudeen.it@gmail.com-->"
echo "          ********************************* "
echo "		     RNTrust Dubai		  "	
echo "        < ~~~ b-PKI / Created for Learning~~~>"
echo "             +~+~+~+~+~+~+~+~+~+~+~+~+~ "
}
{
  echo   " "
  echo   " "
  echo   " THIS IS THE BASIC PKI CREATED ONLY USING OPENSSL AND SHELL SCRIPT"
  echo   "         YOU CAN USE THIS SCRIPT FOR TESTING PURPOSE       "
  echo   " "
  echo   " "
  echo   " "
}


OPENSSL_BIN="/usr/bin/openssl"

##Function to create directories
function create_directories {
              if [ ! -d /etc/b-pki ]; then  

		echo ""
		mkdir -p /etc/b-pki/ca/root-ca/private 
		mkdir -p /etc/b-pki/ca/root-ca/db 
		mkdir -p /etc/b-pki/ca/root-ca/crl 
		mkdir -p /etc/b-pki/ca/root-ca/certs
                mkdir -p /etc/b-pki/certificates
                chmod 700 -R /etc/b-pki/
                 # create database
                cp /dev/null /etc/b-pki/ca/root-ca/db/root-ca.db
                cp /dev/null /etc/b-pki/ca/root-ca/db/root-ca.db.attr
                echo 01 > /etc/b-pki/ca/root-ca/db/root-ca.crt.srl
                echo 01 > /etc/b-pki/ca/root-ca/db/root-ca.crl.srl
		# create directories
  		mkdir -p /etc/b-pki/ca/signing-ca/private /etc/b-pki/ca/signing-ca/db /etc/b-pki/ca/signing-ca/crl /etc/b-pki/ca/signing-ca/certs
  		chmod 700 /etc/b-pki/

  		# create database
  		cp /dev/null /etc/b-pki/ca/signing-ca/db/signing-ca.db
  		cp /dev/null /etc/b-pki/ca/signing-ca/db/signing-ca.db.attr
  		echo 01 > /etc/b-pki/ca/signing-ca/db/signing-ca.crt.srl
  		echo 01 > /etc/b-pki/ca/signing-ca/db/signing-ca.crl.srl
		echo ""
		echo "-------------------------------- Dɪʀᴇᴄᴛᴏʀɪᴇs Cʀᴇᴀᴛᴇᴅ-------------------------------------"
		echo "-------------------Find all the files and folders here-> /etc/b-pki/ -----------------------"
		
		else
		echo "Checking Directories..."
		echo " "
		echo "-------------------------------------------------"
		echo "Folders are available /etc/b-pki/, Please proceed"
		echo "-------------------------------------------------"
		echo ""
		echo ""
		fi
		startup
		} 

#Function to create root ca

function create_root_ca
                         {
                        echo ""
			echo "-----------------------------------------------------------------"
			echo "           We are going to create Root Key                       "
			echo "	Remember the password of this key file to create subordinate CA"
			echo "-----------------------------------------------------------------"
			echo ""
                        # create CA request
                          $OPENSSL_BIN req -new \
                            -config /etc/root-ca.conf \
                            -out /etc/b-pki/ca/root-ca.csr \
                            -keyout /etc/b-pki/ca/root-ca/private/root-ca.key
			if [ $? -eq 0 ]; then
			echo ""
			echo ""
                        echo "-----------------------------------------------------------------"
                        echo "                  YOUR ROOT KEY IS CREATED	               "
                        echo "     HOPE YOU WILL REMEMBER THE PASSWORD YOU ENTERED             "
                        echo "-----------------------------------------------------------------"
                        echo ""
			echo ""
			read -n 1 -s -r -p "Press any key to continue"	
			fi
                          # create CA certificate
                          $OPENSSL_BIN ca -selfsign \
                            -config /etc/root-ca.conf \
                            -in /etc/b-pki/ca/root-ca.csr \
                            -out /etc/b-pki/ca/root-ca.crt \
                            -extensions root_ca_ext

			if [ $? -eq 0 ]; then
			echo "------------------------------------------"
			echo "You have successfully Created your Root CA"
			echo "------------------------------------------"
			echo ""
			echo "Menu Restarted, Please create Sign CA now!!!"
			echo ""
			echo ""
			startup
			fi
	
	                 }

#Check Root CA is created or not
function check_root_ca {
if [ -f /etc/b-pki/ca/root-ca/01.pem ]; then
	echo ""
	echo ""
        echo "It seems you already have a Root CA, do you want to create new Root CA?"
        echo ""
        read -p "Confirmation (yes/no):" var1
                if [ "$var1" = "no" ]; then
                exit 99
		fi
                if [ "$var1" = "yes" ]; then
                echo ""
		echo ""
		rm -rf /etc/b-pki/ca/root-ca/db/root-ca.db root-ca.db.attr root-ca.crt.srl root-ca.crl.srl
		cp /dev/null /etc/b-pki/ca/root-ca/db/root-ca.db
                cp /dev/null /etc/b-pki/ca/root-ca/db/root-ca.db.attr
                echo 01 > /etc/b-pki/ca/root-ca/db/root-ca.crt.srl
                echo 01 > /etc/b-pki/ca/root-ca/db/root-ca.crl.srl
		rm -rf /etc/b-pki/ca/signing-ca/db/signing-ca.db signing-ca.db.attr signing-ca.crt.srl signing-ca.crl.srl
		cp /dev/null /etc/b-pki/ca/signing-ca/db/signing-ca.db
                cp /dev/null /etc/b-pki/ca/signing-ca/db/signing-ca.db.attr
                echo 01 > /etc/b-pki/ca/signing-ca/db/signing-ca.crt.srl
                echo 01 > /etc/b-pki/ca/signing-ca/db/signing-ca.crl.srl
		echo "-------------------------------------------------------------------"
		echo "                              WARNING !!!!                         "
		echo "            You can now recreate Subordinate CA using new key      "
		echo ""
		echo "                Your old Root key will not work any more           "
		echo ""
		echo "-------------------------------------------------------------------"
		create_root_ca
		else
		echo ""
        	echo "WRONG INPUT, Please type yes or no"
	        echo ""
		
		fi
	else
	create_root_ca
fi
}


#Function to create Signing CA
function create_signing_ca {
			
			echo ""
                        echo "-----------------------------------------------------------------"
                        echo "           We are going to create Subordinate CA  Key            "
                        echo "  Remember the password of this key file to create certificates  "
                        echo "-----------------------------------------------------------------"
                        echo ""
 

 # create CA request
  $OPENSSL_BIN req -new \
    -config /etc/signing-ca.conf \
    -out /etc/b-pki/ca/signing-ca.csr \
    -keyout /etc/b-pki/ca/signing-ca/private/signing-ca.key
			if [ $? -eq 0 ]; then
			echo ""
                        echo ""
                        echo "-----------------------------------------------------------------"
                        echo "                  YOUR SUBORDINATE KEY IS CREATED                "
                        echo "     HOPE YOU WILL REMEMBER THE PASSWORD YOU ENTERED             "
                        echo "-----------------------------------------------------------------"
                        echo ""
                        echo ""
                        read -n 1 -s -r -p "Press any key to continue"
			fi
  # create CA certificate
  $OPENSSL_BIN ca \
    -config /etc/root-ca.conf \
    -in /etc/b-pki/ca/signing-ca.csr \
    -out /etc/b-pki/ca/signing-ca.crt \
    -extensions signing_ca_ext
			
			if [ $? -eq 0 ]; then
			echo ""
			echo ""
			echo "-------------------------------------------------"
                        echo "   You have successfully Created your Signing CA "
                        echo "-------------------------------------------------"
                        echo ""
                        echo "Menu Restarted, You Can now created your certificates now!!!"
                        echo ""
                        echo ""

			startup
			fi
}

##function to check SigningCA is created or not
function check_signing_ca {
if [ -f /etc/b-pki/ca/root-ca/01.pem ]; then

if [ -f /etc/b-pki/ca/root-ca/02.pem ]; then
echo ""
echo ""
echo "You already have a signing CA, Do you want to replace Signing-CA now?"
echo ""
read -p "Confim (yes/no): " var1
if [ "$var1" = "no" ]; then

         exit 99
fi
if [ "$var1" = "yes" ]; then

echo ""
echo ""
echo "-------------------------------------------------------------------"
echo "                              WARNING !!!!                         "
echo " You can now create Server & Email Certificates using new key only"
echo ""
echo "                Your old key will not work any more               "
echo ""
echo "-------------------------------------------------------------------"
        create_signing_ca
else
	echo ""
        echo "WRONG INPUT, Please type yes or no"
        echo ""

fi
else
create_signing_ca
fi
else 
echo ""
echo ""
echo "---------------------"
echo " CREATE ROOT CA FIRST"
echo "---------------------"
echo ""
fi
}

#Function to create Client Certificates

function create_server {
if [ -f /etc/b-pki/ca/root-ca/02.pem ]; then
echo ""
read -p "Enter your SAN, Your SAN name is also your Filename (example: xyz): " FILE_NAME
echo ""
if [[ $FILE_NAME = *" "* ]]; then
  echo ""
  echo "Please avoid space !!!"
  echo ""
  create_server

else

SAN=DNS:$FILE_NAME \
$OPENSSL_BIN req -new \
    -config /etc/server.conf \
    -out /etc/b-pki/certificates/$FILE_NAME.csr \
    -keyout /etc/b-pki/certificates/$FILE_NAME.key

  $OPENSSL_BIN ca \
    -config /etc/signing-ca.conf \
    -in /etc/b-pki/certificates/$FILE_NAME.csr \
    -out /etc/b-pki/certificates/$FILE_NAME.crt \
    -extensions server_ext

			if [ $? -eq 0 ]; then
                        echo ""
                        echo ""
                        echo ""
			echo "You have successfully Created your Server Certificate"
                        echo ""
                        echo ""
			echo "#####################################################################"
			echo "#####################################################################"
			echo ""
			echo "Please find the Certificate details below"
			echo "-----------------------------------------"
			echo ""
			echo "$(openssl x509 -noout -subject -issuer -startdate -enddate -in /etc/b-pki/certificates/$FILE_NAME.crt)"
			echo "Certificates and Keys saved in -> /etc/b-pki/certificates/$FILE_NAME.crt"
			echo ""
			echo "#####################################################################"
			echo "#####################################################################"
			echo ""
			echo ""
                        echo "Menu Restarted, You Can now create more certificates !!!"
			echo "--------------------------------------------------------"
                        echo ""
                        echo ""

			startup
                        fi
	fi
else
echo ""
echo ""
echo "----------------------------"
echo " CREATE SIGNING/SUB CA FIRST"
echo "----------------------------"
echo ""
fi

}

function create_email {
if [ -f /etc/b-pki/ca/root-ca/02.pem ]; then
echo ""
echo ""
read -p "Enter your filename to identify certificate after generated (example: xyz): " FILE_NAME
echo ""
 $OPENSSL_BIN req -new \
    -config /etc/email.conf \
    -out /etc/b-pki/certificates/$FILE_NAME.csr \
    -keyout /etc/b-pki/certificates/$FILE_NAME.key

  $OPENSSL_BIN ca \
    -config /etc/signing-ca.conf \
    -in /etc/b-pki/certificates/$FILE_NAME.csr \
    -out /etc/b-pki/certificates/$FILE_NAME.crt \
    -extensions email_ext

			if [ $? -eq 0 ]; then
                        echo ""
                        echo ""
                        echo ""
			echo -n "You have successfully Created your Email Certificate"
                        echo ""
                        echo ""
                        echo "#####################################################################"
                        echo "#####################################################################"
                        echo ""
                        echo "Please find the Certificate details below"
                        echo "-----------------------------------------"
                        echo ""
                        echo "$(openssl x509 -noout -subject -issuer -startdate -enddate -in /etc/b-pki/certificates/$FILE_NAME.crt)"
                        echo "Certificates and Keys saved in -> /etc/b-pki/certificates/$FILE_NAME.crt"
                        echo ""
                        echo "#####################################################################"
                        echo "#####################################################################"
                        echo ""
                        echo ""
                        echo "Menu Restarted, You Can now create more certificates !!!"
                        echo "--------------------------------------------------------"
                        echo ""
                        echo ""
			startup
			fi

else
echo ""
echo ""
echo "----------------------------"
echo " CREATE SIGNING/SUB CA FIRST"
echo "----------------------------"
echo ""
fi

}

function signingca_crl {
if [ -f /etc/b-pki/ca/root-ca/02.pem ]; then
openssl ca -gencrl \
    -config /etc/signing-ca.conf \
    -out /etc/b-pki/ca/signing-ca/crl/signing-ca.crl
 if [ $? -eq 0 ]; then
                        echo ""
                        echo ""
                        echo ""
                        echo -n "You have successfully Created/Issued CRL"
                        echo ""
                        echo ""
                        echo "#####################################################################"
                        echo "#####################################################################"
                        echo ""
                        echo "Please find the CRLs in following path -> /etc/b-pki/ca/signing-ca/crl/signing-ca.crl"
                        echo ""
                        echo "#####################################################################"
                        echo "#####################################################################"
                        echo ""
fi
else
echo ""
echo ""
echo "----------------------------"
echo " CREATE SIGNING/SUB CA FIRST"
echo "----------------------------"
echo ""
fi

}

function rootca_crl {
if [ -f /etc/b-pki/ca/root-ca/01.pem ]; then
openssl ca -gencrl \
    -config /etc/root-ca.conf \
    -out /etc/b-pki/ca/root-ca/crl/root-ca.crl
 if [ $? -eq 0 ]; then
                        echo ""
                        echo ""
                        echo ""
                        echo -n "You have successfully Created/Issued CRL"
                        echo ""
                        echo ""
                        echo "#####################################################################"
                        echo "#####################################################################"
                        echo ""
                        echo "Please find the CRLs in following path -> /etc/b-pki/ca/root-ca/crl/root-ca.crl"
                        echo ""
                        echo "#####################################################################"
                        echo "#####################################################################"
                        echo ""
fi
else
echo ""
echo ""
echo "----------------------------"
echo " CREATE ROOT CA FIRST"
echo "----------------------------"
echo ""
fi

}


function backup {
mkdir -p /root/b-pki/backup
tar -zcvf /root/b-pki/backup/"b-pki-backup-$(date +"%y-%m-%d-%H:%M:%S").tar.gz" /etc/b-pki/ >> /dev/null 2>&1
if [ $? -eq 0 ]; then
                        echo ""
                        echo ""
                        echo ""
                        echo -n "Backup Successful"
                        echo ""
                        echo ""
                        echo "#####################################################################"
                        echo "#####################################################################"
                        echo ""
                        echo "Please find the backup in following path -> /root/b-pki/backup/b-pki-backup-$(date +"%y-%m-%d-%H:%M:%S").tar.gz"
                        echo ""
                        echo "#####################################################################"
                        echo "#####################################################################"
                        echo ""
fi

}

function restore {
echo ""
echo "This will remove your current PKI"

	read -p "If agree?? type yes : " remove_pki

if [ "$remove_pki" == "yes" ]; then

	rm -rf /etc/b-pki

else
	echo ""
	echo "Exiting without deleting the folders..."
	echo ""
	echo ""
	exit 99
fi


echo ""
echo ""
echo "$(ls /root/b-pki/backup/)"
echo "-----------------------------------"
echo "   List of available backups       "
echo " Backup path: /root/b-pki/backup/  "
echo "-----------------------------------"

        read -p "Enter Filename: " file_path

echo ""

tar -xvzf $file_path --directory / 

if [ $? -eq 0 ]; then
                        echo ""
                        echo ""
                        echo "#####################################################################"
                        echo "#####################################################################"
                        echo ""
                        echo "                 RESTORE SUCCESSFULL, ENJOY B-PKI!!!                 "
                        echo ""
                        echo "#####################################################################"
                        echo "#####################################################################"
                        echo ""
else
echo ""
echo "ERROR OCCURED, PLEASE RETRY"
fi

}

function clean_backups {

rm -rf /root/b-pki/backup/*.tar.gz

echo ""
echo "Cleaning old backups..."
echo ".."
sleep 0.2
echo "..."
sleep 0.2
echo "       Cleaning done        "
echo "----------------------------"
echo ""
startup

}

function backup_restore {

echo ""
echo ""
echo "1. Backup"
echo "2. Restore"
echo "3. Clean old backups"
echo "4. Go back"
echo ""
read -p "You want to proceed with Backup or Restore, Choose one: " br
case $br in
1) backup ;;
2) restore ;;
3) clean_backups ;;
4) startup ;;
*) 
echo ""
echo ""
echo "Wrong Input"
echo ""
echo ""
backup_restore ;;
esac
exit 99
}

function list_certs_root {

echo ""
echo "1. List Valid Certificates"
echo "2. List Revoked Certificates"
echo "3. List Expired Certificates"
echo "----------------------------------"
read -p "Please choose any one option:  " list
echo "----------------------------------"
echo ""
case $list in
1)
echo ""
echo "-------------------------------------------------------------"
echo "Below are the list of Certificates issued by RootCA are valid"
echo "-------------------------------------------------------------"
echo "" 
cat /etc/b-pki/ca/root-ca/db/root-ca.db | grep -i "^[V]" ;;

2)
echo ""
echo "---------------------------------------------------------------"
echo "Below are the list of Certificates issued by RootCA are Revoked"
echo "---------------------------------------------------------------"
echo ""
cat /etc/b-pki/ca/root-ca/db/root-ca.db | grep -i "^[R]" ;;
3)
echo ""
echo "---------------------------------------------------------------"
echo "Below are the list of Certificates issued by RootCA are Expired"
echo "---------------------------------------------------------------"
echo ""
cat /etc/b-pki/ca/root-ca/db/root-ca.db | grep -i "^[E]" ;;
esac
exit 99
}

function list_certs_sign {

echo ""
echo "1. List Valid Certificates"
echo "2. List Revoked Certificates"
echo "3. List Expired Certificates"
echo "----------------------------------"
read -p "Please choose any one option: " list
echo "----------------------------------"
echo ""
case $list in
1)
echo ""
echo "-----------------------------------------------------------------"
echo "Below are the list of Certificates issued by Signing CA are valid"
echo "-----------------------------------------------------------------"
echo ""
cat /etc/b-pki/ca/signing-ca/db/signing-ca.db | grep V        ;;

2)
echo ""
echo "-------------------------------------------------------------------"
echo "Below are the list of Certificates issued by Signing CA are Revoked"
echo "-------------------------------------------------------------------"
echo ""
cat /etc/b-pki/ca/signing-ca/db/signing-ca.db | grep R        ;;
3)
echo ""
echo "-------------------------------------------------------------------"
echo "Below are the list of Certificates issued by Signing CA are Expired"
echo "-------------------------------------------------------------------"
echo ""
cat /etc/b-pki/ca/signing-ca/db/signing-ca.db | grep E        ;;
esac
exit 99
}

function rootorsign {

echo ""
echo ""
echo "1. Root CA"
echo "2. Signing CA"
echo ""
read -p "You want to check for Root CA or Signing CA:  " RS
case $RS in
1) list_certs_root ;;
2) list_certs_sign ;;
*)
echo ""
echo ""
echo "Wrong Input"
echo ""
echo ""
rootorsign
esac
exit 99
}

function revoke {

echo ""
echo ""
echo "1. Revoke Signing CA"
echo "2. Rovoke End Entity Certificates"
echo ""
read -p "Please choose the option above:   " rev
case $rev in
1) 
echo ""
echo "-------------------------------------------------------------"
echo "         YOU ARE NOW REVOKING SIGNING CA            	   "
echo "-------------------------------------------------------------"
echo ""
echo ""
read -p "ARE YOU SURE ABOUT THAT?? (type yes or you will be exited): " revokesca
if [ $revokesca != yes ]; then
echo ""
echo "WRONG INPUT !!!"
echo "..."
sleep 0.2
echo "...."
sleep 0.2
echo ".....EXITING WITHOUT REVOKING THE CERTIFICATE"
echo ""
exit 99
else
echo ""
echo ""
openssl ca \
    -config /etc/signing-ca.conf \
    -revoke /etc/b-pki/ca/signing-ca/01.pem \
    -crl_reason superseded

echo ""
echo "..."
sleep 0.2
echo "...."
sleep 0.2
echo ".....REVOKED"
echo ""
fi
;;

2) 
echo ""
echo "-------------------------------------"
echo " List of Available Certificates      "
echo "-------------------------------------"
echo "$(ls /etc/b-pki/certificates/*.crt)"
echo ""
echo ""
echo "Enter the certificate filename to revoke"
read -p "File name: " revokefile
if [ -f /etc/b-pki/certificates/$revokefile.crt ]; then
echo "---------------------------------------------------------------------"
echo "         PLEASE CHECK THE DETAILS OF CERTIFICATE BEFORE CONTINUE     "
echo "---------------------------------------------------------------------"
echo ""
echo ""
echo "$(openssl x509 -noout -subject -issuer -startdate -enddate -in /etc/b-pki/certificates/$revokefile.crt)"
echo ""
echo "---------------------------------------------------------------------"
read -p "Do you still want to proceed? (Type : yes or you will be exited: )" revokeproceed
if [ $revokeproceed == "yes" ]; then
echo ""
echo ""
openssl ca \
    -config /etc/signing-ca.conf \
    -revoke /etc/b-pki/certificates/$revokefile.crt \
    -crl_reason superseded
echo ""
echo ""
echo "..."
sleep 0.2
echo "...."
sleep 0.2
echo ".....REVOKED"
echo ""
else
echo ""
echo "..."
sleep 0.2
echo "...."
sleep 0.2
echo ".....EXITING WITHOUT REVOKING THE CERTIFICATE"
echo ""
exit 99
fi
else
echo "-------------------------------------------------------------------------"
echo "			     		ERROR!!!!!!!                           "
echo "PLEASE CHECK THE FILE NAME, YOU NEED TO ENTER ONLY FILENAME WITHOUT .crt "
echo "-------------------------------------------------------------------------"
revoke
fi
;;
*)
echo ""
echo ""
echo "Wrong Input"
echo ""
echo ""
revoke
esac
exit 99

}

## EXECUTION
function startup {
		echo "Enter your choice: "
		echo "1. Create Root CA"
		echo "2. Create Signing CA"
		echo "3. Create Server Certificate"
		echo "4. Create Email Certificate"
		echo "5. Generate ARL"
		echo "6. Generate SingingCA CRL"
		echo "7. Backup & Restore"
		echo "8. List issued Certificates"
		echo "9. Revoke a Certificate"
		echo "10. Exit"
		echo ""
		read -p "Please choose the number 1 to 10 based on your requirement: " init
#Acting on the user input

case $init in
1) check_root_ca ;;
2) check_signing_ca ;;
3) create_server ;;
4) create_email ;;
5) rootca_crl ;;
6) signingca_crl ;;
7) backup_restore ;;
8) rootorsign ;;
9) revoke ;;
10) exit 0 ;;

*) 
echo ""
echo "-----------------------------------------------------------------"
echo "Please look at the above line and choose the option correctly :@"
echo "-----------------------------------------------------------------"
echo ""
esac
exit 99 
}

copyconf
create_directories
startup

exit 0
