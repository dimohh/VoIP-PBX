# Deploy VPCs

resource "aws_vpc" "asterisk_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "asterisk-vpc"
  }
}

# Deploy private subnets. Those subnet should host
# resources with access to endpoints, internal networks
# and Internet.
resource "aws_subnet" "asterisk_subnet_a" {
  vpc_id            = aws_vpc.asterisk_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "asterisk-subnet-a"
  }
}

resource "aws_subnet" "asterisk_subnet_b" {
  vpc_id            = aws_vpc.asterisk_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "asterisk-subnet-a"
  }
}
# Deploy Internet gateway

resource "aws_internet_gateway" "asterisk_igw" {
  vpc_id = aws_vpc.asterisk_vpc.id
  tags = {
    Name = "asterisk-igw"
  }
}