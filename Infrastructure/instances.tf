# Deploy route tables for private subnets.

resource "aws_route_table" "asterisk_subnet_a_rtb" {
  vpc_id = aws_vpc.asterisk_vpc.id

  tags = {
    "Name" = "asterisk-subnet-a-rtb"
  }
}

resource "aws_route_table_association" "asterisk_subnet_a_association" {
  subnet_id      = aws_subnet.asterisk_subnet_a.id
  route_table_id = aws_route_table.asterisk_subnet_a_rtb.id
}

resource "aws_route_table" "asterisk_subnet_b_rtb" {
  vpc_id = aws_vpc.asterisk_vpc.id

  tags = {
    "Name" = "asterisk-subnet-b-rtb"
  }
}

resource "aws_route_table_association" "asterisk_subnet_b_association" {
  subnet_id      = aws_subnet.asterisk_subnet_b.id
  route_table_id = aws_route_table.asterisk_subnet_b_rtb.id
}

resource "aws_route" "asterisk_subnet_a_default_route" {
  route_table_id         = aws_route_table.asterisk_subnet_a_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.asterisk_igw.id
}

resource "aws_route" "asterisk_subnet_b_default_route" {
  route_table_id         = aws_route_table.asterisk_subnet_b_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.asterisk_igw.id
}
# Deploy instances

resource "aws_instance" "asterisk_ec2" {
  ami           = "ami-012679714dd1b539f"
  instance_type = "c6g.medium"

  availability_zone = "eu-west-1a"
  subnet_id         = aws_subnet.asterisk_subnet_a.id

  key_name = "asterisk"

  tags = {
    "Name" = "asterisk-ec2"
  }
}