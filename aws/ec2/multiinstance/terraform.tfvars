region = "us-east-1"            # you can mention your required region
access_key = "your-access-key"  # you pass your access key or set it as environment variable
secret_key = "your-secret-key"  # you pass your access key or set it as environment variable
# Instance configuration has different combinations of EC2 instance creation for linux and windows os type with and without additional EBS volume attachement
instance_configs = [ {
  # EC2 Linux instance with additional EBS volume attachment
  name = "instance1"
  ami = "ami-for-amazon-linux"
  instance_type = "t3-micro"                # Instance type can be changed
  subnet_id = "your-subnet-id"              # Subent id to be given
  security_groups = "your-security-group"   # Security group id to be given
  platform = "linux"                        # This option will be used to add userdata for Linux Instances
  key_name = "your-sshkey-pair"             # Your SSH key pair name to be given 
  root_block_device = [ {
    root_volume_size = 100
    root_volume_type = "gp3"                # Volume type can be given as per requirement
    is_root_volume_encrypted = true
    kms_key_id = "your-kms-key-id"          # KMS key ID to be given
  } ]
  enable_ebs = true
  ebs_block_devices = [ {
    ebs_volume_size = 30 
    ebs_volume_type = "gp3"
    ebs_kms_key_id = "your-kms-key-id"
  } ]
  tags = [{
    environment = "demo"
    project = "my-first-project"
  }]
    },{
  # EC2 Linux instance without additional EBS volume attachment
  name = "instance2"
  ami = "ami-for-amazon-linux"
  instance_type = "t3-micro"
  subnet_id = "your-subent-id"
  security_groups = "your-security-group"
  platform = "linux"
  key_name = "your-sshkey-pair"
  root_block_device = [ {
    root_volume_size = 100
    root_volume_type = "gp3"
    is_root_volume_encrypted = true
    kms_key_id = "your-kms-key-id"
  } ]
  enable_ebs = false
  ebs_block_devices = []
  tags = [{
    environment = "demo"
    project = "my-first-project"
  }]
},{
# EC2 Windows instance with additional EBS volume attachment
  name = "instance3"
  ami = "ami-for-windows"
  instance_type = "t3-micro"
  subnet_id = "your-subnet-id"
  security_groups = "your-secruity-group"
  platform = "windows"
  key_name = "your-sshkey-pair"
  root_block_device = [ {
    root_volume_size = 100
    root_volume_type = "gp3"
    is_root_volume_encrypted = true
    kms_key_id = "your-kms-key-id"
  } ]
  enable_ebs = true
  ebs_block_devices = [ {
    ebs_volume_size = 30 
    ebs_volume_type = "gp3"
    ebs_kms_key_id = "your-kms-key-id"
  } ]
  tags = [{
    environment = "demo"
    project = "my-first-project"
  }]
},{
# EC2 Windows instance without additional EBS volume attachment
  name = "instance4"
  ami = "ami-for-amazon-linux"
  instance_type = "t3-micro"
  subnet_id = "your-subnet-id"
  security_groups = "your-security-group"
  platform = "windows"
  key_name = "your-key-pair"
  root_block_device = [ {
    root_volume_size = 100
    root_volume_type = "gp3"
    is_root_volume_encrypted = true
    kms_key_id = "your-kms-key-id"
  } ]
  enable_ebs = false
  ebs_block_devices = []
  tags = [{
    environment = "demo"
    project = "my-first-project"
  }]
} ]
ebs_device_name = "/dev/sba" # You can change your ebs device name as per your requirement
ebs_volume_encrypted = true  # This option will allow ebs volume to be encrytped