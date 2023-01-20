![alt text](https://github.com/dimohh/VoIP-PBX/blob/main/logo_v1.png)
# VoIP-PBX Project
This is project for implementing open source VoIP PBX based on Asterisk. The implementation will have semi config generation automation and will be pushed in AWS as IaC. The project is created for usage in AWS. If you want to use different provider you need to edit the infrastructure files.

**Instructions**
  1. In **sip.conf.py** change variable "**selected_number**" with integer number betwenne 1 and 99 which represents the number of IP Phones you want to be created. This will generate the sip.conf which is the Asterisk config file you will need at later step.
  2. In your **AWS** account create a Cloud9 instance which will be used for the infrastructiore deplyment via Terraform.
  3. In you **AWS** account in **Network & Security>Key Pairs** create new key pair with RSA, .pem format and with name **asterisk**. Download the **.pem**      file you will need it to SSH to the EC2 istnace.
  4. Open a console to the Cloud9 instace.
  5. Copy the repository with **git clone** **https://github.com/dimohh/VoIP-PBX.git**
  6. Open directory **VoIP-PBX/Infrastructure/** 
  7. Do command **terraform init** to initialize this directory for Terraform.
  8. Do command **terraform plan** to start the planning stage.
  9. Do command **terraform apply** to apply the config.
  10. In your **AWS** account go to **EC2 Dashboard>Instances** and find the newly created instance. Click on the ID and copy the public IP.
  11. SSH to the EC2 instance with **ssh -i "<name_of_pem_file>" ubuntu@<public_IP>** . Make sure you initialize this command in termonal from the folder that conteins the **.pem** file from step 3.
  12. **Do commands:**
      - sudo su
      - nano /etc/asterisk/sip.conf
      - Copy and replace the [general] section from sip.conf file from step 1 to /etc/asterisk/sip.conf
      - Copy all the created sip phones configuretions from sip.conf from step 1. They will start with [100] for the first sip phone, [101] for the second and so on. Paste those at the bottom of /etc/asterisk/sip.conf and save.
      - asterisk -rvvv
      - sip reload
  13. Open your SIP Softphone and configure the user and password from sip.conf. Do this for every user.
  
  
  
 ![alt text](https://github.com/dimohh/VoIP-PBX/blob/main/sipsoftphone.png) 
 
