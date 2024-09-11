# This example variable file can be used for creation of EC2 instance with additional EBS Volume  
region = "us-east-1"                # you can mention your required region
secret_key = "your_secret_key"      # you pass your access key or set it as environment variable
access_key = "your_access_key"      # you pass your secret key or set it as environment variable
hostname = "my-ec2-instance"        
ami = "your_ami_id"                 
instance_type = "t3.micro"          
vpc_id = "vpc-abcd1234"             
subnet_id = "subnet-ijkl6789"
key_name = "my-ssh-key"             
root_volume_size = 50
root_volume_type = "gp3"
is_root_volume_encrypted  = true
kms_key_id = "my-ebs-kms-key-id"
device_name = "/dev/sdb"
is_ebs_volume_encrypted = true
ebs_volume_size = 30
ebs_volume_type = "gp3"