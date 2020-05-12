# safe-and-sound
Interview Test

**Overview:**

Using Terraform, build out the necessary infrastructure to deploy a simple web server that return's the requester's IP address.


**Contents**

A very simple Flask (Python) webserver: *getip.py*

Two folders containing Terraform code: *s3* and *ec2*

**Instructions**

1- Obtain AWS credentials, and create an SSH key pair.

2- Download and install Terraform.

3- Clone this repo and navigate to it.

4 -Enter the *s3* folder.  

There are two files: *provider.tf* , which contains AWS configuration, and  *s3bucket.tf* , which creates a new s3 bucket and uploads our code to it.  Note: The bucket name is hard-coded.

a - Run `terraform init`, then `terraform apply`

b - At the prompt, enter the path to *getip.py* - it should be `../getip.py`

c - After review, enter "Yes" to create the bucket and upload the file.

5 - Navigate to the *ec2* folder

This folder contains 5 files.  *provider.tf* is same as before.  *iam.tf* contains configuration for IAM roles that will allow our ec2 instance to access s3.  (It's mostly copy-paste from the Terraform documentation.)  *sg.tf* creates a security group that allows us to access only from the specified IP, for security.  *ec2.tf* contains the code that creates our instance.  Finally, *userdata.sh* contains start-up info to get our web server code up and running.

a - Run `terraform init`, then `terraform apply`

b - At the prompt, enter your public key (copy it from the file you created) and your IP address, with /32, ex. `1.2.3.4/32`

c - After review, enter "Yes" to create the objects

6 - Terraform should output an IP address you can use to access the server.  You can SSH with the key you specified (ubuntu).

7 - Wait ~3 minutes for the start-up script to complete.

8 - Navigate to SimpliSafeIP:5000  - The page should say "Your IP Address is YOUR_IP"
  
9 - *To Clean Up:* Simply run `terraform destroy` in both the *ec2* and *s3* folders.

**Known Issues**

User-data is only run at launch time.  As such, if the instance is rebooted, the python webserver will *not* automatically restart and will require manual intervention.

Hard-coded:  AWS profile, bucket name, other names and tags.
