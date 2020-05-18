# safe-and-sound
Messing around with Python, Terraform, and Docker.

**Overview:**

Using Terraform, build out the necessary infrastructure to deploy a simple web server

*To Do*:
Implement the Docker components into Terraform.

**Contents**

*provider.tf* - AWS configuration

*iam.tf* contains configuration for IAM roles that will allow our ec2 instance to access s3.  (It's mostly copy-paste from the Terraform documentation.)

*sg.tf* creates a security group that allows us to access only from the specified IP, for security.

*s3.tf* creates a bucket and uploads our code

*ec2.tf* contains the code that creates our instance.  

*userdata.tpl* contains start-up info to get our web server code up and running.

*variables.tf* has global variables, some of which require user input.


**Instructions**

1- Obtain AWS credentials, and create an SSH key pair.

2- Download and install Terraform.

3- Clone this repo and navigate to it.

4 - Run `terraform init`, then `terraform apply`

5 - At the prompt, enter:

- Path to the public key you created

- A name for the bucket (must be unique across AWS)

- your IP address, with /32, ex. `1.2.3.4/32`

6 - After review, enter "Yes" to create the objects

7 - Terraform should output an IP address you can use to access the server.  You can SSH with the key you specified (`ubuntu` user).

8 - Wait ~3 minutes for the start-up script to complete.

9 - Navigate to OutputIP:5000  - The page should say "Welcome YOUR_IP" and provide a list of APIs (see below)
  
10 - *To Clean Up:* Simply run `terraform destroy` in both the *ec2* and *s3* folders.

**Known Issues**

IAM permissions are too permissive, allow access to all s3.  Should be limited to R/O on just the specified bucket but I had trouble getting that to be inserted.

User-data is only run at launch time.  As such, if the instance is rebooted, the python webserver will *not* automatically restart and will require manual intervention.

Code updates require re-running Terraform and destroying & recreating "perfectly good" servers.

This could be fixed by running the Python as a service and/or a Cron job that periodically checks for updates in the S3 bucket, downloading and restarting when changes are detected.  Maybe in a future version.  (Though that approach would incur downtime; running multiple backends behind a load balancer would resolve that issue.  But I think I'm getting ahead of myself...)

**Web Application - Available API calls**

Use `curl` command to access API.

*GET:*

`/` Home page, lists available APIs

`/list` List all known objects

**Below all REQUIRE 'key' argument:**

`?key=example`

*GET:*

`/getvote` Returns vote count for the specified key.

Example: 

`/getvote?key=example`

*POST:*

`/create` Creates new object.  Vote count is set to zero.

*DELETE:*

`/create` Deletes specified object

*PUT:*

`/upvote` Increment vote for specified object

`/downvote` Decrement vote for specified object

**Known Issues:**

Code is naive, only checks for the most basic possible errors and omissions.

Datastore is NOT persisted between application restarts.