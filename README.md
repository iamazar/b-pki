             ██████╗░░░░░░░██████╗░██╗░░██╗██╗
             ██╔══██╗░░░░░░██╔══██╗██║░██╔╝██║
             ██████╦╝█████╗██████╔╝█████═╝░██║
             ██╔══██╗╚════╝██╔═══╝░██╔═██╗░██║
             ██████╦╝░░░░░░██║░░░░░██║░╚██╗██║
             ╚═════╝░░░░░░░╚═╝░░░░░╚═╝░░╚═╝╚═╝ v 1.0

                   𝘽 𝙖 𝙨 𝙞 𝙘 𝙋 𝙆 𝙄
             +~+~+~+~+~+~+~+~+~+~+~+~+~

         <--mohamedazarudeen.it@gmail.com-->
          *********************************
                     RNTrust Dubai
        < ~~~ b-PKI / Created for Learning~~~>
             +~+~+~+~+~+~+~+~+~+~+~+~+~


 THIS IS THE BASIC PKI CREATED ONLY USING OPENSSL AND SHELL
         YOU CAN USE THIS SCRIPT FOR TESTING PURPOSE

Enter your choice:
1. Create Root CA
2. Create Signing CA
3. Create Server Certificate
4. Create Email Certificate
5. Generate ARL
6. Generate SingingCA CRL
7. Backup & Restore
8. List issued Certificates
9. Revoke a Certificate
10. Exit

- Please choose the number 1 to 10 based on your requirement:


Background: 
-------------------------------------------------------------------------------------------------------------------------
This b-pki is the concept developed based on this -> https://pki-tutorial.readthedocs.io/en/latest/simple/index.html


Quick start:
-------------------------------------------------------------------------------------------------------------------------
- Clone the b-pki: "git clone https://github.com/iamazar/b-pki.git" 
- Change the directory: "cd b-pki"
- Give execute permission: "chmod +x b-pki.sh"
- Execute it: "./b-pki.sh"

Detailed Instructions:
-------------------------------------------------------------------------------------------------------------------------
Before executing the script, please make sure the below:

- Script uses OpenSSL, so if you don't have install it first.
- Script needs "root-ca.conf, signing-ca.conf, email.conf, server.conf" files in the same folder "b-pki" on first time of execution.
- After first execution script will create folder and required files in the following location /etc/b-pki
- After first execution script will copy .conf files to /etc/
- If the script doesn't work properly execute it under "root".

Customize it:
--------------------------------------------------------------------------------------------------------------------------
The default settings can be customized using "root-ca.conf, signing-ca.conf, email.conf, server.conf" in the location /etc/

TODO:
--------------------------------------------------------------------------------------------------------------------------
Detailed documentation for this tool.



